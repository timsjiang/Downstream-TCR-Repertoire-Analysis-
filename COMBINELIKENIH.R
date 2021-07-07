library(tidyverse)


#create lists with each treatment/location
list.CM.LN<-list(P2, P5, P10, P13, P22, P23)
list.lipid.LN<-list(P9, P15)
list.PBS.LN<-list(P14, P16, P17, P18, P19, P26)
list.PBS.CJ<-list(P1, P3, P4, P6, P20)
list.CM.CJ<-list(P7, P8, P21, P25)
list.Lipid.CJ<-list(P12, P24, P11)

#combine listed datasets
CM.LN<- do.call(rbind, list.CM.LN)
lipid.LN<-do.call(rbind, list.lipid.LN)
PBS.LN<-do.call(rbind, list.PBS.LN)
PBS.CJ<-do.call(rbind, list.PBS.CJ)
CM.CJ<-do.call(rbind, list.CM.CJ)
lipid.CJ<-do.call(rbind, list.Lipid.CJ)


#combine all back into list.allData list
list.allData<-list(CM.LN, lipid.LN, PBS.LN, PBS.CJ, CM.CJ, lipid.CJ)
names(list.allData)<-c("CM.LN", "lipid.LN", "PBS.LN", "PBS.CJ", "CM.CJ", "lipid.CJ")

#change column name
list.allData<-lapply(list.allData, rename, c("delta.u"="delta(u)", "gamma.u.1"="gamma(u)1"))

#print list to environment
list2env(list.allData,envir = .GlobalEnv)

#clean up environment
rm(list=setdiff(ls(), "list.allData"))
