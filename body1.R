body1 = dashboardBody(# open dashboardbody
  
  fluidRow(
    
    tabBox(tabPanel(title = "Results Table"),
           tabPanel(title = "Cost-effectiveness Plane"), 
           tabPanel(title = "CEAC"), 
           tabPanel(title = "Uploaded data"),
           tabPanel(title = "Further Information")
           ) # end tab box
           
    ), # close fluidRow
  
  tags$footer(tags$img(src = "Logo_Final.jpg", width = "150px", height = "150px"),
              tags$br(),
              "This user-interface was created by Robert Smith & Paul Schneider of",
              tags$a(href="https://www.darkpeakanalytics.com/", "Dark Peak Analytics."),
              tags$br(),
              "For more information contact",
              tags$b("darkpeakanalytics@gmail.com"),
              style = "position:absolute;
                       bottom:50px;
                       height:200px;
                       padding: 0px;
                       background-color: white;
                       ") #to discuss, please contact Robert Smith or Paul Schneider at darkpeakanalytics@gmail.com",
  
) # close dashboardBody

