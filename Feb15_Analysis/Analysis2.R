#This code requires c1 (clean_data with Season) [see Analysis1.R for code for c1]

#How often did instructors hold sessions per season?
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Season, Instructor_ID) %>% arrange(Instructor_ID, Date) %>%
  select(Instructor_ID, Student_ID, Session_ID, Date, Season) %>% 
  mutate(Last_training_date = as.Date(lag(Date)), 
         Days_since = Date - Last_training_date) %>% 
  summarise(avg = mean(Days_since, na.rm = T)) %>% 
  filter(avg < 100) %>% 
  summarise( mn = mean(avg) ) %>%
  ggplot(aes(x=Season, y = mn)) + geom_bar(stat = "identity")
  #View()

#How often did students train per season?
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Season, Student_ID) %>% arrange(Student_ID, Date) %>%
  select(Instructor_ID, Student_ID, Session_ID, Date, Season) %>% 
  mutate(Last_training_date = as.Date(lag(Date)), 
         Days_since = Date - Last_training_date) %>% 
  summarise(avg = mean(Days_since, na.rm = T)) %>% 
  filter(avg < 100) %>% 
  summarise( mn = mean(avg) ) %>%
  ggplot(aes(x=Season, y = mn)) + geom_bar(stat = "identity")
  #View()

#How often did a pair of Instructor-Student train per Season.
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Season, Instructor_ID, Student_ID) %>% 
  arrange(Instructor_ID, Student_ID, Date) %>%
  select(Instructor_ID, Student_ID, Session_ID, Date, Season) %>% 
  mutate(Last_training_date = as.Date(lag(Date)), 
         Days_since = Date - Last_training_date) %>% 
  summarise(avg = mean(Days_since, na.rm = T)) %>% 
  summarise( mean(avg, na.rm = T) )
  #View()

#How often was an Aircraft-Training_Type pair used?
c1 %>% group_by(Aircraft, Training_Type) %>% 
  summarise(n = n()) %>% #summarise(s = sum(num)) %>% 
  View()

#How often was the training type * per season?
c1 %>% 
  filter(str_detect(str_to_lower(Training_Type), "cc")) %>%  
                                  # "solo", "cc", "lf", "instrument"
  group_by(Season) %>% 
  summarise( n = n() ) %>% 
  ggplot(aes(x = Season, y = n)) + 
  geom_bar(stat = "identity")

#How often was the aircraft * per season?
c1 %>% filter(str_detect(Aircraft, "C-150")) %>%  
                        # "C-152", "C-172", "FMX-1000"
  group_by(Season) %>% 
  summarise( n = n() ) %>% 
  ggplot(aes(x = Season, y = n)) + 
  geom_bar(stat = "identity")
  
#Efficiency(Num of Ex/Duration for each session) of students with respect to Season.
c1 %>% 
  mutate(numEx = str_count(Exercises, ",") + 1, Efficiency = numEx/Duration) %>% 
  filter(Student_ID==6) %>% #feel free to change the ID or even remove this line.
  group_by(Season) %>% 
  summarise(mn = mean(Efficiency, na.rm = T)) %>% 
  ggplot(aes(x=Season, y=mn)) + geom_bar(stat="identity")
