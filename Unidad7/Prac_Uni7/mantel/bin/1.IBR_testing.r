## Alicia Mastretta Yanes
## Perform Mantel tests with different resistance surfaces to test for IBR in B. alpina

# start with a fresh brain
rm(list = ls())

# Load libraries
library(ade4)
library(ggplot2)
library(sp)

########### Get data  ###############
## Source home made funcs to load data
source("read.fst_summary_fix.R")
source("read.effdist.R")

### Geographic ###

# For reference, get Population ID codes as used for Circuitscape and Map plotting
# this is not the same order than PopuplationMaps used for Stacks. Careful. 
points.info<-read.delim("../spatial/surveyed_mountains.tsv")
points.info
points.infoxy<-as.matrix(points.info[,c(5,6)], longlat=TRUE)

# Get geographic distances
GeoDist<-spDists(points.infoxy, ) 
colnames(GeoDist)<-points.info$Key
rownames(GeoDist)<-points.info$Key

### define paths for loading data
genfolder<-"../genetic"
circfolder<-"../spatial/resdist"

### Genetic ###

## define pop names as in Stack population maps 
# check pop map order
readLines(paste0(genfolder, "/BerSS.sumstats.tsv"), n=6)
# define popNames
popNames=c("Aj","Iz","Ma","Pe","Tl","To") 

## Get Fst pairwise matrix
  B.Fst <-read.fst_summary_fix(file=paste0(genfolder, "/BerSS.fst_summary.tsv"),
                         popNames=popNames)   


### Effective distances ###

### Get general info and paths
  ## define pop names as in Circuitscape focal points order 
  # get focal points
  focpoints<-read.delim(paste0(circfolder, "/Balpina_focalpoints.txt"), header=FALSE)
  # get info of focal points
  x<-points.info$ID %in% focpoints[,1] 
  focpoints<- points.info[x,] 
  # get PopNames in order of focal points
  popNamesFP<-as.vector(focpoints$Key)
  popNamesFP
  # get PopNames in order of Stacks output PopMap
  popNames=popNames
  popNames
 

### Get effective distance matrix and mean of it for each raster 

  for(i in c("present", "ccsm", "miroc", "flat", "1800", "2000", "2300", "2500", "2700", "3000", "3300", "3500", "4000")) {
    
    ## define resistances.out files
    resfile <- paste0(circfolder, "/Balpina_", i, "_resistances.out")
      
    ### Get effective distances
    
    eff.dist<-read.effdist(file=resfile, popNames=popNamesFP, des.order=popNames)
    
    ### Estimate mean effective distance by population
    mean.effD <- apply(eff.dist, 2, mean)  
      
    ### Name output data
    assign(paste0("B.", i), eff.dist)  # effective distance mat
    assign(paste0("B.mean.", i), mean.effD) # mean effective distances
  
  }    
    
### Get Geographic distances for this spp localities
B.GeoDist<-GeoDist[match(popNames,rownames(GeoDist)), match(popNames,colnames(GeoDist))] #get right order
B.GeoDist


###########  Isolation by Resistance ###############

##### Perform Mantel test between the Fst matrix and the present and LGM effective distances
# function for lm and plotting
source("DistPlot.R")


### Berberis
  # Linearize as suggested by Rousset (1997) for IBD using FST/(1 ??? FST)
  B.FstLin<- B.Fst/(1-B.Fst)
  
  # run mantel test for each condition
IBRresults<-c("rster", "MTpvalue", "MTr")
  for(i in c("present", "ccsm", "miroc", "flat", "1800", "2000", "2300", "2500", "2700", "3000", "3300", "3500", "4000")) {
  
    print(paste("Results for", i))
    
    # Mantel test 
    print("Mantel test")
    x<-mantel.rtest(as.dist(get(paste0("B.",i))), as.dist(B.FstLin), nrepet=10000)
    print(x)
    
    # Plot
    DistPlot(get(paste0("B.",i)), B.FstLin, plotnames=FALSE,
            ylabel=expression("F"[ST]*"/(1 ??? "[FST]*")"), xlabel=paste("Effective distance", i))
               
    # get info for df  
    MTpvalue<-round(x$pvalue, 6)
    MTr<-round(x$obs, 4)
    
    # put results in dataframe
    rster<-paste(i)
    IBRresults<-rbind(IBRresults, c(rster, MTpvalue, MTr))
  } 

IBRresults

## session info
sessionInfo()