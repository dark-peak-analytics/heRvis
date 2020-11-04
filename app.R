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
library(darkpeak) # note may need to install from github

# source the UI components
source("./UI_parts/introTab.R")
source("./UI_parts/inputdataTab.R")
source("./UI_parts/outputTab.R")
source("./UI_parts/aboutTab.R")

ui <- navbarPage("heRvis",
                 introTab,
                 inputdataTab,
                 outputTab,
                 aboutTab)



server <- function(input, output, session){
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
    })
  
  output$summary <- renderPrint({
    summary(cars)
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
}


# run the app
shinyApp(ui = ui, server = server)


