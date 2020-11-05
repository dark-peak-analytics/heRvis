
footer = div(
  class="footer",
  style="line-height: 20px;",
  br(),
  column(width = 2,
         align="center",
         HTML("<img src='hexSticker.png' width='70px' height='70px'/>")
  ),
  column(width = 8,
         br(),
         HTML("<p><b>heRvis</b> was created by Robert Smith & Paul Schneider of"),
         tags$a(href="https://www.darkpeakanalytics.com/", "Dark Peak Analytics."),
         HTML("</p>"),
         HTML("<p>For more information contact"),
         tags$b("darkpeakanalytics@gmail.com"),
         HTML("</p>")
  ),
  column(width = 2,
         align="center",
         HTML("<img src='logo_concise.png' width='70px' height='70px'/>"))
  )
  

