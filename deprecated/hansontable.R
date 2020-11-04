library(shiny)
library(rhandsontable)
library(data.table)

treatment_names <- c("treat1","treat2","treat3")

n_cols = length(treatment_names)*2


defaultDT <- data.table(X = rep(0,10), 
                    Y = rep(0,10))

ui <- fluidPage(
  rHandsontableOutput(outputId = "tabelle"),
  plotOutput(outputId = "grafik")
)
server <- function(input, output){
  data.in <- reactiveValues(values = defaultDT)
  output$tabelle <- renderRHandsontable({
    rhandsontable(height = 200,
                  data = data.in$values,
                  colHeaders = c("Costs","QALYs"))
  })
  observeEvent(eventExpr = input$tabelle, {
    data.in$values <- hot_to_r(input$tabelle)
    output$grafik <- renderPlot({
      if(!is.null(tryCatch(plot(data.in$values), 
                           error = function(e){})))
      {plot(data.in$values)}
    })
  })
}
shinyApp(ui, server)