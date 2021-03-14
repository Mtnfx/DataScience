#Creates graph of proportion of students that completed each exercise at least once in their first n sessions
first_n = prior_solo %>% group_by(Student_ID) %>%  top_n(999, desc(date)) %>% distinct( Session_ID, .keep_all = T) %>% mutate( Exercises = str_split(Exercises, ",") ) %>%  unnest( Exercises) %>% group_by(Student_ID)
ex_cmp_proportion = data.frame(Exercise = integer(), Proportion = numeric())
n_students = first_n %>% ungroup() %>% summarize(n_distinct(Student_ID)) %>% as.numeric()
for (i in 1:30){
  tmp = first_n %>% ungroup() %>% filter(Exercises == as.integer(i)) %>% summarize(n = n()) %>% as.numeric()
  prop = tmp/n_students
  ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = prop)
}
ex_cmp_proportion %>% ggplot() + geom_col(mapping = aes(x = Exercise, y = Proportion))








prop_completed_exercise = function(df){
  #df is a data frame. Creates but does not output data frame with what fraction of sessions in the data frame contain each exercise. (df MUST contain the column Exercises)
  n_students = df %>% summarize(n_distinct(Student_ID)) %>% as.numeric()
  ex_cmp_proportion = data.frame(Exercise = integer(), Proportion = numeric())
  for (i in 1:30){
    tmp = df %>% mutate(has_n = (str_detect(Exercises, paste("^", as.character(i), ",", sep="")) | str_detect(Exercises, paste("^", as.character(i), "$",sep="")) | str_detect(Exercises, paste(",", as.character(i), ",",sep="")) | str_detect(Exercises, paste(",", as.character(i), "$",sep="")))) %>% summarize(ex_comp_prop = sum(has_n)/n_students)
    ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = as.numeric(tmp[1][1]))
  }
  ex_cmp_proportion %>% ggplot() + geom_col(mapping = aes(x = Exercise, y = Proportion))
  return(ex_cmp_proportion)
}



first_solo = clean_data %>% filter(Training_Type == "LF_solo") %>% group_by(Student_ID) %>% top_n(1, desc(date))
ind_solo = first_solo[1,]
prior_solo = clean_data %>% filter(Student_ID == as.integer(first_solo[1,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")

for (i in 2:nrow(first_solo)){
  ind_solo = first_solo[i,]
  tmp = clean_data %>% filter(Student_ID == as.integer(first_solo[i,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")
  prior_solo = bind_rows(prior_solo,tmp)
}





prop_clean = prop_completed_exercise(clean_data)
prop_solo = prop_completed_exercise(prior_solo)

prop_clean = prop_clean %>% mutate(Category = "Total")
prop_solo = prop_solo %>% mutate(Category = "Before_Solo")
prop_combined = bind_rows(prop_clean, prop_solo)