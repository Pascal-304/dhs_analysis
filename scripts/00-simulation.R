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
library(tidyverse)

#### Simulate data ####
set.seed(304)

<<<<<<< HEAD
simulated_dhs <-
  tibble(
    # Unique identifier
    'caseID' = 1:3565,
    # Randomly choose one of the two options, with replacement, 3565 times
    'Residence' = sample(
      x = c(
        'Urban',
        'Rural'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Region' = sample(
      x = c(
        'Western',
        'Central',
        'Greater_Accra',
        'Volta',
        'Eastern',
        'Ashanti',
        'Brong_Ahafo',
        'Northern',
        'Upper_West',
        'Upper_East'
      ),
      size = 3565,
      replace = TRUE
    ),
    "Mother's_education" = sample(
      x = c(
        'No_education',
        'Primary',
        'Middle',
        'Secondary+'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Work_status' = sample(
      x = c(
        'For_family_member',
        'For_someone_else',
        'Self-employed'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Occupation' = sample(
      x = c(
        'Agricultural',
        'Nonagricultural'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Employment_status' = sample(
      x = c(
        'All_year_full_week',
        'All_year_part_week',
        'Seasonal',
        'Occasional'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Child_under_six' = sample(
      x = c(
        'No',
        'Yes'
      ),
      size = 3565,
      replace = TRUE
    ),
    'Caretaker' = sample(
      x = c(
        'Respondent',
        'Partner',
        'Other_relative',
        'Neighbor',
        'Hired',
        'Child_in_school',
        'Other_female_child',
        'Other_male_child',
        'Not_worked_since_birth',
        'Other',
        'Missing'
        ),
      size = 3565,
      replace = TRUE
    ),
    )

simulated_dhs <-
  simulated_dhs %>%
  mutate(Caretaker = 
           case_when(
             Child_under_six == 'No' ~ 'NA',
             TRUE ~ Caretaker
           ))
=======
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




<<<<<<< HEAD
a
=======
>>>>>>> 8fcf61b5b72010f9cdca7652cc2d1aa309d04265
>>>>>>> 3145f6ddc9512cee5ab5f05e80768e5d6b0ec3fb
