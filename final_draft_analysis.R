
clean_data %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), numEx = str_count(Exercises, ",") + 1) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(totalEx = cumsum(numEx)) %>% 
  select( Student_ID, Training_Type, Date, totalEx ) %>% 
  mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% slice(1) %>% 
  select(Student_ID, totalEx, solo_flight) %>% 
  ungroup() -> solo

clean_data %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), numEx = str_count(Exercises, ",") + 1) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(totalEx = cumsum(numEx)) %>% 
  select( Student_ID, Training_Type, Date, totalEx ) %>% 
  mutate( solo_flight = !str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% arrange(desc(Date)) %>% slice(1) %>% 
  select(Student_ID, totalEx, solo_flight) %>% 
  anti_join(clean_data %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
              mutate(Date = as.Date(Date)) %>%
              group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
              select( Student_ID, Training_Type, Date ) %>% 
              mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
              filter( solo_flight ) %>% slice(1) %>% 
              select(Student_ID), by = "Student_ID") %>% 
  ungroup() -> non_solo

non_solo %>% mutate(solo_flight = FALSE) -> non_solo

solo %>% 
  union(non_solo) %>% 
  select(solo_flight, totalEx) %>% 
  mutate(solo_flight = factor(solo_flight, levels = c(FALSE,TRUE), 
                              labels = c("never flew solo", "flew solo"))) %>%
  ggplot(aes(x=solo_flight, y=totalEx)) + geom_boxplot() + 
  xlab("Solo Flight") + ylab("Exercises") + 
  ggtitle("Number of Exercises Completed vs Solo Flight") +
  theme(plot.title = element_text(hjust = 0.5))

solo %>% 
  union(non_solo) %>% 
  select(solo_flight, totalEx) %>% 
  mutate(solo_flight = factor(solo_flight, levels = c(FALSE,TRUE), 
                              labels = c("non-solo", "solo"))) %>%
  coin::independence_test(totalEx ~ solo_flight, data = ., distribution = "approx")

######################################################################################

clean_data %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>%
  select( Student_ID, Training_Type, Date) %>% 
  mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% slice(1) %>% 
  select(Student_ID, Date) -> date_of_solo

weather %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% inner_join(date_of_solo) %>% 
  select(Student_ID, Date, `Spd of Max Gust (km/h)`) %>% 
  drop_na(`Spd of Max Gust (km/h)`) %>% 
  ggplot(aes(x=`Spd of Max Gust (km/h)`)) + geom_bar() +
  ylab("Number of Sessions") +
  ggtitle("Number of First Solo Flights vs Spd of Max Gust") +
  theme(plot.title = element_text(hjust = 0.5))

######################################################################################

clean_data %>% 
  distinct( Session_ID, .keep_all = T) %>% 
  # split the exercises string into a "list" column w str_split()
  mutate( Exercises = str_split(Exercises, ",") ) %>%  
  # and expand list contents into multiple rows w/ unnest()
  unnest( Exercises) -> unnested_clean_data

unnested_clean_data %>% 
  unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  inner_join(date_of_solo, by = "Student_ID") %>% 
  filter(Date.x < Date.y) %>% 
  arrange(Exercises) %>% 
  mutate( Exercises = as.integer(Exercises)) %>% 
  mutate(Exercises = factor(Exercises)) %>% 
  group_by(Exercises) %>%
  summarise( count = n() ) %>% 
  ggplot(aes(x=Exercises, y = count/36)) + 
  ylab("Average Count") +
  geom_bar(stat = "identity") +
  ggtitle("Average Count vs Exercise") +
  theme(plot.title = element_text(hjust = 0.5))

unnested_clean_data %>% 
  unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  anti_join(date_of_solo, by = "Student_ID") %>% 
  arrange(Exercises) %>% 
  mutate( Exercises = as.integer(Exercises)) %>% 
  mutate(Exercises = factor(Exercises)) %>% 
  group_by(Exercises) %>%
  summarise( count = n() ) %>% 
  ggplot(aes(x=Exercises, y = count/83)) + 
  geom_bar(stat = "identity")

######################################################################################
