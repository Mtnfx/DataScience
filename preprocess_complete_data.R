library(tidyverse)
rm(list = ls())

raw_data = NULL
for( i in 1:17){
  tmp = readxl::read_xlsx( "data/STAA57 Initial Data.xlsx", skip = 1, sheet = i, 
                                     col_names =  paste( "X", 1:12, sep="" ) ) %>% 
    mutate( Instructor_ID = i,
            PPL = X1,
            X1 = replace( X1, !str_detect(X1, "Student"), NA ),
            PPL = zoo::na.locf( PPL ),
            X1 = zoo::na.locf(X1) )
  raw_data = bind_rows( raw_data, tmp )
}
rm(tmp,i)

names( raw_data  ) = c( "Student", "Year", "Month", "Day", "Aircraft", "LF_dual", 
"LF_solo", "Instrument_AC",  "Instrument_Sim", "CC_dual", "CC_solo", "Exercises",
"Instructor_ID", "Licence")

head(raw_data)

raw_data %>%
  filter( !is.na(Year), Year != "Year",
          Exercises != "*NO DATA") %>% 
  mutate_at( .vars = c(2:4), .funs = as.integer ) %>% 
  mutate_at( .vars = c(6:11), .funs = as.numeric ) %>% 
  mutate( Aircraft = str_to_upper(Aircraft),
          Aircraft = replace( Aircraft, str_detect(Aircraft, "GROUND"), "GROUND"),
          Aircraft = replace_na( Aircraft, "NA"),
          Other = ifelse( str_detect(Aircraft,"GROUND|NA"), -1, NA ),
          Student_ID = as.numeric( factor( paste( Student, Instructor_ID) ) ), 
          Session_ID = row_number() ) %>% 
  gather( key = "Training_Type", value = "Duration", 6:11, Other) %>% 
  filter( !is.na(Duration) ) %>% 
  mutate( Duration  = na_if(Duration, -1),
          Aircraft = na_if(Aircraft, "NA")) %>% 
  select( Instructor_ID, Student_ID, Session_ID, Year, Month, Day, 
          Aircraft, Duration, Training_Type, Exercises, Licence ) %>% 
          filter(! is.na(Duration)) -> clean_data

clean_data %>% 
  distinct( Session_ID, .keep_all = T) %>% 
  # split the exercises string into a "list" column w str_split()
  mutate( Exercises = str_split(Exercises, ",") ) %>%  
  # and expand list contents into multiple rows w/ unnest()
  unnest( Exercises)

for (i in 2:nrow(clean_data)-1){
  if (clean_data[i,4] < 2015 && clean_data[i-1,4] == clean_data[i+1,4]){
    clean_data[i,4] = clean_data[i-1,4]
  }
}
