outputTab <- tabPanel("Output",
                      
                      # add choice of plot
                      radioGroupButtons(choices = c("CEAC","CEPlane","ICER-Table"),
                                        selected = "CEPlane",
                                        label = "Choice",
                                        inputId = "plotChoice"),
                      
                      
                      plotOutput(outputId = "results_plot"),
                      dataTableOutput(outputId = "results_tbl")
                        
                        
                      )