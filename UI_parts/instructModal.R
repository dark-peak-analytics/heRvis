instructModal <- modalDialog(
  
  title = "Instructions",
  size = "l",
  easyClose = T,
  fade = T,
  footer = footer,
  
fluidRow(column(
  offset = 0,
  width = 6,
  h4("Step 1: Input Data"),
  tags$ol(
    tags$li("Input the names of the treatments"), 
    tags$li("Paste in total costs & total QALYs"), 
    tags$li("Check the first 5 and last 5 rows"),
    tags$li("Check the results are stable"))
  ),
  column(
  offset = 0,
  width = 6,
  h4("Step 2: Customise & download"),
  tags$ol(
    tags$li("Select a plot or table"),
    tags$li("Choose strategies and customise aesthetics"),
    tags$li("Download the visual")
  )
)),

tags$hr(),

# RadioButtons to choose Gif
fluidRow(
  column(offset=2,
         width = 8,
         align="center",
radioGroupButtons(
  choices = c("Step 1", "Step 2", "Step 3"),
  selected = "Step 1",
  label = "Choose Gif to display",
  inputId = "instructGifChoice",
  status = "primary")
)),

tags$hr(),

fluidRow(column(width = 8,
                offset = 2,
                align="center",
                br(),
                
                # insert selected gif:
                imageOutput("instructionGif"),
                br()
)),


#tags$hr(),


#fluidRow(column(
#  offset = 1,
#  width = 5,
#  h4("Step 3: Get a coffee")
#),column(width = 6,
#         offset = 0,
#         align="center",
#         img(
#           src = "coffee.gif",
#           align = "center",
#           height = '250px',
#           width = '250px'
#         ))),

fluidRow(style = "padding-top:100px")
) # close modal