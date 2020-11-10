
footer = div(
  class="footer",
  style="line-height: 20px;",
  column(width = 1,
         align="right",
         HTML("<img src='logo_concise.PNG' width='70px' height='70px'/>")  ),
  column(width = 7,
         HTML("<p><b>heRvis</b> was created by Robert Smith & Paul Schneider of"),
         tags$a(href="https://www.darkpeakanalytics.com/", "Dark Peak Analytics."),
         HTML("</p>"),
         HTML("<p>If you have any comments or suggestions feel free to contact us at:"),
         tags$b("darkpeakanalytics@gmail.com"),br(),br(),
         HTML("</p>"),
  ),
  column(
         width = 4,style= "padding-top:10px;",
         span(actionButton("prv",size="lg",style = "fill", HTML(paste0(icon("arrow-left"), " Go Back"))),style="padding-right:10px"),
         actionButton("nxt", HTML(paste0("Next Step ", icon("arrow-right"))),size="lg"),
         align="left"
         )
  )
  

