rm(list=ls())

#load packages
library(tidyverse)
library(fs)
library(forcats)
#load data via loop
file_paths<- fs::dir_ls("NIH SeqData") 
list.allData<-list()
for(i in seq_along(file_paths)){
  list.allData[[i]]<-read_csv(
    file=file_paths[[i]]
  )
}
list.allData<-set_names(list.allData, substr(file_paths,13, nchar(file_paths)-11))
#take out empty cells
for(i in 1:length(list.allData)){
  list.allData[[i]]<- list.allData[[i]] %>% 
    mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>% 
    na.omit()
}
#print list to environment
list2env(list.allData, envir = .GlobalEnv)


 
