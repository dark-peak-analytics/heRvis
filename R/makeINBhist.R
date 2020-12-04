# net benefit histogram

makeINBHist = function (total_costs = darkpeak::example_TC, 
                        total_qalys = darkpeak::example_TQ, 
                        comparitor = "notreat", 
                        treatment = c("treat 1","treat 2", "treat 3"), 
                        lambda = 30000,
                        colors = NULL, 
                        currency = "GBP") 
{
  
  # calculate incremental costs and benefits
  IC =   total_costs[, treatment]  - total_costs[, comparitor]
  IQ =   total_qalys[, treatment] -  total_qalys[, comparitor]
  
  # calculate incremental net benefit
  INB = IQ * lambda - IC
  
  # melt so can be plotted
  INB_long <- reshape2::melt(INB,na.rm = F) ; colnames(INB_long) = c("PSA","Strategy","INB")
  
  ggplot(data = INB_long, 
         mapping = aes(x = INB, fill = Strategy))+
    geom_density(aes(alpha = 0.5))+
    theme_minimal()+
    theme(
      legend.position = "top",
      legend.text = element_text(size = 14),
      legend.title = element_text(size = 14),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      title = element_text(size = 14)
    )+
    scale_x_continuous(label = label_comma(prefix = "\u00A3", scale = 1e-3, suffix = "k"))
    
}

makeCEPlane()