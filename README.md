# DataScience
Project for STAA57

## Project Final Report Checklist
-	Recommend putting introduction in list form
-	Being more explicit regarding defining student success in intro
-	Bias in first graph? (Center closed in April 2020, possibly scrap data from 2020) `DONE`
-	Fix >39 wind speed processing error `DONE`
-	Histograms should not have gaps (Use density or scatter instead?) `DONE`
-	Break down air traffic by aircraft type `DONE`
-	Be explicit in what locations air traffic covers `DONE`
-	Consider a single year air traffic analysis (Maybe average?) `DONE BUT TO BE ADDED`
-	Describe Average_Hours variable (instructor efficiency) `DONE`
-	Clarify Time_In_School variable `DONE`
-	Filter by first solo flight for completion? `DONE`


Welcome everyone!

This will act as a sort of message board for our group.

## Solutions to Prof's Feedback
##### Saving Graph Space
- Fit two graphs on one line using command `out.width = "50%"`.
- Both graphs must be in the same block of R code.
- Should scale height relatively.
#### Formatting
- Use inline formatting for quoting numbers (mean values from Vishal's code)

## Alec
- Done manual Excel cleaning as best as possible.
  
- Writing R Script to automatically do the filtering I did manually. `Unless another unexpected typo in the data is found, this should be finished`
  - Our results (Including filtering) must be reproducible
  - preprocess_complete_data.R currently does all preprocessing (as initial code preprocess_data.R did), removes all observations with a duration of NULL, replaces all incorrectly labelled years with the assumed correct year, and replaces all period and double comma seperators in exercise lists with single commas. Whatever data cannot be fixed by the program due to lack of context is deleted. `My program only deletes 14 of the 2867 data points = ~99.5% of original data/ 0.5% loss of data`
  - clean_data_sta.csv in the data folder shows the output of running preprocess_complete_data.R on the original data
  
- Currently analyzing data to check for potential correlations (This may potentially generate new questions or give better foundation for answering already existing questions)
  - Preliminary Excel analysis of instructors 1, 3, and 4 shows a fairly clear negative correlation between training time and efficiency. Unsure of whether this is causation or    whether other factors may be the reason for correlation.
  
- I did try to analyze the average duration of single exercise sessions but most exercises either have no data or the average is unreasonably high (ex. average for sessiosn where only exercise 1 was completed was 1.05 while several 5 exercise sets including exercise 1 ran for 1.1). Thus, simply averaging single sessions won't cut it.

- Graphed Total and Average Hours for each student and for each instructor. These graphs may help if we choose to try and make judgements on scheduling and could be used to conclude which instructors should get more hours and which insturctors are overworked (This stuff is in Graphs.R).

- I've imported all the graphs I've made that I think could end up being useful to our final draft of the proposal (Hourly Exercises/Training Hours for instructors, Average Exercises per training hour for instructors, Average Exercises per Hour vs Hours fpr instructors with line of best fit, Average Exercises completed per hour for different training types).

 - Compressed the code so it fits in our proposal. `I've chopped off 31 lines  so far`

- Changing my trendline generation code to automatic (like the trendline Wasim made)

- Determining (or  at least hoping to determine) a concrete order of exercises that must be completed to fly solo.

#### Proposal - Special Notes
- I have created a new folder (img) for our data visualizations. Feel free to put in any graphs that you think might be nice to have for our proposal. Better to have too many graphs than not enough grpahs.

- Proposal has a max length of 5 pages

- Note that, without resizing, about 3 graphs will fit on 1 page


## Aditya


## MD Wasim
- Added linear correlation information about Total Exercises vs Total Hours to all related documents
  - Modified some of Alec's code to add a linear regression and compute pearson's correlation coeffiecient
  - r = 0.98 !!!! This undoubtly shows strong correlation, unless I messed something up in the code
- Import github project to RStudio Cloud
- edit Vishal's code for mean generation to reduce output size
- Tally hours of each student and check their hours against license standards (only one passed so far/ some tinkering with my code will be needed)
- Add the total duration the student was in flight school and then regress using the percentage of completion of each criteria (Not very strong correlation)
- Wrote summaries and conclusions for flight license progress
- made vishal's output for hypothesis testing inline
- Uploaded project draft report to rstudio cloud
## Vishal
- Importing supplement data : "import_supplemental_data.R"
  - (table name : variables) 
  - exercises_key : Exercise_id, Exercise_name
  - decimal_key : Decimal, Lower_bound, Upper_bound // bounds in mins
  - seasons_four and seasons_two : Month, Season
- Check Feb15_Analysis folder for all analysis I showed in meeting 2.
  - Keep in mind the library, data, tables/tibbles you need before running the code.
  - I have tried to mention everything I can in the header of the respective files.
  - Do read the comments for a better understanding and the questions I was trying to answer.
  - Analysis3(solo).R is the final file with the questions and code for the solo question, I am working on the comments and will upload soon. EDIT: It is now up, I realised that most code when read will make sense - it just took me a while to think about how to code it. If something is not clear, let me know.
  - The comments with code in between were left when I was exploring, I keep them because they might be handy later. You do not need to worry about it.
  - Also it is possible I missed something so let me know.
