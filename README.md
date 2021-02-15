# DataScience
Project for STAA57

Welcome everyone!

This will act as a sort of message board for our group.

If  anyone needs anything between our meetings, please type here.

## Alec
- Done manual Excel cleaning as best as possible `Prof. Damouras has responded on Piazza and told me that we can remove any data points that are incomplete. I have uploaded a supplementary file with all incomplete data removed. This can be used until I finish the automatic processing algorithm on the R file.`
  
- Writing R Script to automatically do the filtering I did manually. `Unless another unexpected typo in the data is found, this should be finished`
  - Our results (Including filtering) must be reproducible
  - preprocess_complete_data.R currently does all preprocessing (as initial code preprocess_data.R did), removes all observations with a duration of NULL, replaces all incorrectly labelled years with the assumed correct year, and replaces all period and double comma seperators in exercise lists with single commas. Whatever data cannot be fixed by the program due to lack of context is deleted. `My program only deletes 14 of the 2867 data points = ~99.5% of original data/ 0.5% loss of data`
  - clean_data_sta.csv in the data folder shows the output of running preprocess_complete_data.R on the original data
  
- Currently analyzing data to check for potential correlations (This may potentially generate new questions or give better foundation for answering already existing questions)
  - Preliminary Excel analysis of instructors 1, 3, and 4 shows a fairly clear negative correlation between training time and efficiency. Unsure of whether this is causation or    whether other factors may be the reason for correlation.
  
- I did try to analyze the average duration of single exercise sessions but most exercises either have no data or the average is unreasonably high (ex. average for sessiosn where only exercise 1 was completed was 1.05 while several 5 exercise sets including exercise 1 ran for 1.1). Thus, simply averaging single sessions won't cut it.

- Graphed Total and Average Hours for each student and for each instructor. These graphs may help if we choose to try and make judgements on scheduling and could be used to conclude which instructors should get more hours and which insturctors are overworked (This stuff is in Graphs.R).

- I've imported all the graphs I've made that I think could end up being useful to our final draft of the proposal (Hourly Exercises/Training Hours for instructors, Average Exercises per training hour for instructors, Average Exercises per Hour vs Hours fpr instructors with line of best fit, Average Exercises completed per hour for different training types).

## Aditya


## MD Wasim


## Vishal
- Importing supplement data : "import_supplemental_data.R"
  - (table name : variables) 
  - exercises_key : Exercise_id, Exercise_name
  - decimal_key : Decimal, Lower_bound, Upper_bound // bounds in mins
  - seasons_four and seasons_two : Month, Season
- Check Feb15_Analysis for all analysis I showed in meeting 2.
  - Keep in mind the library, data, tables/tibbles you need before running the code.
  - I have tried to mention everything I can in the header of the respective files.
  - Do read the comments for a better understanding and the questions I was trying to answer.
  - Analysis3(solo).R is the final file with the questions and code for the solo question, I am working on the comments and will upload soon.
  - The comments with code in between were left when I was exploring, I keep them because they might be handy later. You do not need to worry about it.
  - Also it is possible I missed something so let me know.
