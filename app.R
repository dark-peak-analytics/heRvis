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
library(ggplot2)
library(darkpeak) # note may need to install from github
library(shiny) 
library(shinyWidgets) 
library(dampack)
library(shinyjs)

# source functions
source("./R/gen_treatment_name_fields.R")
source("./R/ceac.R")
source("./R/cep.R")
# source the UI components
source("./UI_parts/footer.R")
source("./UI_parts/introTab.R")
source("./UI_parts/inputdataTab.R")
source("./UI_parts/outputTab.R")
source("./UI_parts/aboutTab.R")
source("./UI_parts/header.R")







ui <- navbarPage("heRvis",id = "main_panel",
                 
                 header =
                   
                   tags$head(
                     tags$style(
                       HTML(
                         "
        @import url('https://rsms.me/inter/inter.css');
                  html { font-family: 'Inter'; }
                  body {
                  background-color: #F5F6F7;
                  color: #26384E;
                  font-weight: 450;
                  font-family: Inter;
                  font-size: 14px;
                  }
                  .panel1 {
                  background-color: white;
                  border: 1px solid #5F9EA0;
                  border-radius: 10px;
                  padding:20px;
                  padding-right:40 px;
                  padding-left:40 px;
                  }
                  .tab-pane {
                  margin-bottom: 150px;
                  }
                  .footer {
                  position:fixed;
                  bottom:0px;
                  right:0px;
                  left:0px;
                  height:120px;
                  background-color: white;
                  margin-top:0px;
                  padding-top:0px;
                  padding-left:40px;
                  margin-bottom:10px;
                  border-top: 1px solid;
                  }
                  "))),
                 useShinyjs(),
                 introTab,
                 inputdataTab,
                 outputTab,
                 aboutTab,
                 footer = footer 
                 )
                 


server <- function(input, output, session){
  
  
  
  
  
  output$validate_q1 <- renderTable({
    
    res_Q_inputs = paste0("QALY",1:input$treatments_n)
    res_T_inputs = paste0("COSTS",1:input$treatments_n)
    
    res_df = c() # value
    
    # t_names = grep("treatment_name_",names(input),value = T)
    t_names = unlist(lapply(paste0("treatment_name_",1:input$treatments_n),
                            function(x)input[[x]]))
    
    
    for(q in 1:input$treatments_n){ # loop through treatments
      
      txt_q = input[[res_Q_inputs[q]]] 
      txt_t = input[[res_T_inputs[q]]]
      
      # QALYS
      if(nchar(txt_q)>1){
        res_q.temp = read.table(text = txt_q,sep = " ",fill=T)
        if(!is.null(res_q.temp$V1)){
          res_df <- cbind(res_df,res_q.temp[,1])
          colnames(res_df)[ncol(res_df)] <- paste0(t_names[q]," QALYs")
        } 
      }
      
      # COSTS
      if(nchar(txt_t)>1){
        res_t.temp = read.table(text = txt_t,sep = " ",fill=T)
        if(!is.null(res_t.temp$V1)){
          res_df <- cbind(res_df,res_t.temp[,1]) 
          colnames(res_df)[ncol(res_df)] <- paste0(t_names[q]," Costs")
        }
      } 
    } # end loop
    
    # remove first row if this is selected?
    if(!is.null(res_df)){
      if(input$remove_1st_row){
        res_df = res_df[-1,]  
      } 
      res_df = rbind(
        head(res_df,5),
        rep("...",times=ncol(res_df)),
        tail(res_df,5)
        )
    } else {
      res_df = c() 
    }
    
    # return data-frame
    
    return(  res_df)
    
  })
  
  
  output$input_data_ui <- renderUI({
    fluidRow(
      gen_treatment_name_fields(input$treatments_n)
    )
  })
  
  
  action_monitor = reactive({
    c(input$main_panel ,input$plotChoice)
  })
  
  
  
  observeEvent(action_monitor(),{
    
    
    # retrive names, qalys, and costs from text fields
    treatment_names = unlist(lapply(paste0("treatment_name_",1:input$treatments_n),
                                    function(x)input[[x]]))
    
    
    getValues = function(treatment_names,type="QALY",rm1=F){
      res_Q_inputs = paste0(type,seq_along(treatment_names))
      res = c()
      for(q in res_Q_inputs){
        txt = input[[q]]
        if(is.null(txt)){
          print("Empty input")
          return(NULL)
        }
        res.temp = read.table(text = txt,sep = " ",fill=T)
        res <- cbind(res,as.numeric(res.temp[,1]))
      }
      if(rm1){
        res = res[-1,]
      }
      colnames(res) = treatment_names
      res = res[complete.cases(res),]
      return(res)
    }
    
    
    qalys = getValues(treatment_names = treatment_names,
                      type = "QALY",
                      rm1 = input$remove_1st_row
    )
    
    costs = getValues(treatment_names = treatment_names,
                      type = "COSTS",
                      rm1 = input$remove_1st_row
    )
    
  # create plot output
    if(input$plotChoice == "CEPlane"){
      output$results_plot <- renderPlot({
        makeCEPlane(
          total_costs = costs,
          total_qalys = qalys,
          comparitor = treatment_names[1],
          treatment = treatment_names[-1])
      })
    }

    if(input$plotChoice == "CEAC"){
      output$results_plot <- renderPlot({
        makeCEAC(
          total_costs = qalys,
          total_qalys = costs,
          treatment = treatment_names
          )
      })
    }

    # always create tbl
      output$results_tbl <- renderTable({
        head(qalys)
      })
      
      # hide/show depending on selection
      if(input$plotChoice == "CEAC" | input$plotChoice == "CEPlane"){
        hide("results_tbl")
        show("results_plot")
      }else{
        hide("results_plot")
        show("results_tbl")
      }
      

  })
  

  
  
}


# run the app
shinyApp(ui = ui, server = server)



