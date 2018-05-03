##' Robin Elahi 
##' dplyr
##' 2018-05-04

## These notes are based on:
## <https://github.com/datacarpentry/R-ecology-lesson/blob/master/03-dplyr.Rmd>

#### OBJECTIVES ####
# Describe the purpose of the **`dplyr`** and **`tidyr`** packages.
# Select certain columns in a data frame with the **`dplyr`** function `select`.
# Select certain rows in a data frame according to filtering conditions with the **`dplyr`** function `filter` .
# Link the output of one **`dplyr`** function to the input of another function with the 'pipe' operator `%>%`.
# Add new columns to a data frame that are functions of existing columns with `mutate`.
# Use the split-apply-combine concept for data analysis.
# Use `summarize`, `group_by`, and `count` to split a data frame into groups of observations, apply a summary statistics for each group, and then combine the results.
# Describe the concept of a wide and a long table format and for which purpose those formats are useful.
# Describe what key-value pairs are.
# Reshape a data frame from long to wide format and back with the `spread` and `gather` commands from the **`tidyr`** package.
# Export a data frame to a .csv file.

##### DATA MANIPULATION - INTRO #####



# download.file("https://ndownloader.figshare.com/files/2292169",
#               "data/portal_data_joined.csv")
#    

