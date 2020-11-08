inputdataTab <- tabPanel(
  title = "Input data",
  
  fluidRow(
    column(
      offset  = 10,
      width = 2,
      actionButton(inputId = "showInstruct",label =  icon(name ="info-circle"))
    )),
    
    fluidRow(
      column(
        offset = 4,
        width = 4,
        align = "center",
        div(
          class = "panel1",
          selectizeInput(
            inputId = "treatments_n",
            label = "How many treatments?",
            choices = c(2:6)
          ),
          numericInput("lambda",label = "Lambda",value = 30000,min = 0,max = 200000),
          checkboxInput("remove_1st_row", label = "The 1st row contains labels"),
          actionButton("reset", "Reset all fields"),
          actionButton("load_sample_data", "Load example data")
        ),
        br(),
        br(),
      ),
      fluidRow(column(
        offset = 1,
        width = 10,
        uiOutput(outputId = "input_data_ui")
      )),
      
      fluidRow(
        column(
          offset = 1,
          width = 10,
          align = "center",
          actionButton(inputId = "showDataModal",
                       label =  "Show Table", 
                       icon = icon("table")),
          actionButton(inputId = "showStabilityModal",
                       label =  "Show Stability Plot", 
                       icon = icon("area-chart"))))
        
      #fluidRow(
      #  column(
      #    offset = 1,
      #    width = 10,
      #    align = "center",
      #    h4("Check the first and last 5 rows - looks ok?")
      #  ),
      #  br(),
      #  column(
      #    offset = 1,
      #    width = 10,
      #    align = "center",
      #    panel(tableOutput("validate_q1"))
      #  )
      #)
    )
                         )
