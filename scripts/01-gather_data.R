#### Preamble ####

# install.packages('pdftools')
# install.packages('purrr')
# install.packages('stringi')
# install.packages('janitor')
# install.packages('tidyverse')

library(janitor)
library(pdftools)
library(purrr)
library(tidyverse)
library(stringi)

download.file("https://dhsprogram.com/pubs/pdf/FR106/FR106.pdf",
              "1988_Ghana_DHS.pdf",
              mode="wb")


all_content <- pdf_text("1988_Ghana_DHS.pdf")

get_data <- function(i){
  # i = 467
  # Just look at the page of interest
  # Based on Bob Rudis: https://stackoverflow.com/a/47793617
  just_page_i <- stri_split_lines(all_content[[i]])[[1]] 
  
  just_page_i <- just_page_i[just_page_i != ""]
  
  # Grab the type of table
  type_of_table <- just_page_i[1] %>% str_squish() # 1
  
  # Get rid of the top matter
  # Manually for now, but could create some rules if needed
  just_page_i_no_header <- just_page_i[12:43] # 12:43
  
  # Convert into a tibble
  demography_data <- tibble(all = just_page_i_no_header)
  
  # Split columns
  demography_data <-
    demography_data %>%
    mutate(all = str_squish(all)) %>% # Any space more than two spaces is reduced
    mutate(all = str_replace(all, ",", "")) %>%
    mutate(all = str_replace(all, "Greater Accra", "Greater_Accra")) %>%
    mutate(all = str_replace(all, "Brong Ahafo", "Brong_Afaho")) %>%
    mutate(all = str_replace(all, "Upper West", "Upper_West")) %>%
    mutate(all = str_replace(all, "26 Upper East", "Upper_East")) %>%
    mutate(all = str_replace(all, "Mother's education", "Mother's_education")) %>%
    mutate(all = str_replace(all, "No education", "No_education")) %>%
    mutate(all = str_replace(all, "Middle/JSS", "Middle")) %>% # One specific issue
    mutate(all = str_replace(all, "Work status", "Work_status")) %>%
    mutate(all = str_replace(all, "For family member", "For_family_member")) %>%
    mutate(all = str_replace(all, "For someone else", "For_someone_else")) %>%
    mutate(all = str_replace(all, "Employment status", "Employment_status")) %>%
    mutate(all = str_replace(all, "All year full week", "All_year_full_week")) %>%
    mutate(all = str_replace(all, "All year part week", "All_year_part_week")) %>%
    separate(col = all,
             into = c("background", "no_child_under_six", "one_more_child_under_six", 
                      "respondent", "partner", "other_relative", "neighbor", 
                      "hired", "child_in_school", "other_female_child", 
                      "other_male_child", "not_worked_since_birth", "other", 
                      "missing", "total", "number_of_employed_women"),
             sep = " ", # Works fine because the tables are nicely laid out
             remove = TRUE,
             fill = "right",
             extra = "drop"
    )
  
  # They are side by side at the moment, need to append to bottom
  # demography_data_long <-
  #   rbind(demography_data %>% select(age, male, female, total),
  #         demography_data %>%
  #           select(age_2, male_2, female_2, total_2) %>%
  #           rename(age = age_2, male = male_2, female = female_2, total = total_2)
  #   )
  
  # Add the area and the page
  # demography_data$
  # demography_data_long$area <- area
  # demography_data_long$table <- type_of_table
  # demography_data_long$page <- i
  
  rm(just_page_i,
     i,
     type_of_table,
     just_page_i_no_header)
  
  return(demography_data)
}

# Run through each relevant page and get the data
pages <- c(45)
all_tables <- map_dfr(pages, get_data)
rm(pages, get_data)
