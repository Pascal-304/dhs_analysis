#### Preamble ####
# Purpose: Download one 'Final Report' from the DHS Program in a PDF form
# and gather the data by parsing the PDF
# Author: Pascal Lee Slew, Yunkyung Park
# Data: 3 April 2022
# Contact: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Don't forget to gitignore it!

#### Workspace set-up ####
# install.packages('pdftools')
# install.packages('stringi')
library(pdftools)
library(tidyverse)
library(stringi)

download.file("https://dhsprogram.com/pubs/pdf/FR106/FR106.pdf",
              "outputs/literature/1988_Ghana_DHS.pdf",
              mode="wb")

report <- pdf_text("outputs/literature/1988_Ghana_DHS.pdf")

page_45<-stri_split_lines(report[[45]])[[1]]
page_45<-page_45[page_45 != ""]

# Get rid of the header and footer
page_45_only_content <- page_45[12:43]

# Convert into a tibble
data <- tibble(all = page_45_only_content)

# Split columns
data <-
  data %>%
  mutate(all = str_squish(all)) %>% # Any space more than two spaces is reduced
  mutate(all = str_replace(all, "Middle/JSS", "Middle")) %>% # One specific issue
  mutate(all = str_replace(all, ", ", "_")) %>%
  mutate(all = str_replace(all, "26 Upper East", "Upper East")) %>%
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) %>%
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) %>%
  separate(col = all,
           into = c("background", "no_child_under_six", "one_more_child_under_six", 
                    "caretaker_respondent", "caretaker_partner", 
                    "caretaker_other_relative", "caretaker_neighbor", 
                    "caretaker_hired", "caretaker_child_in_school", 
                    "caretaker_other_female_child", "caretaker_other_male_child", 
                    "caretaker_not_worked_since_birth", "caretaker_other", 
                    "caretaker_missing", "total", "number_of_employed_women"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

rm(page_45,
   page_45_only_content)

write_csv(data, "outputs/data/raw_data.csv")