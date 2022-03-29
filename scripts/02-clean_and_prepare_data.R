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

# check the numbers add up to a hundred
clean$sum_child <- (clean$no_child_under_six + clean$one_more_child_under_six) == 100
clean_caretaker <- 
  clean %>%
  select(starts_with("caretaker_")) %>%
  mutate(sum_caretaker = rowSums(.))

clean_caretaker <-
  bind_cols(clean$background, clean_caretaker, clean$character)

clean<-
  clean %>%
  select(-sum_child)

clean2<-
  clean %>%
  mutate(
    no_child_under_six = round(no_child_under_six/100 * number_of_employed_women, 0),
    one_more_child_under_six = round(one_more_child_under_six/100 * number_of_employed_women, 0)
  ) %>%
  mutate(
    caretaker_respondent = round(caretaker_respondent/100 * one_more_child_under_six, 0),
    caretaker_partner = round(caretaker_partner/100 * one_more_child_under_six, 0),
    caretaker_other_relative = round(caretaker_other_relative/100 * one_more_child_under_six, 0),
    caretaker_neighbor = round(caretaker_neighbor/100 * one_more_child_under_six, 0),
    caretaker_hired = round(caretaker_hired/100 * one_more_child_under_six, 0),
    caretaker_child_in_school = round(caretaker_child_in_school/100 * one_more_child_under_six, 0),
    caretaker_other_female_child = round(caretaker_other_female_child/100 * one_more_child_under_six, 0),
    caretaker_other_male_child = round(caretaker_other_male_child/100 * one_more_child_under_six, 0),
    caretaker_not_worked_since_birth = round(caretaker_not_worked_since_birth/100 * one_more_child_under_six, 0),
    caretaker_other = round(caretaker_other/100 * one_more_child_under_six, 0),
    caretaker_missing = round(caretaker_missing/100 * one_more_child_under_six, 0)
  )
 

clean21<-
  clean2 %>%
  select(starts_with("caretaker_")) %>%
  mutate(sum_caretaker = (rowSums(.) - clean2$one_more_child_under_six))

write_csv(clean, "outputs/data/cleaned_data.csv")
