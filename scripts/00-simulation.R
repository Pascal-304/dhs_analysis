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

simulated_data <-
  tibble(
    # Use 1 through to 3565 to represent each region
    'Index' = 1:3565,
    # Randomly choose one of the two options, with replacement, 3565 times
    'Region' = sample(
      x = c(
        'Urban',
        'Rural'
      ),
      size = 3565,
      replace = TRUE
    ))




