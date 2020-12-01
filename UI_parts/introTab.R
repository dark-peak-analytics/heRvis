introTab <-
  tabPanel(title = "Introduction",
    
    useShinyjs(),


    br(),br(),
    column(offset = 1,width = 10,
    panel(
      fluidRow(column(offset=1,width = 2,style="padding-top:10px",
                      div(HTML("<img src='hexSticker.png' width='150px' height='150px'/>"))),
        
        column(offset = 1,
        width = 7,
        span(HTML("Welcome to the <b>h</b>ealth <b>e</b>conomic <b>R</b>shiny <b>vis</b>ualisation builder (<b>heRvis</b>)."),style="font-size:150%; font-weight:350"),
        br(),br(),
        p("Health Economists regularly use MS Excel to undertake economic evaluations. This tool allows you to take the outputs from an Excel model, and create publication quality plots and tables within minutes.")
        
      )), # close column and row
      
      br(),
      
      fluidRow(
        column(
          width = 10,
          offset = 1,
          p(
            "No programming knowledge is required. All the user needs to do is copy and paste their results into the tool, which will then create plots and tables using packages from R software environment in the background 
            (e.g. ",
            tags$a(href = "https://rstudio.github.io/DT/options.html", "DT"),
            ", ",
            tags$a(href = "https://ggplot2.tidyverse.org/", "ggplot2"),
            ", and many others). You can download the plots for use in your presentations and reports.
            The app is hosted on ",
            tags$a(href = "https://www.shinyapps.io/", "RStudio's secure server"),", no data is collected."),
          br(),
          p(
            "The tool is currently set up to create the following visuals:",
            tags$ul(
              tags$li("ICER-Table"),
              tags$li("Cost-Effectiveness Plane"),
              tags$li("Cost-Effectiveness Acceptability Curve(s)")
            )
          ),
          br(),
          p(div("Tutorial - see below",style="font-weight:500")),


          # p(
          #   "If you have any comments or suggestions feel free to contact us at: ",
          #   tags$a(
          #     href = "https://www.darkpeakanalytics.com/",
          #     "Dark Peak Analytics."
          #   ),
            br(), br()
          #)
        )
      )
        ),
        
# TUTORIAL ROWS
panel(
  fluidRow(
    column(
      width = 10,
      offset = 1,
      br(),
      div(HTML("Quick tutorial: how to use heRvis?."), style = "font-size:150%; font-weight:450; text-align:center;"),
      br(),br(),br(),
      
      # step 0
      fluidRow(
        column(
          offset = 1,
          width = 10,
          span(HTML("
          <p>If you just want to check out how the tool works, 
          go to the next tab (<b>Input data</b>) and click '<b>Load Example</b>' to generate some 
          sample results.</p>
          <p>If you want to create nice plots and tables for 
          your own data, <b>follow the steps below</b>.</p>"),style="font-size:120%")
        )
      ),
      div(style="padding-top:100px"),
      # step 1
      fluidRow(
        column(
          offset = 1,
          width = 4,
          h4("Step 1"),
          HTML("Go to the <b>Input data</b> tab and select the number of treatments you want to compare.")
        ),
        column(
          offset = 1,
          width = 6,
          h4(""),
          img(src="step_1.gif",width = "450px")
        )
      ),
      div(style="padding-top:100px"),
      # step 2
      fluidRow(
        column(
          offset = 1,
          width = 5,
          h4("Step 2"),
          HTML("Assign names to your treatments (optional).")
        ),
        column(
          width = 5,
          h4(""),
          img(src="step_2.gif",width = "450px")
        )
      ),
      div(style="padding-top:100px"),
      # step 3
      fluidRow(
        column(
          offset = 1,
          width = 5,
          h4("Step 3"),
          HTML("Copy the Cost and QALY columns for each treatment from your Excel spreadsheet and paste them into the respective field.")
        ),
        column(
          width = 5,
          h4(""),
          img(src="step_3.gif",width = "450px")
        )
      ),
      div(style="padding-top:100px"),
      # step 4
      fluidRow(
        column(
          offset = 1,
          width = 5,
          h4("Step 4"),
          HTML("Review your data to make sure everything got copy-pasted correctly. The tab shows you the first and last five rows.")
        ),
        column(
          width = 5,
          h4(""),
          img(src="step_4.gif",width = "450px")
        )
      ),
      div(style="padding-top:100px"),
        # step 4
      fluidRow(
        column(
          offset = 1,
          width = 5,
          h4("Step 5"),
          HTML("Continue to the Output tab and create some nice figures.")
        ),
        column(
          width = 5,
          h4(""),
          HTML("")
        )
      ),
      br()
    )
  )
)

      
      
      
    )#,
    # close column and row
    
    #fluidRow(
    #  HTML("<img src='rexcel1.png' width='400px' height='300px'/>"),
    #  
    #  align = "center"
    #)
    
    
    
  ) # close tabPanel
