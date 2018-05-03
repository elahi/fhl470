##' Robin Elahi 
##' starting with data
##' 2018-05-01

## These notes are based on:
## <https://github.com/datacarpentry/R-ecology-lesson/blob/master/02-starting-with-data.Rmd>

#### OBJECTIVES ####
# Describe what a data frame is.
# Load external data from a .csv file into a data frame.
# Summarize the contents of a data frame.
# Describe what a factor is.
# Convert between strings and factors.
# Reorder and rename factors.
# Change how character strings are handled in a data frame.
# Format dates.

#### SURVEY DATA ####

download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

download.file(destfile = "data/portal_data_joined.csv", 
              url = "https://ndownloader.figshare.com/files/2292169")
