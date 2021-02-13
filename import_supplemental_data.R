# Do check if required packages are installed before running
# Update the location of the required excel file as needed on lines 7 and 11.

library(tidyverse)
library(readxl)

exercise_key <- read_xlsx("data/UofT Supplemental Information.xlsx",
                          sheet = 2, range = cell_cols("B:C"))
names(exercise_key) = c("Exercise_id", "Exercise_name")

read_xlsx("data/UofT Supplemental Information.xlsx", sheet = 2, range = cell_cols("D:E"), 
          col_names = c("Exercise_id", "Exercise_name")) %>% 
  union(exercise_key) %>% 
  arrange(Exercise_id) -> exercise_key
#View(exercise_key)

decimal_key <- tibble(
  Decimal = seq(from = 0.0, to = 1.0, by = 0.1),
  Lower_bound = c(0, seq(3, 57, 6)),
  Upper_bound = c(seq(2, 56, 6), 60)
)
#View(decimal_key)

seasons_four <- tibble(
  #This method may be more useful.
  Month = 1:12,
  Season = c(rep("Winter", 2), rep("Spring", 3), rep("Summer", 3), rep("Fall", 3), "Winter")
  
  #Season = c("Spring", "Summer", "Fall", "Winter")
  #Start = c("03-01", "06-01", "09-01", "12-01"),
  #End = c("05-31", "08-31", "11-30", "02-29")
)
#View(seasons_four)

seasons_two <- tibble(
  Month = 1:12,
  Season = c(rep("Winter", 2), rep("Summer", 6), rep("Winter", 4))
  
  #Season = c("Summer", "Winter"),
  #Start = c("03-01", "09-01"),
  #End = c("08-31","02-29")
)
#View(seasons_two)
