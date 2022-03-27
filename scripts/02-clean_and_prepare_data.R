#### Preamble ####
# Purpose: Clean and prepare the 1988 Ghana census data downloaded from the DHS Program
# Author: Pascal Lee Slew, Yunkyung Park
# Data: 3 April 2022
# Contact: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the 1988 Ghana census data by following the process 
# in 01-gather_data.R and saved it to outputs/data
# - Don't forget to gitignore it!

#### Workspace set-up ####
library(tidyverse)

raw_data <- read_csv("outputs/data/raw_data.csv")

col_len <- ncol(raw_data)
  
clean <- as_tibble(raw_data)
clean$character <- (rowSums(is.na(clean)) == col_len-1)

index <- 1:nrow(clean)
j<-0
while (j < nrow(clean)-1){
  j<-j+1
  if (clean[j,]$character == TRUE){
    i<-j
  }
  
  index[j]<-clean[i,]$background
}

index[nrow(clean)]<-"Total"
clean$character<-index
clean <-
  clean %>%
  na.omit()

rm(col_len,
   index,
   i,
   j)

write_csv(clean, "outputs/data/cleaned_data.csv")
