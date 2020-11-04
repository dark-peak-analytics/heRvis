#  ---------------------------
#  Script name: App
#  Purpose of script: ShinyApp
#  Author(s): Robert A Smith & Paul P Schneider
#  Date Created: 2020-11-04
#  Copyright (c) Dark Peak Analytics 2020
#  Email: darkpeakanalytics@gmail.com
#  ---------------------------
#  Notes:  relies on darkpeak package functions                    
#  ---------------------------

rm(list = ls())

# get the following functions from the library
library(shiny) 
library(ggplot2)
library(shinythemes)
library(shinydashboard)
library(shinydashboardPlus)
library(darkpeak) # note may need to install from github

# source the components of the app- 

# source the user-interface components
source("./header1.R")
# body
# footer

# source the UI itself (it simply calls the above)
source("./ui.R")

# source the server function
# server

# run the app
shinyApp(ui = ui, server = server)


