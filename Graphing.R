library(tidyverse)
#Note that for this code to work, clean_data must be intialized and cleaned already and so preprocess_complete_data.R must have been run.

new_clean_data = clean_data %>% mutate(Exercise_Count = str_count(Exercises, ',') + 1)
ggplot(data = new_clean_data) + geom_point(mapping = aes(x = Duration, y = Exercise_Count)) #This shows little or no correlation between exercise numbers and duration

Instructor_Data = new_clean_data %>% group_by(Instructor_ID) %>% summarise(Total_Hours = sum(Duration), Total_Exercises = sum(Exercise_Count), Hourly_Exercises = Total_Exercises/Total_Hours)
ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Total_Hours)) #This plot is Instructors vs total hours worked.
ggplot(data = Instructor_Data) + geom_point(mapping = aes(x = Total_Hours, y = Total_Exercises)) # Plot total hours vs total exercises. This plot shows that exercises are strongly correlated to time over longer periods of time.
ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Hourly_Exercises)) # This plot shows the number of exercises each instructors students completed per hour.

Instructor_Average_Data = new_clean_data %>% group_by(Instructor_ID) %>% summarise(Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Instructor_Average_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Average_Hours)) # This plot is the average hours of instruction per year for each instructor.

Student_Data = new_clean_data %>% group_by(Student_ID) %>% summarise(Total_Hours = sum(Duration))
ggplot(Student_Data) + geom_col(mapping = aes(x = Student_ID, y = Total_Hours)) # Plots total flight hours by each student

Student_Average_Data = new_clean_data %>% group_by(Student_ID) %>% summarise(Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Student_Average_Data) + geom_col(mapping = aes(x = Student_ID, y = Average_Hours)) # Plots average flight hours by each student

clean_data_sums = clean_data %>% group_by(Exercises) %>% summarize(Average_Duration = mean(Duration), Max_Duration = max(Duration), Min_Duration = min(Duration), Duration_Range = Max_Duration - Min_Duration, Std = sd(Duration))
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Average_Duration)) # Plot for average duration of all specific exercise sets.
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Duration_Range)) # Plot for range of durations for each unique exercise set.
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Std)) # Plot for standard deviations of 
