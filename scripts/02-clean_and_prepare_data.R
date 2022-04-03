#### Preamble ####
# Purpose: Clean and prepare the 1988 clean census data downloaded from the DHS Program
# Author: Pascal Lee Slew, Yunkyung Park
# Data: 3 April 2022
# Contact: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the 1988 clean census data by following the process 
# in 01-gather_data.R and saved it to outputs/data
# - Don't forget to gitignore it!

#### Workspace set-up ####
library(tidyverse)
library(pointblank)

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

agent <-
  create_agent(tbl = clean) %>%
  col_is_character(columns = vars(background, character)) %>%
  col_is_integer(columns = vars(no_child_under_six,
                                one_more_child_under_six,
                                caretaker_respondent,
                                caretaker_partner,
                                caretaker_other_relative,
                                caretaker_neighbor,
                                caretaker_hired,
                                caretaker_child_in_school,
                                caretaker_other_female_child,
                                caretaker_other_male_child,
                                caretaker_not_worked_since_birth,
                                caretaker_other,
                                caretaker_missing,
                                total,
                                number_of_employed_women)) %>%
  interrogate()

agent

write_csv(clean, "outputs/data/cleaned_data.csv")
