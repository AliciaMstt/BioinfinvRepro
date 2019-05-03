###########################################
# Testing Differential Expression Testing
# ======= ============ ========== =======
#
#           Ricardo A. Verdugo
#
#                  2011
#
# Data description
# ---- -----------
# 
# This is an expression profile experiment done in the
# Illumina Mouse-Ref8 platform.
#
# Objective: To assess the effect of genetic variation
# in mouse chromosome Y on the size of cardiomyocytes.
# 
# Experimental design: Eight adult male mice from 
# two strains were profiled, C57BL/6J and 
# C57BL/6J-chrY<A/J/NaJ>, referred to as B and BY herein.
# From each strain (genotype), four animals were 
# castrated and four were sham operated. RNA was hybridized
# to Illumina MouseRef-8 v2.0 Bead-Chips that carry eight
# microarrays each, containing 25,697 probes. Only 5000 probes
# were arbitrarily selected for this tutorial. 
#
# Aims: 
#       1) To determine differential expression between genotypes
#       2) To determine differential expression between treatments
#       3) To assess differences in the response to treatment between
#          the two genotypes
#
# References:
#
# For more information about the experimental samples:
#   Llamas, Bastien, Ricardo Verdugo, Gary Churchill, and Christian Deschepper. 2009.
#   Chromosome Y variants from different inbred mouse strains are linked to differences in the
#   morphologic and molecular responses of cardiac cells to postpubertal testosterone. BMC
#   Genomics 10, no. 1 (April 7): 150. doi:10.1186/1471-2164-10-150.
# 
# For informations about the analysis of this data: Verdugo, Ricardo A., Christian F.
#   Deschepper, Gloria Munoz, Daniel Pomp, and Gary A. Churchill. 2009. Importance of
#   randomization in microarray experimental designs with Illumina platforms. Nucl. Acids Res.
#   37, no. 17 (September): 5610-8. doi:10.1093/nar/gkp573.
# 
# To speed up the tutorial, only the first 5000 of the probes in the microarray
# are included. The full dataset is available from the GEO database by id GSE15354.
# http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15354


# Preliminaries
# =============

## Define some constants (it is a good practice to declare them at the beginning of the scripts)
outdir     <- "output"
fdr_th     <- 0.2 # Proportion of false discoveries that are acceptable

# Define some useful functions (it is a good idea to always document what the intend to do)
source("Rfxs.R")

# Create an output directory
if(!file.exists(outdir)) {
  dir.create(outdir, mode = "0755", recursive=T)
}

# Read microarray data in Illumina format
# ==== ========== ==== == ======== ======
Data.Raw  <- read.delim("Illum_data_sample.txt")
signal    <- grep("AVG_Signal", colnames(Data.Raw)) # vector of columns with data
detection <- grep("Detection.Pval", colnames(Data.Raw)) # vector of columns with p-values

# Read probe annotations
# ==== ===== ===========
annot     <- read.delim("MouseRef-8_annot.txt")
# Make sure that probes are in same order as in the dataset
annot <- annot[match(Data.Raw$ProbeID, annot$IlluminaID), ]
# Not all probes have the same quality from sequence alignment to the genome.
table(annot$ProbeQuality)
# We will group 'Bad' with 'No match' as bad and everything else as good.
# For details see Nucleic Acids Res. 38:e17
probe_qc <- ifelse(annot$ProbeQuality %in% c("Bad", "No match"), "Bad probes", "Good probes")

# Read hybridization design
# ==== ============= ======
design <- read.csv("YChrom_design.csv")
# Lets take a look
print(design)

# Quality Control
# ======= =======

# Boxplots
palette(rainbow(4))
alabel <- sprintf("Array%02i", 1:length(signal))
afact  <- factor(rep(alabel, each=nrow(Data.Raw)))
qcfact <- factor(rep(probe_qc, length(signal)))

