instructModal <- modalDialog(
  
  title = "Instructions",
  size = "l",
  easyClose = T,
  fade = T,
  footer = footer,
  
  fluidRow(column(
  offset = 1,
  width = 6,
  h4("Step 1: Input Data"),
  tags$ol(
    tags$li("Input the names of the treatments"), 
    tags$li("Paste in total costs & total QALYs"), 
    tags$li("Check the first 5 and last 5 rows"),
    tags$li("Check the results are stable")
    
  )
),column(width = 5,
         offset = 0,
         align="center",
         br(),
         img(
           src = "inputData.gif",
           align = "center",
           height = '250px',
           width = '250px'
         ),
         br()
)),
tags$hr(),


fluidRow(column(
  offset = 1,
  width = 6,
  h4("Step 2: Customise & download"),
  tags$ol(
    tags$li("Select a plot or table"),
    tags$li("Choose strategies and customise aesthetics"),
    tags$li("Download the visual")
  ),
),column(width = 5,
         offset = 0,
         align="center",
         br(),
         img(
           src = "makingplots.gif",
           align = "center",
           height = '250px',
           width = '250px'
         ),
         br())),


tags$hr(),


fluidRow(column(
  offset = 1,
  width = 6,
  h4("Step 3: Get a coffee")
),column(width = 5,
         offset = 0,
         align="center",
         img(
           src = "coffee.gif",
           align = "center",
           height = '250px',
           width = '250px'
         ))),

fluidRow(style = "padding-top:100px")
) # close modal