#### Preamble ####
# Purpose: Simulate some data that could resemble the 1988 Ghana census dataset.
# Author: Pascal Lee Slew, Yunkyung Park
# Data: 3 April 2022
# Contact: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Don't forget to gitignore it!

#### Workspace set-up ####
library(janitor)
library(lubridate)
library(tidyverse)

#### Simulate data ####
set.seed(304)

items<-c("no_child_under_six", "one_more_child_under_six", 
         "respondent", "partner", "other_relative", "neighbor", 
         "hired", "child_in_school", "other_female_child", 
         "other_male_child", "not_worked_since_birth", "other", 
         "missing")

num_of_items <- length(items)

simulated_dhs <-
  tibble(
    background = 
      c(
        rep("Urban", num_of_items),
        rep("Rural", num_of_items),
        rep("Western", num_of_items),
        rep("Central", num_of_items),
        rep("Greater_Accra", num_of_items),
        rep("Volta", num_of_items),
        rep("Eastern", num_of_items),
        rep("Ashanti", num_of_items),
        rep("Brong_Ahafo", num_of_items),
        rep("Northern", num_of_items),
        rep("Upper_West", num_of_items),
        rep("Upper_East", num_of_items),
        rep("No_education", num_of_items),
        rep("Primary", num_of_items),
        rep("Middle", num_of_items),
        rep("Secondary+", num_of_items),
        rep("For_family_member", num_of_items),
        rep("For_someone_else", num_of_items),
        rep("Self-employed", num_of_items),
        rep("Agricultural", num_of_items),
        rep("Nonagricultural", num_of_items),
        rep("All_year_full_week", num_of_items),
        rep("All_year_part_week", num_of_items),
        rep("Seasonal", num_of_items),
        rep("Occasional", num_of_items),
        rep("Total", num_of_items)
      ),
    item =
      c(
        rep(item, 26)
      ),
    proportion = 
      runif(n = num_of_items * 26,
            min = 0, 
            max = 100)
  )

head(simulated_dhs)
