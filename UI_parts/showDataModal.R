showDataModal <- function(input) {
  modalDialog(
    title = NULL,
    size = "l",
    easyClose = T,
    
    fluidRow(
      column(
        offset = 1,
        width = 10,
        align = "center",
        div(style="color:white; font-size:120%; font-weight:500", "Check the first and last 5 rows - looks ok?")
      ),
      br(),
      column(
        offset = 1,
        width = 10,
        align = "center",style="color:white;",
        renderTable({
          resinputs = paste0(rep(c("QALY", "COSTS"), times = input$treatments_n),
                             rep(c(1:input$treatments_n), each = 2))
          
          res_df = c() # value
          
          # t_names = grep("treatment_name_",names(input),value = T)
          t_names = unlist(lapply(paste0("treatment_name_", 1:input$treatments_n),
                                  function(x)
                                    input[[x]]))
          t_names = rep(t_names, each = 2)
          
          for (q in seq_along(resinputs)) {
            # loop through treatments
            txt = input[[resinputs[q]]]
            if (nchar(txt) > 1) {
              res.temp = read.table(text = txt,
                                    sep = " ",
                                    fill = T)
              if (!is.null(res.temp$V1)) {
                res_df <- cbind(res_df, res.temp[, 1])
                colnames(res_df)[ncol(res_df)] <-
                  paste0(resinputs[q], " (", t_names[q], ")")
              }
            }
          } # end loop
          
          # remove first row if this is selected?
          if (!is.null(res_df)) {
            if (input$remove_1st_row) {
              res_df = res_df[-1,]
            }
            res_df = round(res_df, 2)
            res_df = rbind(head(res_df, 5),
                           rep("...", times = ncol(res_df)),
                           tail(res_df, 5))
          } else {
            res_df = c()
          }
          
          # return data-frame
          
          return(res_df)
          
        })
      )
    )
  )
  
}