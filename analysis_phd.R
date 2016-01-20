library("dplyr")
library("data.table")
library("ggplot2")
library("choroplethr")

### Read the data
reRead <- 1
##read data and save it as RData to save time nect time:
if(reRead==1){
  colsToKeep <- c("PINCP", "SCHL", "ESR", "ST")
#   popDataA <- fread("../input/pums/ss13pusa.csv", select=colsToKeep ) 
#   popDataB <- fread("../input/pums/ss13pusb.csv", select=colsToKeep )
  popDataA <- fread("./ss13pusa.csv", select=colsToKeep )
  popDataB <- fread("./ss13pusb.csv", select=colsToKeep )
  populData <- rbind(popDataA, popDataB)
  rm(popDataA, popDataB)
  save(populData, file="populData.RData")
}else{
  load("populData.RData")
} 

### Data Manipulation
# Convert it to tbl_df for easier manipulation- remove NAs, extract B.SC, MSs, and PhD guys, and group them accordingly:
populData <- tbl_df(populData) 
ds <-  populData %>%  
  na.omit() %>%
  filter(SCHL %in%  c(21,22,24)) %>%
  group_by(SCHL) 
rm(populData)