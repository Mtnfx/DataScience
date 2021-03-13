prop_completed_exercise = function(df){
  #df is a data frame. Creates but does not output data frame with what fraction of sessions in the data frame contain each exercise. (df MUST contain the column Exercises)
  ex_cmp_proportion = data.frame(Exercise = int(), Proportion = float())
  for (i in 1:30){
    tmp = df %>% mutate(has_n = (str_detect(Exercises, paste("^", as.character(i), ",", sep="")) | str_detect(Exercises, paste("^", as.character(i), "$",sep="")) | str_detect(Exercises, paste(",", as.character(i), ",",sep="")) | str_detect(Exercises, paste(",", as.character(i), "$",sep="")))) %>% summarize(ex_comp_prop = mean(has_n))
    ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = as.numeric(tmp[1][1]))
  }
}

ex_n_sessions = function(df, n){
  #Creates graph of proportion of students that completed each exercise at least once in their first n sessions. Looking into accuracy as I have found some discrepancies in the analysis this generates.
  first_n = df %>% group_by(Student_ID) %>%  top_n(n, desc(date)) %>% distinct( Session_ID, .keep_all = T) %>% mutate( Exercises = str_split(Exercises, ",") ) %>%  unnest( Exercises) %>% group_by(Student_ID) %>% distinct(Exercises, .keep_all=TRUE)
  ex_cmp_proportion = data.frame(Exercise = integer(), Proportion = numeric())
  n_students = first_n %>% ungroup() %>% summarize(n_distinct(Student_ID)) %>% as.numeric()
  for (i in 1:30){
    tmp = first_n %>% ungroup() %>% filter(Exercises == as.integer(i)) %>% summarize(n = n()) %>% as.numeric()
    prop = tmp/n_students
    ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = prop)
  }
  ex_cmp_proportion %>% ggplot() + geom_col(mapping = aes(x = Exercise, y = Proportion))
}


#I put this in a function put it didn't define properly. This code will generate a data frame (prior_solo) containing all sessions  for each student before their first solo session.
#This code assumes that solo sessions are  conducted last on a day when a  student commpletes multiple sessions.
first_solo = clean_data %>% filter(Training_Type == "LF_solo") %>% group_by(Student_ID) %>% top_n(1, desc(date))
ind_solo = first_solo[1,]
prior_solo = clean_data %>% filter(Student_ID == as.integer(first_solo[1,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")

for (i in 2:nrow(first_solo)){
  ind_solo = first_solo[i,]
  tmp = clean_data %>% filter(Student_ID == as.integer(first_solo[i,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")
  prior_solo = bind_rows(prior_solo,tmp)
}
