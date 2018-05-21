DistPlot<-function(Dist, GenDist, ylabel, xlabel, plotnames) {
  # plot Dist vs GenDist from two distance symmetric matrices 
  # Dist = x distance symmetric matrix
  # GenDist genetic distance symmetric matrix (GenDist or so)
  # ylabel= title for y axis
  # xlabel= title for x axis
  # plotnames = logical, if TRUE P1 and P2 show next to points, default TRUE
  
  if (missing(plotnames)) {plotnames=TRUE}
  
  # transform to triangular pairwise mat
  Dist[lower.tri(Dist)]<-NA
  Dist[Dist==0]<-NA
  Dist<-Dist[c(1:nrow(Dist)-1),c(2:ncol(Dist))]
  GenDist[lower.tri(GenDist)]<-NA
  GenDist[GenDist==0]<-NA
  GenDist<-GenDist[c(1:nrow(GenDist)-1),c(2:ncol(GenDist))]
  
  
  #transform matrices to 3 cols table and extract desired data
  P1<-as.vector(as.data.frame(as.table(Dist))[,1])
  P2<-as.vector(as.data.frame(as.table(Dist))[,2])
  Dist<-as.numeric(as.data.frame(as.table(Dist))[,3])
  GenDist<-as.numeric(as.data.frame(as.table(GenDist))[,3])
  
  # put into a df and remove NA
  df<-as.data.frame(cbind(P1, P2, Dist, GenDist), stringsAsFactors=FALSE)
  df<-df[!is.na(df$Dist),]
  df$Dist<-as.numeric(df$Dist) #have numbers as numbers...
  df$GenDist<-as.numeric(df$GenDist)
  
  # plot
  plt <- ggplot(data = df, aes(x = Dist, y = GenDist)) + geom_point() + theme_bw() + 
    xlab(xlabel) + ylab(ylabel) + theme(axis.text = element_text(size = 13)) 
    
  ## Fit line 
  plt <- plt + geom_smooth(method = "lm", se = FALSE, color = "black", formula = y ~ x)
  

  if(plotnames==TRUE){
                plt<-plt + geom_text(aes(label=P1), hjust=0, vjust=0, size=4) + geom_text(aes(label=P2), hjust=0, vjust=-1, size=4) 
                print(plt)
                
                } else { print(plt) }
  
  
  # Get lm summary
  lmdf <- lm(GenDist ~ Dist, df)
  print(anova(lmdf))
  print(summary(lmdf))
}