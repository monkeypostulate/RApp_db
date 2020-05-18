
#install.packages('shiny')
#install.packages('DT')
#install.packages('tidyverse')
library(shiny)
library(DT)
library(tidyverse)
library(openxlsx)

source("src/credentials.R")
source("src/tab1.R")
source("src/tab2.R")

# Define UI for application that plots random distributions
shinyUI(
  # #####################################################
  # Begin Navigation Page
  # #####################################################
  navbarPage(
    h1("Excel file to DB"),
    
    # Begin: Welcome window
    tab1()
    # End: welcome window
    ,tab2()
    
    
  )
  # #####################################################
  # End Navigation Page
  # #####################################################
)