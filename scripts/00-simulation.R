#### Preamble ####
# Purpose: Simulate some data that could resemble the 1988 Ghana Demographic and Health Survey dataset.
# Author: Pascal Lee Slew, Yunkyung Park
# Data: 3 April 2022
# Contact: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Don't forget to gitignore it!

#### Workspace set-up ####
library(janitor)
library(tidyverse)
library(ggplot2)

#### Simulate data ####
set.seed(304)

simulated_dhs <-
  tibble(
    # Unique identifier
    'caseID' = 1:3564,
    # Randomly choose one of the two options, with replacement, 3564 times
    'Residence' = sample(
      x = c(
        'Urban',
        'Rural'
      ),
      size = 3564,
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
      size = 3564,
      replace = TRUE
    ),
    "Mother's_education" = sample(
      x = c(
        'No_education',
        'Primary',
        'Middle',
        'Secondary+'
      ),
      size = 3564,
      replace = TRUE
    ),
    'Work_status' = sample(
      x = c(
        'For_family_member',
        'For_someone_else',
        'Self-employed'
      ),
      size = 3564,
      replace = TRUE
    ),
    'Occupation' = sample(
      x = c(
        'Agricultural',
        'Nonagricultural'
      ),
      size = 3564,
      replace = TRUE
    ),
    'Employment_status' = sample(
      x = c(
        'All_year_full_week',
        'All_year_part_week',
        'Seasonal',
        'Occasional'
      ),
      size = 3564,
      replace = TRUE
    ),
    'Child_under_six' = sample(
      x = c(
        'No',
        'Yes'
      ),
      size = 3564,
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
      size = 3564,
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

simulated_dhs %>%
  filter(Child_under_six=='Yes') %>%
  ggplot(aes(x = Residence, fill=Residence)) +
  geom_bar() +
  labs(x = "Areas",
       y = "Number of employed women") +
  theme(legend.position='none') +
  theme_minimal()
