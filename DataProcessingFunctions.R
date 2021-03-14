clean_data %>% mutate(is_solo = (Training_Type == "LF_solo"))
first_session = clean_data %>% arrange(Year, Month, Day) %>% distinct(Student_ID, .keep_all=TRUE)

ex_n_sessions = function(df, n){
  #Creates graph of proportion of students that completed each exercise at least once in their first n sessions
  first_n = df %>% group_by(Student_ID) %>%  top_n(n, desc(date)) %>% distinct( Session_ID, .keep_all = T) %>% mutate( Exercises = str_split(Exercises, ",") ) %>%  unnest( Exercises) %>% group_by(Student_ID) %>% distinct(Exercises, .keep_all=TRUE)
  ex_cmp_proportion = data.frame(Exercise = integer(), Proportion = numeric())
  n_students = first_n %>% ungroup() %>% summarize(n_distinct(Student_ID)) %>% as.numeric()
  for (i in 1:30){
    tmp = first_n %>% ungroup() %>% filter(Exercises == as.integer(i)) %>% summarize(n = n()) %>% as.numeric()
    prop = tmp/n_students
    ex_cmp_proportion = ex_cmp_proportion %>% add_row(Exercise = i, Proportion = prop)
  }
  ex_cmp_proportion %>% ggplot() + geom_col(mapping = aes(x = Exercise, y = Proportion)) + geom_hline(aes(yintercept = 0.7))
  return(ex_cmp_proportion)
}

clean_data %>% 
  distinct( Session_ID, .keep_all = T) %>% 
  # split the exercises string into a "list" column w str_split()
  mutate( Exercises = str_split(Exercises, ",") ) %>%  
  # and expand list contents into multiple rows w/ unnest()
  unnest( Exercises)

first_solo = clean_data %>% filter(Training_Type == "LF_solo") %>% group_by(Student_ID) %>% top_n(1, desc(date))
ind_solo = first_solo[1,]
prior_solo = clean_data %>% filter(Student_ID == as.integer(first_solo[1,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")

for (i in 2:nrow(first_solo)){
  ind_solo = first_solo[i,]
  tmp = clean_data %>% filter(Student_ID == as.integer(first_solo[i,2]) & as.numeric(date) <= as.numeric(ind_solo$date) & Training_Type != "LF_solo")
  prior_solo = bind_rows(prior_solo,tmp)
}

ex_n_sessions(prior_solo, 999)
ex_n_sessions(clean_data, 999)

# This code gets the list of first solo flights for all students
first_solo = clean_data %>% filter(Training_Type == "LF_solo") %>% group_by(Student_ID) %>% top_n(1, desc(date))
