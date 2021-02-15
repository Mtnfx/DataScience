#This code requires c1 (clean_data with Season) [see Analysis1.R for code for c1]

#How long did students train before flying solo?
#-- How long did they fly dual? cross-country? A particular aircraft?
#-- How many exercises did they complete? 
#-- Was there a common set of exercises that was required?
#-- Compare findings with students that did not fly solo.
#Alternatively, How long did instructors train their students before allowing solo flights?

#first - Date of each student's first training session.
#solo - Date of each student's first solo flight (students that never flew solo not included).
#fsolo - Num of sessions student participated in including first solo flight session.

#creates first
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>%
  select( Student_ID, Date ) %>% slice(1) -> first

#creates solo
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date)) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>%
  select( Student_ID, Training_Type, Date) %>% 
  mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% slice(1) %>% 
  select(Student_ID, Date) -> solo

#How many days between student's first session and first solo_flight?
inner_join(first, solo, by = "Student_ID", suffix = c(".first", ".solo")) %>% 
  mutate( gap = Date.solo - Date.first ) %>% #View() 
  ungroup() %>% 
  summarise(mean(gap, na.rm = T)) %>% View()

#creates fsolo
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), num = 1) %>% #using num just to count the cumulative num of sessions later.
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(num_sessions = cumsum(num)) %>% 
  select( Student_ID, Training_Type, Date, num_sessions ) %>% 
  mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% slice(1) %>% 
  select(Student_ID, num_sessions) -> fsolo
  
#How many sessions did students that flew solo participate in including the session with first solo flight?
fsolo %>% ungroup() %>% 
  summarise( mean(num_sessions) ) %>% View()

#How many sessions did students that never flew solo participate in?
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), num = 1) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(num_sessions = cumsum(num)) %>% 
  select( Student_ID, Training_Type, Date, num_sessions ) %>% 
  mutate( solo_flight = !str_detect(Training_Type, "solo" ) ) %>% #only want non-solo flight sessions.
  filter( solo_flight ) %>% arrange(desc(Date)) %>% slice(1) %>% #want date of last session.
  select(Student_ID, num_sessions) %>% 
  anti_join(fsolo, by="Student_ID") %>% 
  ungroup() %>% 
  summarise( mean(num_sessions) ) %>% View()

#How many exercises did students that flew solo complete? -including the session with first solo flight.
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), numEx = str_count(Exercises, ",") + 1) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(totalEx = cumsum(numEx)) %>% 
  select( Student_ID, Training_Type, Date, totalEx ) %>% 
  mutate( solo_flight = str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% slice(1) %>% 
  select(Student_ID, totalEx) %>% 
  ungroup() %>% 
  summarise( mean(totalEx) ) %>% View()

#How many exercises did students that never flew solo complete?
c1 %>% unite("Date", c(Year, Month, Day), sep = "-") %>% 
  mutate(Date = as.Date(Date), numEx = str_count(Exercises, ",") + 1) %>% 
  group_by(Student_ID) %>% arrange(Student_ID, Date) %>% 
  mutate(totalEx = cumsum(numEx)) %>% 
  select( Student_ID, Training_Type, Date, totalEx ) %>% 
  mutate( solo_flight = !str_detect(Training_Type, "solo" ) ) %>% 
  filter( solo_flight ) %>% arrange(desc(Date)) %>% slice(1) %>% 
  select(Student_ID, totalEx) %>% 
  anti_join(fsolo, by = "Student_ID") %>% 
  ungroup() %>% 
  summarise( mean(totalEx) ) %>% View()