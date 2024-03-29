makeCEAC = function (total_costs = example_TC,
                     total_qalys = example_TQ,
                     colors = NULL,
                     treatment = c("treat 1", "notreat"),
                     lambda_min = 0,
                     lambda_max = 50000,
                     currency = "GBP")
  
{

  # return an empty data-set if there is no data.
  if(ncol(total_costs)<2 | ncol(total_qalys)<2){
    return(noDataPlot())
  }
  
    legend_colors = if(!is.null(colors)){colors} else {rainbow(n = ncol(total_costs))}
    names(legend_colors) = colnames(total_costs)
    dash_numbers = 1:ncol(total_costs)
    names(dash_numbers) = colnames(total_costs)
    legend_colors = legend_colors[names(legend_colors) %in% treatment]
    legend_dash = dash_numbers[names(dash_numbers) %in% treatment]
    v_TC = total_costs[, colnames(total_costs) %in% treatment]
    v_TQ = total_qalys[, colnames(total_qalys) %in% treatment]
    lambdas <- seq(from = lambda_min, to = lambda_max, length.out = 100)
    df_CEAC = c()
    for (l in lambdas) {
        nb = v_TQ * l - v_TC
        nb = apply(nb, 1, function(x) x == max(x))
        nb = data.frame(Intervention = colnames(v_TC), lambda = l, 
            value = apply(nb, 1, mean))
        df_CEAC = rbind(df_CEAC, nb)
    }
    
    plot <- ggplot2::ggplot(data = df_CEAC, 
            ggplot2::aes(x = lambda, y = value, col = Intervention)) + 
      
      ggplot2::theme_minimal() + 
      ggplot2::geom_line(size = 1.5) +
      ggplot2::scale_y_continuous(breaks = seq(0, 1, 0.25),
                                  limits = c(0, 1),
                                  name = "Probability most cost-effective") +
      ggplot2::xlab(label = paste0("Willingness-to-pay (", currency, ")")) +
      ggplot2::labs(title = "Cost Effectiveness Acceptability Curves",
                    subtitle = "The probability each preferred intervention is most cost effective against willingness to pay for each QALY threshold.") +
      ggplot2::scale_color_manual(name = "Treatment", values = legend_colors) +
      theme(
        legend.position = "top",
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        title = element_text(size = 14)
      )
    
    return(plot)
}