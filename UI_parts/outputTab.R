outputTab <- tabPanel("Output",
                      
                      # add choice of plot
                      panel(
                          align = "center",
                          radioGroupButtons(
                              choices = c("CEAC", "CEPlane", "ICER-Table"),
                              selected = "CEPlane",
                              label = "Choice",
                              inputId = "plotChoice",
                              status = "primary"
                          ),
                          hr(),


                          plotOutput(outputId = "results_plot", height = "500px",width = "100%"),
                          dataTableOutput(outputId = "results_tbl")
                      )
                        
                      )