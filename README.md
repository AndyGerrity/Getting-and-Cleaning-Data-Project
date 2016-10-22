# Getting-and-Cleaning-Data-Project


The R script, run_analysis.R, does the following:

  1  If it does not already exist in the working directory the script downloads the dataset and unzips it
  
  2  Loads he training & test datasets, the activity and feature info and subject data
  
  3  Merges the subject datasets, activity datasets and the features datasets
  
  4  Combines the activity and subject datasets and then that with the features dataset
  
  5  Subsets the data extracting only those rows that have mean and std deviation
  
  6  Names the rows and columns in the dataset
  
  7  Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
  
  8  The end result is shown in the file tidy.txt.

