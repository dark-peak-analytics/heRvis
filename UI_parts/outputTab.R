outputTab <- tabPanel("Outputs",
                      
                      # add choice of plot
                      panel(
                          align = "center",
                          column(offset=2,4,align="center",
                          radioGroupButtons(
                              choices = c("CEAC", "CEPlane", "ICER-Table"),
                              selected = "CEPlane",
                              label = "Choice",
                              inputId = "plotChoice",
                              status = "primary"
                          )),
                          column(4,align="center",
                          selectInput("ref_index","Select Reference",choices = NULL)
                          ),
                          hr(),br(),br(),br(),


                          plotOutput(outputId = "results_plot",
                                     height = "500px",
                                     width = "100%"),
                          
                          dataTableOutput(outputId = "results_tbl"),
                          
                          br(),br(),br(),br(),
                          
                          column(width = 4,
                                 offset = 6,
                                 align="center",
                                 downloadButton('downloadPlot','Download Plot')),
                          
                          br(),br(),br()
                      )
                        
                      )