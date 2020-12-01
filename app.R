#  ---------------------------
#  Script name: App
#  Purpose of script: ShinyApp
#  Author(s): Robert A Smith & Paul P Schneider
#  Date Created: 2020-11-04
#  Copyright (c) Dark Peak Analytics 2020
#  Email: darkpeakanalytics@gmail.com
#  ---------------------------
#  Notes:  Uses custom function not darkpeak functions
#  ---------------------------

rm(list = ls())

# get the following functions from the library
library(plotly)
library(scales)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(dampack)
library(shinyjs)
library(DT)
library(data.table)
library(shinycssloaders)
library(shinythemes)
library(colourpicker)
library(ggthemes)
library(scales)

# source functions
source("./R/gen_treatment_name_fields.R")
source("./R/ceac.R")
source("./R/cep.R")
source("./R/icertbl.R")
source("./R/checkStability.R")


# source the UI components
source("./UI_parts/footer.R")
source("./UI_parts/introTab.R")
source("./UI_parts/inputdataTab.R")
source("./UI_parts/outputTab.R")
source("./UI_parts/aboutTab.R")
source("./UI_parts/header.R")
source("./UI_parts/instructModal.R")
source("./UI_parts/showDataModal.R")
source("./UI_parts/showStabilityModal.R")

sample_cost = darkpeak::example_TC[,c(3,2,4)]
sample_qalys = darkpeak::example_TQ[,c(3,2,4)]
sample_names = c("Base Case", "Dupimap","Supimap")




ui <- navbarPage(
  title = div(class = "clear_h","heRvis", span("beta 0.1",style = "color: #68D3BF")),
  theme = shinytheme("slate"),
  id = "main_panel",
  header = includeCSS("www/custom.css"),
  introTab,
  inputdataTab,
  outputTab,
  aboutTab,
  footer = footer
  
)



