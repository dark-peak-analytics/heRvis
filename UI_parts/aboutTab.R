aboutTab <- tabPanel(
  title = "About",
  # Row1
  fluidRow(column(
    offset = 1,
    width = 5,
    h3("Step 1: Input Data"),
    tags$ol(
      tags$li("Input the names of the treatments"), 
      tags$li("Paste in total costs & total QALYs"), 
      tags$li("Check the first 5 and last 5 rows")
    )
  ),column(width = 5,
           offset = 1,
           align="center",
           br(),
    img(
      src = "RotatingGif.gif",
      align = "center",
      height = '70px',
      width = '70px'
    ),
    br()
    )),
  tags$hr(),
  
  
  fluidRow(column(
    offset = 1,
    width = 5,
    h3("Step 2: Customise & download"),
    tags$ol(
      tags$li("Select a plot or table"),
      tags$li("Choose treatments and customise aesthetics"),
      tags$li("Download the visual in the required format")
      ),
  ),column(width = 5,
           offset = 1,
           align="center",
           br(),
           img(
             src = "RotatingGif.gif",
             align = "center",
             height = '70px',
             width = '70px'
           ),
           br())),
  tags$hr(),
  
  
  fluidRow(column(
    offset = 1,
    width = 5,
    h3("Step 3: Get a coffee")
    ),column(width = 5,
           offset = 1,
           align="center",
           img(
             src = "RotatingGif.gif",
             align = "center",
             height = '70px',
             width = '70px'
           )))
  
  
) # end tab panel
