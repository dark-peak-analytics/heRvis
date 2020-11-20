outputTab <- tabPanel(
    "Outputs",

    # add choice of plot
    column(
        offset = 1, width = 10,align="left",
        br(),br(),
        panel(
            fluidRow(
                column(
                    offset = 2, 4, align = "center",
                    radioGroupButtons(
                        choices = c("CEAC", "CEPlane", "ICER-Table"),
                        selected = "CEPlane",
                        label = "Choice",
                        inputId = "plotChoice",
                        status = "primary"
                    )
                ),
                column(4,
                    align = "center",
                    selectInput("ref_index", "Select Reference", choices = NULL)
                )
            ),

            column(
            width = 12, hr(), align = "center",
                # sidebarLayout(sidebarPanel = sidebarPanel(width = 2),mainPanel = mainPanel(
                    plotOutput(
                            outputId = "results_plot",
                            height = "500px",
                            width = "100%"
                      #  )
                    #)
                ),

                div(
                    id="icer_tbl_div",
                    HTML("<b>Show 95% CI? </b>"),switchInput(inputId = "show_95ci",label = "",value=T,inline = T) ,
                    dataTableOutput(outputId = "results_tbl")
                    )
            ), # end column

                br(), br(),
            
            # Download section
            fluidRow(
                column(
                    offset = 3, 
                    width = 3, 
                    align = "center",
                    downloadButton(outputId = "downloadPlot",
                                   label =  "Download Plot"
                )),
                column(offset = 0,
                       width = 3,
                       align = "center",
                       selectInput(width = "150px",
                                   inputId = "fformat",
                                   label =  NULL, 
                                   choices=c("png","tiff","jpeg","pdf"), 
                                   selected = "png", 
                                   multiple = FALSE, 
                                   selectize = TRUE))
            ),
            
            br(), br()
            )
        )
    )
