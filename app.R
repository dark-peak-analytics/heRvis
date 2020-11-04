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
source("./UI_parts/footer.R")
source("./UI_parts/introTab.R")
source("./UI_parts/inputdataTab.R")
source("./UI_parts/outputTab.R")
source("./UI_parts/aboutTab.R")

# source functions
source("./R/gen_treatment_name_fields.R")



ui <- navbarPage("heRvis",
                 introTab,
                 inputdataTab,
                 outputTab,
                 aboutTab)



server <- function(input, output, session){
  
  output$validate_q1 <- renderTable({
    res_Q_inputs = paste0("QALY",1:input$treatments_n)
    res_T_inputs = paste0("COSTS",1:input$treatments_n)
    res_df = c()
    # t_names = grep("treatment_name_",names(input),value = T)
    t_names = unlist(lapply(grep("treatment_name_",names(input),value = T),function(x)input[[x]]))
    for(q in 1:input$treatments_n){
      txt_q = input[[res_Q_inputs[q]]]
      txt_t = input[[res_T_inputs[q]]]
      if(nchar(txt_q)>1){
        res_q.temp = read.table(text = txt_q,sep = " ",fill=T)
        if(length(res_q.temp)>1){
          res_df <- cbind(res_df,res_q.temp[,1])
          print(t_names[q])
          colnames(res_df)[ncol(res_df)] <- paste0(t_names[q]," QALYs")
        } 
      } 
      if(nchar(txt_t)>1){
        res_t.temp = read.table(text = txt_t,sep = " ",fill=T)
        if(length(res_t.temp)>1){
          res_df <- cbind(res_df,res_t.temp[,1])
          colnames(res_df)[ncol(res_df)] <- paste0(t_names[q]," Costs")
        }
      } 
    }
    if(!is.null(res_df)){
      if(input$remove_1st_row){
        res_df = res_df[-1,]  
      }  
    } else {
      res_df = c()
    }
    head(res_df)
  })
  
  
  
  output$input_data_ui <- renderUI({

    fluidRow(
      gen_treatment_name_fields(input$treatments_n)
    )
    
  })
  
  output$CEAC <- renderPlot({
    makeCEAC()
  })
  
  output$CEplane <- renderPlot({
    makeCEPlane()
  })
  
  
  

}


# run the app
shinyApp(ui = ui, server = server)



