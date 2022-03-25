#### Preamble ####

library(janitor)
library(tidyverse)

raw_data <- read_csv("raw_data.csv")

col_len <- ncol(raw_data)
  
clean <- as_tibble(raw_data)
clean$charact <- (rowSums(is.na(clean)) == col_len-1)

index <- 1:nrow(clean)
j<-0
while (j < nrow(clean)-1){
  j<-j+1
  if (clean[j,]$charact == TRUE){
    i<-j
  }
  
  index[j]<-clean[i,]$background
}

index[nrow(clean)]<-""
clean$charact<-index
clean <-
  clean %>%
  na.omit()