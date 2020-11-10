gen_treatment_name_fields = function(n){
  
  require(ggthemes)
  res = c() # a list
  my_color_pallete = gdocs_pal()(6)[c(2, 1, 3:6)]
  
  for(i in 1:n){
    name_i = textInput(
      inputId = paste0("treatment_name_", i),
      label = paste0("Strategy ", i),
      value = paste0("Strategy ", i),
      width = "100%"
    )
    color_i = colourInput(
      inputId = paste0("treatment_color_", i),
      label = "Pick a color",
      showColour = "both",
      value = my_color_pallete[i]
    )
    q_field_i = textAreaInput(
      inputId = paste0("QALY",i),
      label = paste0("QALYs"),
      height = "150px",
    )
    t_field_i = textAreaInput(
      inputId = paste0("COSTS",i),
      label = paste0("costs"),
      height = "150px",
    )
    col_i = column(
      width = floor(12/as.numeric(n)),
      panel(
        column(7,name_i),column(5,color_i),align="center",
        column(12,align="center",h4("Copy-paste")),
        br(),
        column(6,q_field_i,align="center",
               style="padding-left:0;margin-left:-5px;padding-right:0;margin-right:-5px"
        ),
        column(6,
               t_field_i,align="center",
               style="padding-left:0;margin-left:-5px;padding-right:0;margin-right:-5px"
        )
      )
    )

    res <- list(res,col_i)
  }

  return(res)
}

# gen_treatment_name_fields(10)


