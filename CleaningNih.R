#load packages
library(tidyverse)
library(fs)
library(forcats)


#load data
P1<-read.csv("/Users/timsjiang/Downloads/NIH SeqData/P1_paired.csv", header=T, sep=",")

#load data via loop
file_paths<- fs::dir_ls("NIH SeqData")

for(i in seq_along(file_paths)){
  file_contents[[i]]<-read_csv(
    file=file_paths[[i]]
  )
}
file_contents<-set_names(file_contents, file_paths)
list2env(file_contents,envir = .GlobalEnv)
poopy<-list(1,2,3)
names(poopy)<- c("a","b","c")

#take out empty cells
P1<- P1 %>% 
  mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>% 
  na.omit()

#find distinct TCR's 
Distincts<-P1%>% group_by(delta.u., gamma.u.1) %>% summarise(count=n())

#Merge all tcr designators into one column
Distincts<- Distincts %>% unite('CombinedDGSequence', 1:2, remove=T)

#Lump together any sequence that has less than 5 occurrences into Unique Category
Distincts<- Distincts %>% 
  mutate(CombinedDGSequence = fct_lump_min(CombinedDGSequence, 2, count, other_level = "Unique")) %>% 
  count(CombinedDGSequence, wt = count, name = "count")

#make pie chart
ggplot(Distincts, aes(y=count, x="", fill=CombinedDGSequence)) + 
  geom_bar(stat="identity", show.legend=TRUE) + 
  coord_polar("y", start = 0) +
  geom_text(aes(label=paste0("n=", count))) +
  ggtitle("Unique vs Expanded Sequences")



  

  
