# icertable 
createICERtable = function (total_costs = example_TC, total_qalys = example_TQ, 
                            ref_index = 1, ci = T, currency = "GBP") 
{

# return an empty data-set if there is no data.
if(ncol(total_costs)<2 | ncol(total_qalys)<2){
  return(DT::datatable(data = data.frame("NO DATA")))
}

  # a change
  
  
ref_index = which(colnames(total_costs) == ref_index)

  n = ncol(total_costs)
  c_f = function(x, d = 2, ci = T) {
    x = c(mean(x), quantile(x, probs = c(0.025, 0.975)))
    x = formatC(x, digits = d, big.mark = ",", format = "f", 
                drop0trailing = F)
    if (ci) {
      x = paste0(x[1], " (", x[2], "; ", x[3], ")")
    }
    else {
      x = paste0(x[1])
    }
    x[grepl("0 \\(", substr(x, 1, 3))] = "- (-, -)"
    x[grepl("0[.]0 \\(", substr(x, 1, 5))] = "- (-, -)"
    x[grepl("0[.]00 \\(", substr(x, 1, 6))] = "- (-, -)"
    x[grepl("0[.]000 \\(", substr(x, 1, 7))] = "- (-, -)"
    x
  }
  mean_C = apply(total_costs, 2, c_f, 0, ci)
  mean_Q = apply(total_qalys, 2, c_f, 3, ci)
  inc.C = cbind(total_costs[, 1:n] - total_costs[, ref_index])
  inc.C = apply(inc.C, 2, c_f, 0, ci)
  inc.Q = cbind(total_qalys[, 1:n] - total_qalys[, ref_index])
  inc.Q = apply(inc.Q, 2, c_f, 3, ci)
  NB20 = total_qalys * 20000 - total_costs
  INB20 = NB20[, ] - NB20[, 1]
  INB20 = apply(INB20, 2, c_f, 0, ci)
  NB30 = total_qalys * 30000 - total_costs
  INB30 = NB30[, ] - NB30[, 1]
  INB30 = apply(INB30, 2, c_f, 0, ci)
  
  res_table = as.data.frame(t(data.frame(mean_C, inc.C, mean_Q, 
                                         inc.Q, INB20, INB30, stringsAsFactors = F)))
  
  rownames(res_table) = c("Costs", "Incremental Costs", "QALYs", 
                          "Incremental QALYs", "INB 20,000 GBP", "INB 30,000 GBP")
  
  res_table$temp = c(paste0("Costs (", currency,")"), # Costs (input$currency)
                     paste0("Costs (", currency,")"), # Costs (input$currency)
                     "QALYs", 
                     "QALYs",
                     paste0("Incremental Net Benefit (", currency,")"), # INB (input$currency)
                     paste0("Incremental Net Benefit (", currency,")")) # INB (input$currency)
  
  # return data-table
  
  DT::datatable(data = res_table, 
                class = "compact cell-border", 
                options = list(colReorder = TRUE, 
                               dom = "tB", 
                               buttons = c("copy","csv", "excel", "pdf", "print"), 
                               columnDefs = list(list(width = "170px", 
                                                      targets = 0), 
                                                 list(visible = FALSE, 
                                                      targets = n+1)), 
                               rowGroup = list(dataSrc = n+1), 
                               initComplete = DT::JS("function(settings, json) {",
                                                     "$(this.api().table().header()).css({'background-color': '#D3D3D3', 'color': '#000'});",
                                                     "}")), 
                
                extensions = c("Buttons", "ColReorder","RowGroup"),
                
                rownames = c("Costs", "Incremental Costs",
                             
                             "QALYs", "Incremental QALYs", 
                             paste("20,000", currency), paste("30,000", currency))) # 20,000 input$currency
}