# Color by genotype
png(file.path(outdir,"boxplot_raw_probe_qc.png"), width=6, height=3, unit="in", res=150)
  par(xpd=NA, mar= c(6.1, 4.1, 4.1, 2.1), cex=.7, las=3)
  boxplot(unlist(log2(Data.Raw[,signal]))~qcfact+afact, horiz=T, main="Raw log2 values Boxplot",
          col=rep(1:2, length(signal)), axes=F, varwidth=TRUE, ylab="log2(intensity)")
  axis(1, at=seq(1, length(signal)*2, by=2)+.5, labels=alabel)
  axis(2)
  legend("top", legend=levels(qcfact), fill=1:2, ncol=2, xjust=.5, bty="n", inset=-.15)
dev.off()

# Color by treatment
png(file.path(outdir,"boxplot_raw_treatment.png"), width=4, height=3, unit="in", res=150)
  par(xpd=NA, mar= c(6.1, 4.1, 4.1, 2.1), cex=.7)
  boxplot(as.data.frame(log2(Data.Raw[,signal])), horiz=T, main="Raw log2 values Boxplot", las=1,
          col=design$Treatment, names=design$Sentrix_Position, cex.axis=.9,
          xlab="Sentrix position", ylab="log2(intensity)")
  legend("top", legend=levels(design$Treatment), fill=1:2, ncol=2, xjust=.5, bty="n", inset=-.15)
dev.off()

# Scatter plots of raw data in log2 scale.
png(file.path(outdir,"Pairs_scatter_log2.png"), width=8, height=8, unit="in", res=150)
  par(cex=.2, mar=c(2.1,2.1,2.1,1.1))
  pairs(log2(Data.Raw[,signal]), main="Log2 Raw Intensity Values", pch=".",  gap=.5, cex.labels=.5)
dev.off()

# Probe filtering by QC
# ===== ========= == ==
# Since probe with bad score tend to have a lower signal than good probes, it is 
# recommended to remove them. 4706 probes are left in the dataset.
Data.Raw <- Data.Raw[probe_qc %in% "Good probes",]
annot    <- annot[probe_qc %in% "Good probes",]

# Create matrix of raw data
# ====== ====== == === ====
rawdata           <- as.matrix(Data.Raw[,signal])
rownames(rawdata) <- Data.Raw$PROBE_ID
colnames(rawdata) <- design$Sample_Name


# Data Normalization
# ==== =============

# Load functions for normalization
library(preprocessCore)

normdata           <- normalize.quantiles(rawdata) 
colnames(normdata) <- colnames(rawdata)
rownames(normdata) <- rownames(rawdata)


# Probe Filtering
# ===== =========
# This step aims to removing probes that did not detect a transcript
# in any of the experimental groups. Note that this step can be optional.
#
# Create a vector or P/A calls for each probe using detection probabilities calculated by BeadStudio
probe_present      <- Data.Raw[,detection] < 0.04
detected_per_group <- t(apply(probe_present, 1, tapply, design$Group, sum))
present  <- apply(detected_per_group >= 2, 1, any)
normdata <- normdata[present,]
annot    <- annot[present, ]

# Testing for differential expression
# ======= === ============ ==========

# Load the MAanova package
library(maanova)

# Create a madata object which only includes present detected transcripts
madata <- read.madata(normdata, design, log.trans=T)

# Fit the model
fit.fix <- fitmaanova(madata, formula=~Group)

# Some basis statistics on each experimental group.
Means           <- t(apply(madata$data, 1, tapply, design$Group, mean)) 
colnames(Means) <- paste("Mean", colnames(Means), sep=":")
SEs             <- t(apply(madata$data, 1, tapply, design$Group, function(x) sqrt(var(x)/length(x))))
colnames(SEs)   <- paste("SE", colnames(SEs), sep=":")

