# showStability

showStabilityModal <- #function() {
  modalDialog(
    title = "Check whether results are stable",
    size = "l",
    easyClose = T,
    
    fluidRow(
      column(
        offset = 1,
        width = 10,
        align = "center",
        h4("Do these results look stable")
      ),
      br(),
      column(offset = 1,
             width = 10,
             align = "center",
             plotOutput(outputId = "stabilityPlot", 
                        height = "400px",
                        width = "100%")
             
             )))
  #}
        