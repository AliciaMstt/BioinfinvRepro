read.fst_summary_fix <- function(file, popNames){
    ### Function to read the Stacks populations output file batch_1.fst_summary.tsv and add PopNames to it
    # it also adds a 0 diagonal and converts it to a symmetric matrix
    # file = path to batch_1.fst_summary.tsv file
    # popNames = vector with population names in the same order than PopID in the file 
    
    ### Get data
    Fstmat<-data.matrix(read.delim(file = file, row.names=1, fill=TRUE)) 
    # add col names
    colnames(Fstmat)<- popNames 
    Fstmat 
  
  ## Fix
  x<-Fstmat
  # add an extrarow
  x <- rbind(x, n=NA)
  # Change rownames to col names
  rownames(x)<-colnames(x)
  # add 0 diagonal
  x[is.na(x)] <- 0
  # make symmetrical matrix
  x <- x + t(x)
  Fstmat <-x
  Fstmat
  }
  