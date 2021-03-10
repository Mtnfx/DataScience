prop_completed_exercise = function(df){
  #df is a data frame. Creates but does not output data frame with what fraction of sessions in the data frame contain each exercise. (df MUST contain the column Exercises)
  ex_cmp_proportion = data.frame(Exercise = int(), Proportion = float())
  for (i in 1:30){
    tmp = df %>% mutate(has_n = (str_detect(Exercises, paste("^", as.character(i), ",", sep="")) | str_detect(Exercises, paste("^", as.character(i), "$",sep="")) | str_detect(Exercises, paste(",", as.character(i), ",",sep="")) | str_detect(Exercises, paste(",", as.character(i), "$",sep="")))) %>% summarize(ex_comp_prop = mean(has_n))
    ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = as.numeric(tmp[1][1]))
  }
}