# Construct a matrix of contrastas of interest
# --------------------------------------------
# In factorial design like this one, one can ask different questions from the data. Each
# question can be tested by a comparison between some set of experimental groups. These
# comparisons are called contrasts. The matest function from MAanova can take a matrix 
# of contrasts and test whether those comparisons explain a significant proportion of variance
# in the expression levels measured by each probe.
#
# But, before we create our matrix of contrasts, lets define some terms to simplify nomenclature.
# Let,
# I      : intact (not castrated) treatment
# C      : castrated treatment
# B      : C57BL/6J genotype
# B.Y    : C57BL/6J-chrY<A> genotype (chromosome Y congenic strain on a C57BL/6J genomic background)
# Geno   : genotype 
# Trt    : treatment
# Int    : genotype x treatment interaction
# Geno_I : genotype effect in I animals
# Geno_C : genotype effect in C animals
# Trt_B  : treatment effect in the B genotype
# Trt_BY : treatment effect in the B.Y genotype
#
# Then the four experimental groups can be denoted by B.C, B.I, BY.C, and BY.I.
# 
# Contrasts are vectors of coefficients that when multiplied to the vector of means by
# experimental group, create comparisons that relevant and that can be tested statistically.
# To create the vector of contrast coefficients, assume the experimental groups are sorted
# alphabetically.
# 
# Now, construct a matrix of contrasts where rows are contrasts and columns are experimental
# groups:
#                          B.C  B.I BY.C BY.I
cmat <- rbind(Geno     =  c( 1,   1,  -1,  -1 )*.5,
              Trt      =  c( 1,  -1,   1,  -1 )*.5,
              Int      =  c( 1,  -1,  -1,   1 ),
              Geno_I   =  c( 0,   1,   0,  -1 ),
              Geno_C   =  c( 1,   0,  -1,   0 ),
              Trt_B    =  c( 1,  -1,   0,   0 ),
              Trt_BY   =  c( 0,   0,   1,  -1 ),
              B.C_BY.I =  c( 1,   0,   0,  -1 ),
              B.I_BY.C =  c( 0,   1,  -1,   0 ))
              
# We can use these contrasts for calculate some ratios (fold changes)
# that can be of interest.

logDiffs  <- Means %*% t(cmat)

# Transform log differences to FC scale
FC <- apply(logDiffs, 2, logdiff2FC)

# Test each contrast using 200 permutations of sample labels
test.cmat <- matest(madata, fit.fix, term="Group", Contrast=cmat, n.perm=200, test.type = "ttest",
                 shuffle.method="sample", verbose=TRUE)

# Contrasts names are not kept in the matrix of permutation results, so lets 
# copy them from the matrix of tabular p-values
colnames(test.cmat$Fs$Pvalperm) <- colnames(test.cmat$Fs$Ptab)

# Plot p-values comparing different ways of calculating them (see ?matest)
png(file.path(outdir,"P-values Hist.png"), width=6, height=4, unit="in", res=150)
  par(mfrow=c(2,2), oma=c(2,0,0,0), cex=.7, xpd=NA, mar=c(5,4,2,1))
  palette(rainbow(3))
  plot(density(test.cmat$F1$Ptab[,1]), col=1, main="F1:Ptab", lwd=2)
  lines(density(test.cmat$F1$Ptab[,2]), col=2, lwd=2)
  lines(density(test.cmat$F1$Ptab[,3]), col=3, lwd=2)
  
  plot(density(test.cmat$F1$Pvalperm[,1]), col=1, main="F1:Pvalperm", lwd=2)
  lines(density(test.cmat$F1$Pvalperm[,2]), col=2, lwd=2)
  lines(density(test.cmat$F1$Pvalperm[,3]), col=3, lwd=2)
  
  plot(density(test.cmat$Fs$Ptab[,1]), col=1, main="Fs:Ptab", lwd=2)
  lines(density(test.cmat$Fs$Ptab[,2]), col=2, lwd=2)
  lines(density(test.cmat$Fs$Ptab[,3]), col=3, lwd=2)
  
  plot(density(test.cmat$Fs$Pvalperm[,1]), col=1, main="Fs:Pvalperm", lwd=2)
  lines(density(test.cmat$Fs$Pvalperm[,2]), col=2, lwd=2)
  lines(density(test.cmat$Fs$Pvalperm[,3]), col=3, lwd=2)
  
  legend(-.5, -2, legend=c("Geno", "Trt", "Int"), col=1:3, lwd=2, xjust=.5, ncol=3,
         xpd=NA, bty="n")
dev.off()


# Multiple comparison control (FDR transformation, see ?adjPval)
test.cmat <- adjPval(test.cmat, method="adaptive")

# Summarize into a table of results for all present transcripts
# Here we are exporting only the tests from the permutations on the F values with shrinkage variance estimates,
results <- data.frame(annot, Means, SEs,
                  F_val=test.cmat$Fs$Fobs, P_val=test.cmat$Fs$Pvalperm, 
                  FDR=test.cmat$Fs$adjPvalperm, FC=FC)

