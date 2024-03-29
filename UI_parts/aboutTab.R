aboutTab <- tabPanel(
  title = "About",
  
  
  fluidPage(
    column(offset = 1,width = 10,
           br(),br(),
           panel(
             column(offset = 1,width =10,
        tags$div(
          
          tags$h2("Purpose"),
          "This R-Shiny web-app was created to facilitate the use of the visual functions available in R packages by those not familiar with programming.",
          "The idea is this is a simple step to improve uniformity in the reporting of decision models.",
          tags$br(),tags$br(),
                 
          tags$h2("Other software"),
          "For Value of Information Analysis and to create other plots we recommend",
          tags$a(href="http://savi.shef.ac.uk/SAVI/", "SAVI app"), " and ",
          tags$a(href="https://egon.stats.ucl.ac.uk/projects/BCEAweb/", "BCEAweb."),
          "This tool is focused primarily on the aesthetics of reporting results",
          tags$br(),tags$br(),
          
          tags$h2("Licence"),
          "The code for this app is available under a AGPL license on ",
          tags$a(href="https://github.com/RobertASmith/heRvis", "our GitHub account"), 
          "Please feel free to clone the repo, create issues and send pull-requests with improvements.",
          "Third parties are welcome to use the code for commercial purposes so long as all repurposed code is also made available under a AGPL license.",
          "Alternatively feel free to drop us an email with suggestions of improved functionality - we are more than happy to adapt the tool.",
          tags$br(),tags$br(),
          
          tags$h2("Further instructions"),
          "We are in the process of creating further instructions, in the meantime please contact us with any requests or queries.",
          tags$br(),tags$br(),
          
          tags$h2("Collaborators"),
          tags$ul(
            tags$li(HTML("<b>Robert Smith</b>, University of Sheffield")),
            tags$li(HTML("<b>Paul Schneider</b>, University of Sheffield"))
          ),
          tags$br(),
          "We would also like to thank the following for their comments on the tool:",
          tags$br(),
          tags$ul(
            tags$li(HTML("<b>Rami Cosulich</b>, University of Sheffield")), 
            tags$li(HTML("<b>Frederick Thielen</b>, Erasmus University Rotterdam")),
            tags$li(HTML("<b>Hazel Squires</b>, University of Sheffield"))
            
          )
        ),
        tags$br()
        )
           ))
    
    
    
    )
  
  
  
  
  
) # end tab panel
