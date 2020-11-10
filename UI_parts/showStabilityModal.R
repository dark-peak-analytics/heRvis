# showStability

showStabilityModal <- modalDialog(
    title = div(style="color:white; font-size:120%; font-weight:500", "Check whether results are stable ... "),
    size = "l",
    easyClose = F,
    
    fluidRow(
      br(),
      column(offset = 1,
             width = 10,
             align = "center",
             shinycssloaders::withSpinner(
               custom.css = T,
               image = "RotatingGif.gif",
               plotOutput(outputId = "stabilityPlot",
                          height = "400px",
                          width = "100%")
             )
             
             )))

        