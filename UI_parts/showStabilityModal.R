# showStability

showStabilityModal <- modalDialog(
    title = "Check whether results are stable ... ",
    size = "l",
    easyClose = F,
    
    fluidRow(
      br(),
      column(offset = 1,
             width = 10,
             align = "center",
             shinycssloaders::withSpinner(
             plotOutput(outputId = "stabilityPlot", 
                        height = "400px",
                        width = "100%")
             )
             
             )))

        