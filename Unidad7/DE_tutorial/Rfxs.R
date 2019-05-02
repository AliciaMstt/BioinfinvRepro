# R functions necessary for the DE tutorial

logdiff2FC=function(x, base=2) {
  # Transforms x from a log difference (logdiff) to a fold change (FC) scale
  # logdiff is the expression difference in log scale of base = 'base'
  # FC is the ratio between two expression values in the original scale
  # The absolute value of the returned FC is always greater than or equal to 1
  # The sign is kept to indicate direction of change
  # When the the log difference is 0, the FC is always 1.
  signs = sign(x)
  out   = base^abs(x)
  if(any(x==0)) {
    out[x==0] = 1
  }
  return(out*signs)
} # logdiff2FC

load.package <- function(name, bioC=FALSE) {
  status <- "loaded"
  if(is.character(name)) {
    namechar <- name
  } else {
    namechar <- deparse(substitute(name))
  }
  
  if(!require(namechar, character.only = TRUE)) {
     if(bioC) {
       source("http://bioconductor.org/biocLite.R")
       biocLite(namechar)
       if(!require(namechar, character.only = TRUE)) {
         stop("Package '", namechar, "' coud not be installed.")
       }
     } else {
       install.packages(namechar)
       if(!require(namechar, character.only = TRUE)) {
         stop("Package '", namechar, "' coud not be installed.")
       }
     }
     status <- "installed"
  }
  invisible(status)
} # load.package
