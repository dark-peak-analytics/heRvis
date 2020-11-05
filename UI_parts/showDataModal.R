showDataModal <- modalDialog(title = "Show Data",
                             fluidRow("Can't get this to work, want to insert first and last rows here, when I include the code tableOutput('validate_q1') this doesn't work... "),
                             fluidRow(
                               column(
                                 offset = 1,
                                 width = 10,
                                 align = "center",
                                 h4("Check the first and last 5 rows - looks ok?")
                               ),
                               br(),
                               column(
                                 offset = 1,
                                 width = 10,
                                 align = "center",
                                 panel(tableOutput("validate_q1"))
                               )
                             )
                             )