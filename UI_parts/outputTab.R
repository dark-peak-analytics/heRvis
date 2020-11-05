outputTab <- tabPanel("Output",
                      
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
                          hr(),


                          plotOutput(outputId = "results_plot", height = "500px",width = "100%"),
                          dataTableOutput(outputId = "results_tbl"),
                          br(),br(),br()
                      )
                        
                      )