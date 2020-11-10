
footer = div(
  class="footer",
  style="line-height: 20px;",
  column(width = 2,
         align="center",
         HTML("<img src='logo_concise.PNG' width='70px' height='70px'/>")  ),
  column(width = 8,
         HTML("<p><b>heRvis</b> was created by Robert Smith & Paul Schneider of"),
         tags$a(href="https://www.darkpeakanalytics.com/", "Dark Peak Analytics."),
         HTML("</p>"),
         HTML("<p>For more information contact"),
         tags$b("darkpeakanalytics@gmail.com"),
         HTML("</p>")
  )
  )
  