# Export all results
write.table(results, file=file.path(outdir,"DE_results.csv"), sep=",", row.names=F)


# Count genes differentially expressed
# ----- ----- -------------- ---------
# In this experiment, a question of interest was how many genes respond differently to the
# treatment of castration in the two genotypes. In other words, how important is the
# interaction between genotype and treatment. Secondly, it was interesting to assess the
# nature of the interaction. Are both genotypes responding to the treatment but in opposite
# directions? Or does the treatment have an effect in one of genotype and not in the other?
# To answer the first question, one could count the number of probes that show a significant
# effect for the Int contrast, i.e. how many probes have an FDR below a threshold for the
# Int.Pvalperm test? If you don;t know how to calculate this in R yet, open the exported
# DE_results.csv file in a spread sheet editor such as Calc (OpenOffice)
# and use filters to calculate this number. Then try to do this in R and compare the
# results.
# 
# To answer the second question, we can use Venn Diagrams. We want to count the number if
# genes that are selected in each genotype among those that show a significant interaction
# effect.
# 
# One caveat is that genes are represented by multiple probes in this microarray platform.
# It is a good idea to count genes only once, but there is a question of how to count a gene
# when different probes are giving different signals, i.e. one is saying that the gene is
# selected whereas the other is saying that is not. This platform was based RefSeq
# (http://www.ncbi.nlm.nih.gov/RefSeq/), which is a human-curated database of reference
# transcripts for known genes and it was designed to avoid redundancy
# (http://www.illumina.com/products/mouseref-8_expression_beadchip_kits_v2.ilmn). Therefore,
# we will assume that each probe is testing different biological signals, and not a repeated
# measure of the same transcript. We will count a gene as selected if any of it transcripts
# (probes) is selected. For other platforms where probes provide repeated measurements for
# the same transcript, one may want to use a voting or averaging approach to summarize
# results at the gene-level.
#
# The second issue to consider is what to do with un-annotated probes, i.e. those that
# that cannot be annotated to any gene in the EntrezGene database. Here we will consider 
# each of them as a separate gene, although in a real application, one may want to improve
# the gene annotation by using alternative sources such as the Ensembl or UCSC Genome Browser
# databases.
# 
# First, create a gene id based on EntrezGene
results$GeneID <- results$EntrezID
# and then use probe ID whenever no gene ID is available
results$GeneID[is.na(results$GeneID)] <- results$ProbeID[is.na(results$GeneID)]

# Count probes selected for DE by Genotype, Treatment, and/or Interaction. The Genotype
# contrast tests differences between genotypes across treatments and viceversa. The Interaction
# contrast tests whether the differences between genotypes depend on treatment and viceversa.
Probes.DE <- results[, c("FDR.Geno", "FDR.Trt", "FDR.Int")]  <= fdr_th
# Summarize by gene. A gene is selected if any transcript is selected.
Genes.DE  <- apply(Probes.DE, 2, tapply, results$GeneID, any)

# Now count significant genes for specific comparisons to determine the direction of differences
# when the Interaction is significant. Because were are interested in genes that show an interaction,
# we cannot the the Geno contrast, since that contrast tests the marginal effect of 
# the genotype across treatments. In other words, it tests for effects that are consistent in both
# treatments. These can be zero even if the genotype has an effect in both treatments but those effects 
# have opposite signs. The same situation is true for testing treatment effects in probes with
# significant interaction. Therefore, we need to use the contrasts that tested genotype 
# differences within each level of treatment, and viceversa.

# Using only probes selected for Interaction effects, count probes significant for Genotype in I and/or C
Probes.Int_Geno <- results[results$FDR.Int <= fdr_th, c("FDR.Geno_I", "FDR.Geno_C")] <= fdr_th
# Summarize by gene. A gene is selected if any transcript is selected.
Genes.Int_Geno <- apply(Probes.Int_Geno, 2, tapply, results$GeneID[results$FDR.Int <= fdr_th], any)

