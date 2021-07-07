library(tidyverse)

#combine all into one dataset
masterDf<-do.call(rbind, list.allData)
masterDf<-masterDf%>%unite('CombinedDGSequence', 2:3, remove=T)
masterDf<-rename(masterDf, "gamma.u.2"="gamma(u)2")
masterDf<-masterDf%>%group_by(CombinedDGSequence,TRDV, TRDD, TRDJ, TRGV1, TRGJ1)%>% summarise("count"=n())
masterDf<-select(masterDf,-gamma.u.2)


