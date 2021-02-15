#Remember to download the climate csv files and change the location on lines 6 and 12 from 
#"data/" to "your_respective_location/"

library(tidyverse)

read_csv("data/en_climate_daily_ON_6155875_2015_P1D.csv", 
         col_types = cols(Year = col_integer(), Month = col_integer(), Day = col_integer())) %>% 
  select(Year, Month, Day, `Max Temp (°C)`, `Min Temp (°C)`, `Mean Temp (°C)`, `Heat Deg Days (°C)`,
         `Cool Deg Days (°C)`, `Total Precip (mm)`, `Spd of Max Gust (km/h)`) -> weather

for(i in 2016:2020) {
  loc = c("data/en_climate_daily_ON_6155875_", as.character(i), "_P1D.csv")
  read_csv(str_c(loc, collapse = ""),
           col_types = cols(Year = col_integer(), Month = col_integer(), Day = col_integer(),
                            `Spd of Max Gust (km/h)` = col_character())) %>% 
    select(Year, Month, Day, `Max Temp (°C)`, `Min Temp (°C)`, `Mean Temp (°C)`, `Heat Deg Days (°C)`,
           `Cool Deg Days (°C)`, `Total Precip (mm)`, `Spd of Max Gust (km/h)`) %>% union(weather) -> weather
}


#wdata <- read_csv("data/en_climate_daily_ON_6155875_2019_P1D.csv",
#                     col_types = cols(Year = col_integer(), Month = col_integer(), Day = col_integer()))

#wdata %>% 
#  select(Year, Month, Day, `Max Temp (°C)`, `Min Temp (°C)`, `Mean Temp (°C)`, `Heat Deg Days (°C)`,
#         `Cool Deg Days (°C)`, `Total Rain (mm)`, `Total Snow (cm)`, `Total Precip (mm)`, `Dir of Max Gust (10s deg)`,
#         `Spd of Max Gust (km/h)`) -> wdata
