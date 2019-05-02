# Create Annotation file

# NOTE: this scripts depends on R v2.13

# Preliminaries
# =============

## Define some constants (it is a good practice to declare them at the beginning of the scripts)
annot_file <- "MouseRef-8_annot.txt" # file.path() is a robust way to define file paths

# Readin raw data
# ====== === ====
Data.Raw  <- read.delim("Illum_data_sample.txt")

# Probe Annotations
source("Rfxs.R")
load.package("org.Mm.eg.db", bioC=T)
load.package("illuminaMousev2.db", bioC=T)

# To list all objects available from the package, type
# ls("package:illuminaMousev2.db")
# And to get a short description of object type
#help(package="illuminaMousev2.db")

# Lets get a table with ReMOAT annotations for each probe.
annot <- illuminaMousev2fullReannotation()

# The annot object contains 46237 probes for the MouseWG-6 v2 which is a superset 
# of Mouse-Ref8 v2, so wee need to select only the probes that are in the latter.
# In addition, in this tutorial we are working with a subset ot 5000 probes, so we
# need to select those probes from the annotation table.
out_cols <-c("IlluminaID", "ProbeSequence", "ProbeQuality", "CodingZone",  "ContainsSNP",
             "EntrezReannotated", "EnsemblReannotated")

annot <- annot[match(Data.Raw$PROBE_ID, annot$IlluminaID), out_cols]

colnames(annot) <- c("ProbeID", "Sequence", "ProbeQuality", "CodingZone", "SNPs", "EntrezID", "Ensembl")

# Add a gene symbol from the org.Mm.eg.db package (EntrezGene-centered mouse database).
is_annot <- !is.na(annot$EntrezID)
annot$Symbol[is_annot] <- unlist(mget(annot$EntrezID[is_annot], org.Mm.egSYMBOL, ifnotfound=NA))

# Export annotation table for later use.
write.table(annot, file=annot_file, quote=F, row.names=F, sep="\t")
