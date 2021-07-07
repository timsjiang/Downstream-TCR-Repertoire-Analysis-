dev.off
library(scales)
library(gridExtra)
#create plots for every all datasets
list.allPlots<-list()
for(i in seq(length(list.allData))){
  list.allPlots[[i]]<-ggplot(list.allDistincts[[i]], aes(y=count, x=CombinedDGSequence, fill=CombinedDGSequence)) + 
    geom_bar(stat="identity", show.legend=FALSE)+
    ggtitle(names(list.allDistincts)[i]) +
    theme(axis.title.x=element_blank(),
         axis.text.x=element_blank(),
         axis.ticks.x=element_blank())
  
  
}
#name plots
names(list.allPlots)<-c("CM.LN", "lipid.LN", "PBS.LN", "PBS.CJ", "CM.CJ", "lipid.CJ")
#export plots from list into environment 
list2env(list.allPlots,envir = .GlobalEnv)

#plot all plots 
grid.arrange(CM.LN, lipid.LN, PBS.LN, PBS.CJ, CM.CJ, lipid.CJ)f