server <- function(input, output, session){

  # next and prev button navigation system
  pages = c("Introduction", "Input data", "Outputs", "About")
  
  observeEvent(input$nxt, ignoreInit = T, ignoreNULL = T, {
    page_is = which(pages == input$main_panel)
    updateNavbarPage(session, "main_panel", pages[page_is + 1])
  })
  
  observeEvent(input$prv, ignoreInit = T, ignoreNULL = T, {
    page_is = which(pages == input$main_panel)
    updateNavbarPage(session, "main_panel", pages[page_is - 1])
  })
  
  observeEvent(input$main_panel,{
    page_is = which(pages == input$main_panel)
    if (page_is == length(pages)) {
      disable("nxt")
    } else {
      enable("nxt")
    }
    if(page_is == 1){
      disable("prv")
    } else {
      enable("prv")
    }
  })

  # observeEvent(input$showInstruct, {
  #   showModal(instructModal)
  # })

  observeEvent(input$showDataModal, {
    showModal(showDataModal(input))
  })

  observeEvent(input$showStabilityModal, {
    showModal(showStabilityModal)   # R.S. Add input
  })


  # this needs to be read in HERE in the server
  getValues = function(treatment_names,type="QALY",rm1=F,add_label ="")
  {
    res_Q_inputs = paste0(type,seq_along(treatment_names))
    res = c()
    for(q in res_Q_inputs){
      txt = input[[q]]
      if (is.null(txt)) {
        return(data.frame(c("",""), c("","")))
      }
       if (nchar(txt)<2) {
        return(data.frame())
      }

      res.temp = read.table(text = txt,sep = " ",fill=T)
      res <- cbind(res,as.numeric(res.temp[,1]))
    }
    if(rm1){
      res = res[-1,]
    }
    colnames(res) = paste0(treatment_names,add_label)
    res = res[complete.cases(res),]
    return(res)
  }



  observeEvent(
    lapply(paste0("treatment_name_", 1:input$treatments_n),
           function(x) input[[x]]),
    {
      choices = lapply(paste0("treatment_name_", 1:input$treatments_n),
                       function(x) input[[x]])
      if(!is.null(choices)){
        choices = unlist(choices)
      updateSelectInput(session, "ref_index",
                        choices = choices,
                        selected = choices[1])
      }

    }
  )


  output$validate_q1 <- renderTable(rownames=T,{

    resinputs = paste0(
      rep(c("QALY","COSTS"),times = input$treatments_n),
      rep(c(1:input$treatments_n),each=2)
      )

    res_df = c() # value

    # t_names = grep("treatment_name_",names(input),value = T)
    t_names = unlist(lapply(paste0("treatment_name_",1:input$treatments_n),
                            function(x)input[[x]]))
    t_names = rep(t_names,each=2)

    for(q in seq_along(resinputs)){ # loop through treatments
      txt = input[[resinputs[q]]]
      if(nchar(txt)>1){
        res.temp = read.table(text = txt,sep = " ",fill=T)
        if(!is.null(res.temp$V1)){
          res_df <- cbind(res_df,res.temp[,1])
          colnames(res_df)[ncol(res_df)] <- paste0(resinputs[q], " (", t_names[q], ")")
        }
      }
    } # end loop

    # remove first row if this is selected?
    if(!is.null(res_df)){
      if (input$remove_1st_row) {
        res_df = res_df[-1, ]
      }
      res_df = round(res_df,2)
      rownames(res_df) = 1:nrow(res_df)
      res_df = rbind(
        head(res_df, 5),
        rep("...", times = ncol(res_df)),
        tail(res_df, 5)
      )
    }

    if(is.null(res_df)){
      res_df = ""
    }

    # return data-frame

    return(  res_df)

  })


  output$input_data_ui <- renderUI({
    # RESET BUTTON
    x <- (input$reset) # print just to re-evaluate this function
    fluidRow(
      gen_treatment_name_fields(input$treatments_n)
    )
  })


  step12 = reactiveVal(1)
  observeEvent(input$load_sample_data,ignoreInit = T,ignoreNULL = T,{
    updateSelectInput(session,inputId = "treatments_n",selected = 2) # hack to have treatments_n being updated no matter what the current states
    updateSelectInput(session,inputId = "treatments_n",selected = 3)
    step12(2) # hack to have one ui element being updated before the other
  })

  observeEvent(input$treatments_n,{ # waits until treatments_n is updated
    if(isolate(step12())==2){ # checks if it is supposed to put in new values
      lapply(1:3,function(x){
        updateTextInput(session,paste0("treatment_name_",x),value = sample_names[x])
        updateTextAreaInput(session, paste0("QALY",x),value= paste(sample_qalys[,x],collapse ="\n"))
        updateTextAreaInput(session, paste0("COSTS",x),value=paste(sample_cost[,x],collapse ="\n"))
      })
      step12(1)
    }


  })


  action_monitor = reactive({
    c(input$main_panel, input$plotChoice, input$showStabilityModal)
  })



  observeEvent(action_monitor(),ignoreInit = T,{


    # retrive names, qalys, and costs from text fields

    n = input$treatments_n

    if(!is.null(n)){

    treatment_names = unlist(lapply(
      paste0("treatment_name_",1:input$treatments_n),
                                    function(x)input[[x]]))


    qalys = getValues(treatment_names = treatment_names,
                      type = "QALY",
                      rm1 = input$remove_1st_row)

    costs = getValues(treatment_names = treatment_names,
                      type = "COSTS",
                      rm1 = input$remove_1st_row)

    colors = unlist(lapply(1:n, function(i){input[[paste0("treatment_color_",i)]]}))

    # create Stability plot output

    output$stabilityPlot <- renderPlot({

      checkStability(
        colors = colors,
        lambda = input$lambda,
        total_costs = as.matrix(costs),
        total_qalys = as.matrix(qalys),
        withinShiny = T
      )

    })
    

    # if (ncol(qalys) >= 2 & ncol(costs) >= 2) {

    # create plot output
      if (input$plotChoice == "CEPlane") {

        output$results_plot <- renderPlot({
          makeCEPlane(
            total_costs = costs,
            total_qalys = qalys,
            color=colors,
            thres = input$lambda,
            comparitor = input$ref_index,
            treatment = treatment_names[-which(treatment_names == input$ref_index)]
          )
        })
        

        output$downloadPlot <- downloadHandler(
          filename = function(){paste("heRvis_CEplane",input$fformat,sep='.')},
          content = function(file){
            ggsave(filename = file,
                   dpi = 72,
                   device = input$fformat,
                   units = "in",
                   width = (input$shiny_width/64)*(9/12),
                   height = 500/64,# input$shiny_height/64,
                   plot= makeCEPlane(
                     thresh = input$lambda,
                     total_costs = costs,
                     total_qalys = qalys,
                     color=colors,
                     comparitor = input$ref_index,
                     treatment = treatment_names[-which(treatment_names == input$ref_index)]
                   ))
          }
        )
      }

      if (input$plotChoice == "CEAC") {
        output$results_plot <- renderPlot({
          makeCEAC(
            total_costs = costs,
            total_qalys = qalys,
            colors = colors,
            treatment = treatment_names
          )
        })

        output$downloadPlot <- downloadHandler(
          filename = function(){paste("heRvis_CEAC",input$fformat,sep='.')},
          content = function(file){
            ggsave(filename = file,
                   dpi = 72,
                   device = input$fformat,
                   units = "in",
                   width = (input$shiny_width/64)*(9/12),
                   height = 500/64,# input$shiny_height/64,
                   plot= makeCEAC(
                     total_costs = costs,
                     colors = colors,
                     total_qalys = qalys,
                     treatment = treatment_names
                   ))
          }
        )
      }

      # always create tbl
      output$results_tbl <- renderDataTable({
        createICERtable(
          total_costs = costs,
          total_qalys = qalys,
          ref_index = input$ref_index,
          ci = input$show_95ci
          )
      })

      # hide/show depending on selection
      if (input$plotChoice == "CEAC" | input$plotChoice == "CEPlane") {

        hide("icer_tbl_div")
        show("results_plot")
        show("downloadPlot")

      } else {

        hide("results_plot")
        show("icer_tbl_div")
        # show("results_tbl")
        hide("downloadPlot")

      }

    }



  })




}


# run the app
shinyApp(ui = ui, server = server)



