#  ---------------------------
#  Script name: UI
#  Purpose of script: heRvis ShinyApp
#  Author(s): Robert A Smith & Paul P Schneider
#  Date Created: 2020-11-04
#  Copyright (c) Dark Peak Analytics 2020
#  Email: darkpeakanalytics@gmail.com
#  ---------------------------
#  Notes:  relies on darkpeak package functions                    
#  ---------------------------

#================================================================
#                   Create User Interface
#================================================================

ui <- dashboardPage(
  
  header = header1,
  
  #sidebar = sidebar1,
  
  body = body1,
  
  skin = "blue",
  
  title = "heRvis"
  
)