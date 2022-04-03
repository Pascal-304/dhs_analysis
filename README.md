# Childcare situation of working mothers in Ghana 1998

  - Authors: Pascal Lee Slew and Yunkyung Park
  - Date: April 3rd, 2022
  - Email: pascal.leeslew@mail.utoronto.ca, clara.park@mail.utoronto.ca

## Overview of the paper

This repository examines the childcare situation of working mothers in Ghana using data gathered from the 1998 Ghana Demographic and Health Survey (GDHS). 

## Repo  structure

- 'scripts' includes all the code necessary to simulate data, gather the data and cleaning the data.
- 'inputs' contains the datasheet pdf which gives some information on how the dataset was created, the rmd file used to produce the pdf and the bib file for the references used.
- 'outputs' contains the data folder which includes both the raw and clean dataset obtained.
- 'outputs' also contains the files necessary to reproduce the paper. We have the pdf copy of the paper on 'Childcare situation of working mothers in Ghana' as well as the rmd file in order to reproduce it and a reference bib file containing the references used for the paper.


## Obtaining data

The 1998 GDHS is publicly available at https://dhsprogram.com/publications/publication-FR106-DHS-Final-Reports.cfm
  - We gathered data from a table on page 45 in the pdf.
  - The r script '01-gather_data.R' located under the 'scripts' folder contains the code necessary to obtain the data used.
  
## Preprocessing and Cleaning

After obtaining the 'raw data', some cleaning was done. The code used to obtain the clean dataset is located at 'scripts/02-clean_and_prepare_data.R'
