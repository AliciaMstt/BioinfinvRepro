read.effdist<-function(file, npop, popNames, des.order){
  ### Function to read the pairwise resistance distance of Circuitscape 
  ### and ordering the cols and rows by a desired order
  # file = path to _resistances.out file
  # popNames = vector with population names in the same order than the populations in the file 
  # des.order = vector with pop. names in desired order
  
  ### Get data
  # read file
  data<-read.table(file = file, header=TRUE, row.names=1)
  ### Transform it
  # change colnames and rows to popNames
  rownames(data)<-popNames
  colnames(data)<-popNames
  # Order cols and rows by desired order
  des.order
  o<-order(factor(popNames,levels = des.order))
  x<-data[ ,o]
  x<-x[o, ]
  # return data
  as.matrix(x)
}