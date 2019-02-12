library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)


### Estimate optimal K
# read K error
k.error<- read.delim("../data/admixture/maices_Kerror.txt", header = F, sep = ":")
rownames(k.error)<- c("k=1", "k=2", "k=3", "k=4", "k=5")

# plot K error
e.plot<- ggplot(data=k.error, aes(x=1:5, y=V2)) + geom_point() + geom_line()
e.plot + xlab("k") + ylab("Error")

### Plot Q for K 2.

## Get meta data
samples_meta<-read.delim("../meta/maizteocintle_SNP50k_meta_extended.txt",
                         header=TRUE, sep="\t")

samples_names<-read.delim("../data/maicesArtegaetal2015.fam",
                         header=FALSE, sep=" ") %>% 
              select(., V2) %>%
              rename(., INDIV=V2)


# read Q file
Qval<-read.table(paste0("../data//admixture/maicesArtegaetal2015.3.Q"))
      names(Qval)<-paste0("K", 1:ncol(Qval))
    
# Format Q file for plotting
    # add  sample names  to Qtable
    Qval<-cbind(INDIV=samples_names$INDIV, Qval)

  # transform to long format  
    Qval_long<- gather(Qval, key=Kgroup, value=Qadmixture, 2:ncol(Qval))
    
    ## Plot
    # standar
    plt<-ggplot(Qval_long, aes(x=INDIV, y=Qadmixture, fill=Kgroup)) + geom_col() +
      theme(axis.text.x= element_blank())
    plt


### Same plot but ordering by altitude

# add altitude data
Qval<-cbind(Altitude=samples_meta$Altitud, Qval)

# transform to long format  
Qval_long<- gather(Qval, key=Kgroup, value=Qadmixture, 3:ncol(Qval))
    
# Order levels of the column that ggplot2 uses in x so
# that they are in the desired order
Qval_long$INDIV<-factor(Qval_long$INDIV, 
                        levels = Qval_long$INDIV[order(Qval$Altitud)])


## Plot
# standar
plt<-ggplot(Qval_long, aes(x=INDIV, y=Qadmixture, fill=Kgroup)) + geom_col() +
      theme(axis.text.x= element_blank())
plt
    
 

### When a loop is a good idea: 
## Plot Admixture Q for all Ks


# get Q files
x<-list.files(paste0("../data/admixture/"))
Qfile<-x[grep("*.Q", x) ]


## plot admixture for every K
for (j in 1:length(Qfile)){
  # read Q file
  Qval<-read.table(paste0("../data/admixture/", Qfile[j]))
  names(Qval)<-paste0("K", 1:ncol(Qval))
  
  # add plink sample names and Altitude  to Qtable
  Qval<-cbind(INDIV=samples_names$INDIV, Altitude=samples_meta$Altitud, Qval)
  
  # transform to long format  
  Qval_long<- gather(Qval, key=Kgroup, value=Qadmixture, 3:ncol(Qval))
  
  # Order levels of the column that ggplot2 uses in x so
  # that they are in the desired order
  Qval_long$INDIV<-factor(Qval_long$INDIV, 
                          levels = Qval_long$INDIV[order(Qval$Altitud)])
  
  
  ## Plot
  # standar
  plt<-ggplot(Qval_long, aes(x=INDIV, y=Qadmixture, fill=Kgroup)) + geom_col() +
    theme(axis.text.x= element_blank()) +
  ggtitle(paste0("Maize admixture for K=", 
                 parse_number(sub("maicesArtegaetal2015\\." , "", Qfile[j]))))
  
 print(plt)

}



