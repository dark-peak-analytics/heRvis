gen_treatment_name_fields = function(n){
  res = c()
  for(i in 1:n){
    name_i = textInput(
      inputId = paste0("treatment_name_",i),
      label = paste0("Name of Treatment ",i),
      value = paste0("Treatment ",i)
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
        name_i,
        column(12,align="center",h4("Copy-paste")),
        br(),
        column(6,q_field_i,
               style="padding-left:0;margin-left:-5px;padding-right:0;margin-right:-5px"
        ),
        column(6,
               t_field_i,
               style="padding-left:0;margin-left:-5px;padding-right:0;margin-right:-5px"
        )
      )
    )
    res <- list(res,col_i)
  }

  return(res)
}