# Using only probes selected for Interaction effects, count probes significant for Treatment in B and/or BY
Probes.Int_Trt  <- results[results$FDR.Int <= fdr_th, c("FDR.Trt_B", "FDR.Trt_BY")]  <= fdr_th
# Summarize by gene. A gene is selected if any transcript is selected.
Genes.Int_Trt  <- apply(Probes.Int_Trt, 2, tapply, results$GeneID[results$FDR.Int <= fdr_th], any)

# Load the limma library for creating Venn diagrams
library(limma)

# Count genes for each compartment of the Venn diagram
Counts.DE <- vennCounts(Genes.DE)
print(Counts.DE)

Counts.Int_Geno <- vennCounts(Genes.Int_Geno)
print(Counts.Int_Geno)

Counts.Int_Trt  <- vennCounts(Genes.Int_Trt) 
print(Counts.Int_Trt)

# Plot genes DE by marginal or interaction effects
png(file.path(outdir, "vennDiagram_DiffExprs.png"), width=3.5, height=3, unit="in", res=150)
  par(cex=.7)
  vennDiagram(Counts.DE, names=c("Geno", "Trt", "Int"), 
              main="\n\n\nDifferentially Expressed Genes")
dev.off()

# Plot genes responding to genotype in a treatment dependent manner
png(file.path(outdir, "vennDiagram_Int.png"), width=6.5, height=3, unit="in", res=150)
  par(mfrow=c(1,2), cex=.7)
  vennDiagram(Counts.Int_Geno, names=c("I", "C"), 
              main="\n\n\nGenes Responding to Genotype\nin a Treatment Dependent Manner")
  vennDiagram(Counts.Int_Trt, names=c("B", "BY"),
              main="\n\n\nGenes Responding to Treatment\nin a Genotype Dependent Manner")
dev.off()

# Interpretation of the Venn diagrams:
#
# In theory, both plots are showing the same test in two different ways, i.e. the number of
# genes with interaction effects, but partitioned either by treatment or by genotype.
# Because in practice we are showing results from four different (but related) tests, the
# total number of selected genes in each diagram is not exactly the same, but they should
# largely agree.
# 
# Although the numbers here are small because we used only a small sample or probes, you
# will see that more genes are responding to the treatment in the BY genotype. Also, you
# should see more differences between genotypes in the castrated animals. This was the
# pattern observed in the full dataset. See Figure 4 of Llamas et al 2008 (reference above).
# 

# Functional testing
library("topGO")

# Unannotated probes cannot be used for enrichment analysis so lets remove them
results   <- results[!is.na(results$EntrezID),]

# Probes selected by interaction
probes.int <- results[, "FDR.Int"]  <= fdr_th

# Summarize by gene. A gene is selected if any transcript is selected.
genes.int <- tapply(probes.int, results$EntrezID, any)

# Convert from logical to vector of 0 (not selected) or 1 (selected)
genes.int <- ifelse(genes.int, 1, 0)

# Convert to a factor
genes.int <- as.factor(genes.int)

# build topGO data objects
GOdata <- new("topGOdata", ontology="BP", description="Genes DE by Trt by Geno Interaction",
               allGenes=genes.int, nodeSize=5, annotationFun=annFUN.org,
                   mapping="org.Mm.eg.db", ID="entrez")

resultFisher.classic <- runTest(GOdata, algorithm = "classic", statistic = "fisher")
resultFisher.elim    <- runTest(GOdata, algorithm = "elim", statistic = "fisher")

GO_BP_Table <- GenTable(GOdata, Fisher.classic=resultFisher.classic, Fisher.elim=resultFisher.elim, 
                        orderBy = "Fisher.elim", ranksOf = "Fisher.classic",
                        topNodes = 20)

print(GO_BP_Table)

# Export table of top GO terms
write.table(GO_BP_Table, file.path(outdir, "GO_BP_Table.csv"), sep=",", row.names=F)

# The results of the GO term enrichment analysis are for demonstration purposes only. This
# tutorial was performed on an arbitrary list of 5000 probes, and therefore the P values
# can be quite high and do not represent the set of BP terms enriched in the full data set.

# Congratulations! You have completed this tutorial. Now you can use this script as a
# template and modify it for your own datasets. But first, I recommend you standing up and
# stretching a little. Data analyses can be addictive. Use with care.

