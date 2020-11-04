outputTab <- tabPanel("Output",
                      
                      # add choice of plot
                      radioGroupButtons(choices = c("CEAC","CEPlane","ICER-Table"),
                                        selected = "CEAC",
                                        label = "Choice",
                                        inputId = "plotChoice"),
                      
                      
                      plotOutput(outputId = "Chosenplot")
                        
                        
                      )