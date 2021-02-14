library(ggplot2)
#Note that for this code to work, clean_data must be intialized and cleaned already and so preprocess_complete_data.R must have been run.

new_clean_data = clean_data %>% mutate(Exercise_Count = str_count(Exercises, ',') + 1)
ggplot(data = new_clean_data) + geom_point(mapping = aes(x = Duration, y = Exercise_Count)) #This shows little or no correlation between exercise numbers and duration

Instructor_Data = new_clean_data %>% group_by(Instructor_ID) %>% summarise(Total_Hours = sum(Duration))
ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Total_Hours)) #This plot is Instructors vs total hours worked.

Instructor_Average_Data = new_clean_data %>% group_by(Instructor_ID) %>% summarise(Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Instructor_Average_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Average_Hours)) # This plot is the average hours of instruction per year for each instructor.

Student_Data = new_clean_data %>% group_by(Student_ID) %>% summarise(Total_Hours = sum(Duration))
ggplot(Student_Data) + geom_col(mapping = aes(x = Student_ID, y = Total_Hours)) # Plots total flight hours by each student

Student_Average_Data = new_clean_data %>% group_by(Student_ID) %>% summarise(Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Student_Average_Data) + geom_col(mapping = aes(x = Student_ID, y = Average_Hours)) # Plots average flight hours by each student