library(tidyverse)

#finding distincts loop
list.allDistincts<-list()
for(i in 1:6){
  #find distinct TCR's 
 list.allDistincts[[i]]<-list.allData[[i]]%>% group_by(delta.u, gamma.u.1) %>% summarise(count=n())

  #Merge all tcr designators into one column
 list.allDistincts[[i]]<-list.allDistincts[[i]] %>% unite('CombinedDGSequence', 1:2, remove=T)

  #Lump together any sequence that has less than 5 occurrences into Unique Category
 list.allDistincts[[i]]<-list.allDistincts[[i]] %>% 
   mutate(CombinedDGSequence = fct_lump_min(CombinedDGSequence, 2, count, other_level = "Unique")) %>% 
    count(CombinedDGSequence, wt = count, name = "count")
}
directory<-getwd()
#arrange dataframes so that Unique is the first factor
for(i in 1:6){
 list.allDistincts[[i]]<-list.allDistincts[[i]] %>% arrange(desc(CombinedDGSequence))
}

#name dataframes in list.allDistincts
names(list.allDistincts)<-c("D.CM.LN", "D.lipid.LN", "D.PBS.LN", "D.PBS.CJ", "D.CM.CJ", "D.lipid.CJ")
#print list to environment
list2env(list.allDistincts,envir = .GlobalEnv)


#export to folder
for(i in 1:length(list.allDistincts)){
  write.csv(list.allDistincts[[i]], paste0(names(list.allDistincts)[[i]],".csv"))
}






