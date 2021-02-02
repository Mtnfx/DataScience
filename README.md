# DataScience
Project for STAA57

Welcome everyone!

This will act as a sort of message board for our group.

If  anyone needs anything between our meetings, please type here.

## Alec
- Done manual Excel cleaning as best as possible `Prof. Damouras has responded on Piazza and told me that we can remove any data points that are incomplete. I have uploaded a supplementary file with all incomplete data removed. This can be used until I finish the automatic processing algorithm on the R file.`
  
- Writing R Script to automatically do the filtering I did manually.
  - Our results (Including filtering) must be reproducible
  - preprocess_complete_data.R currently does all preprocessing (as initial code preprocess_data.R did), removes all observations with a duration of NULL, replaces all incorrectly labelled years with the assumed correct year, and replaces all period seperators in exercise lists with commas. `I believe all that's left is to fix double commas`
  - Since data is mostly date sorted, I know for almost certain what the incorrect dates should be and thus the years should be correct if my for loop replaces data in the same fashion I did manually.
  - clean_data_sta.csv in the data folder shows the current output of running preprocess_complete_data.R
  
- Currently analyzing data to check for potential correlations (This may potentially generate new questions or give better foundation for answering already existing questions)
  - Preliminary Excel analysis of instructors 1, 3, and 4 shows a fairly clear negative correlation between training time and efficiency. Unsure of whether this is causation or    whether other factors may be the reason for correlation.
  
## Aditya


## MD Wasim


## Vishal
- Importing supplement data : "import_supplemental_data.R"
  - (table name : variables) 
  - exercises_key : Exercise_id, Exercise_name
  - decimal_key : Decimal, Lower_bound, Upper_bound // bounds in mins
  - seasons_four and seasons_two : Season, Start, End // Start and End are in "MM-DD" format
- Forming questions and looking for respective external data
