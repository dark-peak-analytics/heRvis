inputdataTab <- tabPanel("Input data",
                         
                         fluidRow(
                             column(
                               offset=4,
                               width = 4,align="center",
                               div(class="panel1",
                                   selectizeInput(
                                     inputId = "treatments_n",
                                     label = "How many treatments?",
                                     choices = c(2:6)
                                   ),
                                   checkboxInput("remove_1st_row",label = "Does the 1st row contain labels?"),
                               ),
                               br(),br(),
                             ),
                             fluidRow(
                               column(offset = 1,
                                      width = 10,
                                      uiOutput("input_data_ui")
                               )
                             ),
                             fluidRow(
                               column(offset = 1,width = 10,align="center",
                                      h4("Check: first 5 rows look ok?")
                               ),
                               br(),
                               column(offset = 1,width = 10,align="center",
                                      div(class="panel1",
                                          tableOutput("validate_q1")
                                      )
                               )
                             )
                           ),
                         # custom footer
                         footer)