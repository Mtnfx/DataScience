#This code requires air_movements, clean_data, weather data, seasons_four [see import_supplemental_data.R]. 

#a1 - air_movements with Season 
#-- Remember to download file "23100003.csv" and change location
air_movements <- read_csv("ext-data/aircraft-movements/23100003.csv")
#c1 - clean_data with Season
#w1 - weather data with Season [see import_weather_data.R]

#Civil and military movements
air_movements %>% 
  filter( Airports == "Oshawa, Ontario",  str_detect(REF_DATE, "2015|2016|2017|2018|2019|2020") ) %>% 
  select( REF_DATE, `Civil and military movements`, VALUE) -> air_movements

air_movements %>% 
  separate(REF_DATE, c("Year", "Month"), sep = "-") %>% 
  mutate(Year = as.integer(Year), Month = as.integer(Month)) -> air_movements

clean_data %>% 
  inner_join(seasons_four, by = c("Month")) -> c1

#Comparing num of sessions and season for given data
c1 %>% 
  group_by(Season) %>%
  summarise(s = n_distinct(Session_ID)) %>% # sum(Duration, na.rm = T)
  ggplot(aes(x = Season, y = s)) + geom_bar(stat = "identity")

air_movements %>% 
  inner_join(seasons_four, by = c("Month")) -> a1

#Comparing air traffic for external data
a1 %>% 
  group_by(Season) %>%
  summarise(s = mean(VALUE)) %>%
  ggplot(aes(x = Season, y = s)) + geom_bar(stat = "identity")

weather %>% 
  inner_join(seasons_four, by = c("Month")) -> w1

#Comparing mean temp and season
w1 %>% 
  group_by(Season) %>%
  summarise(s = mean(`Mean Temp (°C)`, na.rm = T)) %>% 
  ggplot(aes(x = Season, y = s)) + geom_bar(stat = "identity")

#Comparing mean temp and air traffic
w1 %>% group_by(Year, Month) %>% summarise( avg_temp = mean(`Mean Temp (°C)`, na.rm = T) ) %>% 
  full_join(a1 %>% group_by(Year, Month) %>% 
              summarise( traffic = mean(VALUE, na.rm = T) ), by = c("Year", "Month")) %>% 
  ggplot(aes(x=avg_temp, y=traffic)) + geom_point() #+ facet_wrap(facets = ~Year)

#Comparing mean temp and num of sessions
w1 %>% group_by(Year, Month) %>% summarise( avg_temp = mean(`Mean Temp (°C)`, na.rm = T) ) %>% 
  inner_join(c1 %>% group_by(Year, Month) %>% 
              summarise( traffic = sum(Duration, na.rm = T) ), by = c("Year", "Month")) %>% 
  ggplot(aes(x=avg_temp, y=traffic)) + geom_point() #+ facet_wrap(facets = ~Year)

#Comparing spd of max gust and air traffic
w1 %>% group_by(Year, Month) %>% drop_na(`Spd of Max Gust (km/h)`) %>% 
  full_join(a1 %>% group_by(Year, Month) %>% 
              summarise( traffic = mean(VALUE, na.rm = T) ), by = c("Year", "Month")) %>% 
  ggplot(aes(x=`Spd of Max Gust (km/h)`, y=traffic)) + geom_bar(stat="identity") 

#Comparing spd of max gust and num of sessions
w1 %>% group_by(Year, Month) %>% drop_na(`Spd of Max Gust (km/h)`) %>% 
  inner_join(c1 %>% group_by(Year, Month) %>% 
               summarise( traffic = sum(Duration, na.rm = T) ), by = c("Year", "Month")) %>% 
  ggplot(aes(x=`Spd of Max Gust (km/h)`, y=traffic)) + geom_bar(stat="identity")


