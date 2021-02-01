# DataScience
Project for STAA57

Welcome everyone!

This will act as a sort of message board for our group.

If  anyone needs anything between our meetings, please type here.

## Alec
- Currently cleaning Excel data (attempting to fill in missing data)
  - One exercise remains unfixed (waiting for response from client) `Analysis can probably be started just omitting that one data point`
  - Several missing flight times have also been discovered (waiting for response from client) `Prof. Damouras has responded on Piazza and told me that we can remove any data points that are incomplete. I have uploaded a supplementary file with all incomplete data removed.`
  
- Writing R Script to automatically do the filtering I did manually.
  - Our results (Including filtering) must be reproducible
  - preprocess_complete_data.R currently does all preprocessing (as initial code preprocess_data.R did), removes all observations with a duration of NULL, and replaces all incorrectly labelled years with the assumed correct year
  - Since data is mostly date sorted, I know for almost certain what the incorrect dates should be and thus the years should be correct if my for loop replaces data in the same fashion I did manually.
  
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
