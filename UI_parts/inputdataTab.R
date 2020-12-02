inputdataTab <- tabPanel(
  title = "Input data", id = "inputdata_page",

  fluidRow(

    column(
      offset = 4,
      width = 4,
      align = "center",
      br(), br(),
      panel(
        selectizeInput(
          inputId = "treatments_n",
          label = "How many strategies?",
          choices = c(2:6)
        ),
        fluidRow(
        column(width = 6, numericInput("lambda", label = "WTP Threshold", value = 30000, min = 0, max = 200000)),
        column(width = 6, textInput("currency", label = "Currency", value = "GBP"))
        ),
        
        checkboxInput("remove_1st_row", label = "Remove 1st row labels"),
        div(
          style = "padding-top:10px",
          actionButton("reset", "Reset all fields", width = "150px", icon = icon("redo")),
          actionButton("load_sample_data", "Load example", width = "150px", icon = icon("table"))
        ),
        div(
          style = "padding-top:10px",
          actionButton(
            inputId = "showDataModal", width = "150px",
            label = "Review Data",
            icon = icon("search")
          ),
          actionButton(
            inputId = "showStabilityModal", width = "150px",
            label = "Stability Plot",
            icon = icon("area-chart")
          )
        )
      ),
      br(),
    )
    ),
    fluidRow(column(
      offset = 1,
      width = 10,
      uiOutput(outputId = "input_data_ui")
    ))
)
