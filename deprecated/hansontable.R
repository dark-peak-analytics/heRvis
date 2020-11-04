library(shiny)
library(rhandsontable)
library(data.table)

rm(list =ls())

treatment_names <- c("Apixaban","Edoxaban","NoTreat")
n_cols = length(treatment_names)*2

defaultDT <- as.data.table(matrix(data = 0,
                                  nrow = 10,
                                  ncol = n_cols))

colnames(defaultDT) <- c(paste0(treatment_names, "QALY"),
                         paste0(treatment_names,"COST"))


ui <- fluidPage(
  
  sliderInput(label = NULL,
              inputId = "n_col",
              min = 1,
              max = 7,
              value = 3)#,
  
  #rHandsontableOutput(outputId = "tabelle")

)

server <- function(input, output){
  
  
n_col <- observeValues(input$n_col)

print(n_col$values)
  
  #data.in <- reactiveValues(values = 0,
  #                          ncols = as.data.table(matrix(data = 0,
  #                                                        nrow = 10,
  #                                                        ncol = input$n_cols)))
  #
  output$table <- renderRHandsontable({
    
    rhandsontable(height = 200,
                  data = data.in$values)
    
  })
  
}
shinyApp(ui, server)


























rm(list = ls())

library(shiny)
library(rhandsontable)
library(data.table)

did_recalc <- FALSE

ui <- fluidPage(
  sliderInput(label = "Number of Strategies",
              inputId = "n_in",
              min = 2,
              max = 7,
              value = 2),
  uiOutput("strategy_names"),
  rHandsontableOutput('table'),
  tableOutput('result'),
  actionButton("reset", "Reset Table")
)

server <- function(input,output,session)({
  
  output$strategy_names <- renderUI({
    pvars <- paste(1:input$n_in)
    lapply(seq(pvars), function(i) {
      textInput(inputId = paste0("name_", pvars[i]),
                label = paste0("Strategy ", pvars[i]),
                placeholder = "Red-Pill")
    })
    
  })
  
  values <- reactiveValues(data=as.data.table(matrix(data = 0,
                                                     nrow = 10,
                                                     ncol = 10)))
  
  observe({
    input$reset
    values$data <- as.data.frame(matrix(0,
                                        nrow = 10,
                                        ncol = input$n_in*2))
  })
  
  observe({
    if(!is.null(input$table))
      values$data <- hot_to_r(input$table)
  })
  
  
  output$table <- renderRHandsontable({
    rhandsontable(values$data,
                  colHeaders = c(paste(c(input$name_1,input$name_2),"COSTS"),
                                 paste(c(input$name_1,input$name_2),"QALYs"))
    )
  })
  
  
  output$result <- renderTable({ 
    t(data.frame(means = colMeans(values$data)))
  })
}) 

shinyApp(ui = ui, server = server)






















ui <- fluidPage(
  
  # Copy the line below to make a text input box
  textInput("text", label = h3("Text input"), value = "Enter text..."),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)




server <- function(input, output) {
  
  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ input$text })
  
}

shinyApp(ui = ui, server = server)



