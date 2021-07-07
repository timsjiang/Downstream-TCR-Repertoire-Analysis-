
library(tidyverse)

#add names to each of the datasets
  for(i in 1:length(list.allDistincts)){
    list.allDistincts[[i]]<-list.allDistincts[[i]] %>% mutate(treatment=names(list.allDistincts)[[i]])
  }

#combine all into one dataset
allDistincts<-do.call(rbind, list.allDistincts)

#filter for only those with C.mast in it 
cmast.exp<-allDistincts %>% filter(grepl("CM", treatment))%>% group_by(CombinedDGSequence)%>% summarize(count=sum(count))
#filter for only those with lipid in it
lipid.exp<-allDistincts %>% filter(grepl("lipid", treatment))%>% group_by(CombinedDGSequence)%>% summarize(count=sum(count))
#filter for only those with PBS in it
pbs.exp<-allDistincts%>% filter(grepl("PBS", treatment))%>%group_by(CombinedDGSequence)%>% summarize(count=sum(count))

#filter for CMast + CJ
cmast.cj.exp<-allDistincts%>% filter(grepl("CM.CJ", treatment))%>%group_by(CombinedDGSequence)%>% summarize(count=sum(count))
#filter for  CMast + LN
cmast.ln.exp<-allDistincts%>% filter(grepl("CM.LN", treatment))%>%group_by(CombinedDGSequence)%>% summarize(count=sum(count))

#filter for Lipid + LN
lipid.ln.exp<-allDistincts%>%filter(treatment=="D.lipid.LN")%>%group_by(CombinedDGSequence)%>% summarize(count=sum(count))
