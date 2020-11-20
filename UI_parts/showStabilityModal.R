# showStability

showStabilityModal <- modalDialog(
    title = div(style="color:white; font-size:120%; font-weight:500", "Check whether results are stable ... "),
    size = "l",
    easyClose = F,
    
    fluidRow(div(style="color:white",
      "It is sometimes unclear how many iterations (PSA runs) are necessary in a health economic model incorporating parameter uncertainty.",
      "This is discussed in detail in a paper by ", 
      tags$a(href="https://www.valueinhealthjournal.com/article/S1098-3015(17)32408-7/abstract", "Hatswell et al."),
      "The graph below shows the 95% credible interval for the mean costs, QALYs and Net Benefit for each strategy.",
      "This is obtained by re-ordering the costs and QALYs pasted by the user 500 times and obtaining the cumulative mean from 1 to the nth iteration"), # close div
      br(),
      column(offset = 1,
             width = 10,
             align = "center",
             shinycssloaders::withSpinner(
               custom.css = T,
               image = "RotatingGif.gif",
               plotOutput(outputId = "stabilityPlot",
                          height = "400px",
                          width = "100%")
             )
             
             ))
)

        