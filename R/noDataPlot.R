# no data plot

noDataPlot <- function() {
  ggplot() +
    theme_void() +
    geom_label(aes(x = 1,y = 1,label = "NO DATA"),
               size = 20)
}