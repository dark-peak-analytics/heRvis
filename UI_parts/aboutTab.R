aboutTab <- tabPanel(
  title = "About",
  
  tags$div(
    
    tags$h2("Purpose"),
    "This R-Shiny web-app was created to facilitate the use of the visual functions available in R packages by those not familiar with programming.",
    "The idea is this is a simple step to improve uniformity in the reporting of decision models.",
    tags$br(),
           
    tags$h2("Other software"),
    "For Value of Information Analysis and to create other plots we recommend",
    tags$a(href="http://savi.shef.ac.uk/SAVI/", "SAVI app"), " and ",
    tags$a(href="https://egon.stats.ucl.ac.uk/projects/BCEAweb/", "BCEAweb"),
    "This tool is focused primarily on the aesthetics of reporting results",
           
    tags$h2("Licence"),
    "The code for this app is available under a AGPL license on ",
    tags$a(href="https://github.com/RobertASmith/heRvis", "our GitHub account"), 
    "Please feel free to clone the repo, create issues and send pull-requests with improvements.",
    "Third parties are welcome to use the code for commercial purposes so long as all repurposed code is also made available under a AGPL license.",
    tags$br(),
    
    tags$h2("Further instructions"),
    "We are in the process of creating further instructions, in the meantime please contact us with any requests or queries.",
    
    
    tags$h2("Collaborators"),
    tags$ul(
      tags$li("Robert Smith, University of Sheffield"),
      tags$li("Paul Schneider, University of Sheffield")
    ),
    "We would also like to thank the following for their comments on the tool:",
    tags$ul(
      tags$li("Rami Cosulich, University of Sheffield"), 
      tags$li("Frederick Theilen, Erasmus University Rotterdam")
    )
    
    
    
    
    )
  
  
  
  
  
) # end tab panel
