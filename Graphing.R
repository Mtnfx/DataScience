library(tidyverse)
#Note that for this code to work, clean_data must be intialized and cleaned already and so preprocess_complete_data.R must have been run.
#This entire section generates a multitude of visualizations and saves the significant ones
new_clean_data = clean_data %>% mutate(Exercise_Count = str_count(Exercises, ',') + 1)
ggplot(data = new_clean_data) + geom_point(mapping = aes(x = Duration, y = Exercise_Count)) #This shows little or no correlation between exercise numbers and duration

# Graphing Information on Instructors (This is the most important section of graphs in my opinion)
Instructor_Data = new_clean_data %>% group_by(Instructor_ID) %>% summarise(Total_Hours = sum(Duration), Total_Exercises = sum(Exercise_Count), Hourly_Exercises = Total_Exercises/Total_Hours, Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Total_Hours)) #This plot is Instructors vs total hours worked.


#modified by wasim
Coeftext = paste("r =" , toString(cor(Instructor_Data %>% select(Total_Hours), Instructor_Data %>% select(Total_Exercises), method = c("pearson"))[1][1]))
ggplot(data = Instructor_Data, aes(x = Total_Hours, y = Total_Exercises)) + geom_point()  +
  geom_smooth(method='lm', formula= y~x, se = FALSE)+  geom_text(aes(x = 250, y = 300), label = Coeftext) +
  ggtitle("Hours of Instruction by Instructors vs Total Exercises Students Completed") + ggsave("img/Exercises_Vs_Duration.png") # Plot total hours vs total exercises. This plot shows that exercises are strongly correlated to time over longer periods of time.
#Wasim: Hey I modified the code above to include a linear regression line and coefficient to show how strong the correlation is

#modified by wasim

ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Hourly_Exercises)) + ggtitle("Average Exercises Students Completed per Hour by Instructor") + ggsave("img/Hourly_Exercises.png") # This plot shows the number of exercises each instructors students completed per hour.
ggplot(Instructor_Data) + geom_col(mapping = aes(x = Instructor_ID, y = Average_Hours)) + ggtitle("Average Number of Instructing Hours by Instructor") + ggsave("img/Hours_Per_Year.png") # This plot is the average hours of instruction per year for each instructor.
Instructor_Trendline_Data = Instructor_Data %>% summarize(X_Mean = mean(Average_Hours), Y_Mean = mean(Hourly_Exercises), m = sum((Average_Hours - X_Mean)*(Hourly_Exercises - Y_Mean))/sum((Average_Hours - X_Mean)^2), b = Y_Mean - X_Mean*m)
ggplot(data = NULL) + geom_point(data = Instructor_Data, mapping = aes(x = Average_Hours, y = Hourly_Exercises)) + geom_abline(data = Instructor_Trendline_Data, mapping = aes(slope = m, intercept = b)) + ggtitle("Average Hours Instructed per Year vs Average Hourly Exercises Students Completed") + ggsave("img/Average_Hours_Vs_Hourly_Exercises.png")

# Graphing information on student training times and efficiency
Student_Data = new_clean_data %>% group_by(Student_ID) %>% summarise(Total_Hours = sum(Duration), Average_Hours = (sum(Duration)/(max(Year) - min(Year))))
ggplot(Student_Data) + geom_col(mapping = aes(x = Student_ID, y = Total_Hours)) # Plots total flight hours by each student
ggplot(Student_Data) + geom_col(mapping = aes(x = Student_ID, y = Average_Hours)) # Plots average flight hours by each student

# Graphing Information on individual exercise sets (Deemed to be non-significant)
clean_data_sums = clean_data %>% group_by(Exercises) %>% summarize(Average_Duration = mean(Duration), Max_Duration = max(Duration), Min_Duration = min(Duration), Duration_Range = Max_Duration - Min_Duration, Std = sd(Duration))
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Average_Duration)) # Plot for average duration of all specific exercise sets.
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Duration_Range)) # Plot for range of durations for each unique exercise set.
ggplot(data = clean_data_sums) + geom_col(mapping = aes(x = Exercises, y = Std)) # Plot for standard deviations of each unique exercise set

# Graph Average Efficiency of all Training Methods
new_clean_data %>% group_by(Training_Type) %>% summarize(Average_Eff = mean(Exercise_Count/Duration)) %>% ggplot() + geom_col(mapping = aes(x = Training_Type, y = Average_Eff)) + ggtitle("Average Exercises per Hour by Training Method") + ggsave("img/Training_Type_Eff.png")



#This section works with Aditya's Air Traffic Data

h = read_xlsx("Total movements final.xlsx")
p = h %>% filter(YEAR >= 2015) %>% group_by(YEAR, MONTH) %>% summarize(Monthly_Total = sum(TOTAL_VALUE), Date_Stamp = paste(MONTH,YEAR, sep="-")) %>% distinct(Date_Stamp, .keep_all = TRUE)
ggplot(data = p) + geom_point(mapping = aes(x = Date_Stamp, y = Monthly_Total))

Monthly_Data = clean_data %>% group_by(Year, Month) %>% summarize(Monthly_Training_Hours = sum(Duration), Date_Stamp = paste(Month,Year, sep="-")) %>% distinct()
Monthly_Data = Monthly_Data %>% inner_join(p, by="Date_Stamp")

Traffic_Trendline_Data = data.frame(Monthly_Traffic = Monthly_Data$Monthly_Total, Training_Hours = Monthly_Data$Monthly_Training_Hours)

#Create Trendline for Monthly Traffic
Traffic_Trendline_Data = Traffic_Trendline_Data %>% summarize(X_Mean = mean(Monthly_Traffic), Y_Mean = mean(Training_Hours), m = sum((Monthly_Traffic - X_Mean)*(Training_Hours - Y_Mean))/sum((Monthly_Traffic - X_Mean)^2), b = Y_Mean - X_Mean*m)
ggplot(data = NULL) + geom_point(data = Monthly_Data, mapping = aes(x = Monthly_Total, y = Monthly_Training_Hours)) + geom_abline(data = Traffic_Trendline_Data, mapping = aes(slope = m, intercept = b))

