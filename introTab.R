introTab <- tabPanel("Introduction",
         sidebarLayout(
           sidebarPanel(
             radioButtons("plotType", "Plot type",
                          c("Scatter"="p", "Line"="l")
             )
           ),
           mainPanel(
             plotOutput("plot")
           )
         )
)