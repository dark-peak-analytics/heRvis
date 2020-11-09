checkStability <- function(total_costs = example_TC,
                           total_qalys = example_TQ,
                           strategies = NULL,
                           ci_lower = 0.025,
                           ci_upper = 0.975,
                           BS_samples = 500,
                           withinShiny = F,
                           lambda = 20000,
                           plot_CnQ = T){
  
  # test the number of rows are equal in cost and qaly matrices
  testthat::expect_equal(nrow(total_costs),nrow(total_qalys))
  
  if(!is.null(strategies)){
    total_costs <- total_costs[,strategies]
    total_qalys <- total_qalys[,strategies]}
  
  # test the number of columns are equal in cost and qaly matrices.
  testthat::expect_equal(ncol(total_costs),ncol(total_qalys))
  
  #=== NET BENEFIT ===========================#
  
  NB = total_qalys * lambda - total_costs
  
  
  #=== COSTS =================================#
  
  makeBSmeans <- function(bs_m_PSA = total_qalys,
                          name = "QALYs"){
    m_CumMeans <- apply(
      X = bs_m_PSA,
      MARGIN = 2,
      FUN = function(x)
        cumsum(x) / seq_along(x)
    )
    
    long_CumMeans <- reshape2::melt(
      data = m_CumMeans,
      value.name = "Mean Cost/QALYs",
      varnames = c("Number of PSA", 'Strategy')
    )
    
    long_CumMeans$Metric = name
    long_CumMeans$`Number of PSA` = 1:nrow(m_CumMeans)
    
    
    return(long_CumMeans)
  }
  
  if(withinShiny){
    
    withProgress(message = 'Running Simulations',
                 value = 0, {
                   # Run user specified number of times
                   
                   BS_values <- lapply(X = 1:BS_samples,
                                       
                                       FUN = function(x){
                                         
                                         #cat(paste0(round(x / BS_samples * 100), '% completed'))
                                         #if (x == BS_samples) cat(': Building Plot')
                                         #else cat('\014')
                                         incProgress(amount = 1/BS_samples,
                                                     detail = paste("Doing part",x))
                                         
                                         
                                         BSsample <- sample(x = 1:nrow(total_qalys),
                                                            size = nrow(total_qalys),
                                                            replace = F)
                                         
                                         rbind(makeBSmeans(bs_m_PSA = total_qalys[BSsample,],name = "QALYs"),
                                               makeBSmeans(bs_m_PSA = total_costs[BSsample,],name = "Costs"),
                                               makeBSmeans(bs_m_PSA = NB[BSsample,],name = "Net Benefit"))
                                         
                                         
                                       }) # close lapply
                   
                 }) # close with progress
    
  } else{
    
    BS_values <- lapply(X = 1:BS_samples,
                        
                        FUN = function(x){
                          
                          
                          cat(paste0(round(x / BS_samples * 100), '% completed'))
                          if (x == BS_samples) cat(': Building Plot')
                          else cat('\014')
                          
                          #Randomly order PSA runs
                          BSsample <- sample(x = 1:nrow(total_qalys),
                                             size = nrow(total_qalys),
                                             replace = F)
                          
                          # Bind rows together to make one data-set
                          rbind(
                            makeBSmeans(bs_m_PSA = total_qalys[BSsample,],name = "QALYs"),
                            makeBSmeans(bs_m_PSA = total_costs[BSsample,],name = "Costs"),
                            makeBSmeans(bs_m_PSA = NB[BSsample,],name = "Net Benefit"))
                          
                        } # close functions
                        
    ) # close lapply
  } # close if else
  
  
  #=== COMBINE BOOTSTRAP DATA =================================#
  
  dt_BSresults <- data.table::rbindlist(l = BS_values,
                                        idcol = "BS_run")
  
  dt_BSresults <- dt_BSresults[, .(min = quantile(`Mean Cost/QALYs`,ci_lower),
                                   max = quantile(`Mean Cost/QALYs`,ci_upper),
                                   `Mean Cost/QALYs` = mean(`Mean Cost/QALYs`)),
                               by = .(Strategy, Metric, `Number of PSA`)]
  
  #=== LIMIT TO DATASET =================================#
  
  if(plot_CnQ == F){
    
    dt_BSresults <- dt_BSresults[dt_BSresults$Metric == "Net Benefit",]
    
  }
  
  #=== PLOT FACET =================================#
  
  withProgress(message = 'Making plot',
               value = 0, {
  
  ggplot2::ggplot(data = dt_BSresults,
                  mapping = ggplot2::aes(x = `Number of PSA`,
                                         y = `Mean Cost/QALYs`,
                                         col = Strategy))+
    ggplot2::theme_minimal()+
    ggplot2::labs(title = "Stability of PSAs",
                  subtitle = paste0("Credible intervals & means based on reording the results table ",BS_samples, " times."))+
    ggplot2::ylab(label = "")+
    ggplot2::geom_line()+   # add lineplot
    ggplot2::geom_ribbon(ggplot2::aes(ymin = min, ymax = max, fill = Strategy),alpha = 0.3)+
    ggplot2::facet_wrap(~Metric,
                        nrow = 1,
                        scales =  "free_y")  # facet split
                 
               }) # close withprogress
  
}
