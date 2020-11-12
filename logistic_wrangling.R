# R script for logistic data wrangling
# Samuli Koponen
# 11.11.2020
# Data is downloaded from: https://archive.ics.uci.edu/ml/datasets/Student+Performance

install.packages("dplyr")
library(dplyr)

# Download the zip file and unzip it to the data folder 
download.file('https://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip', './data/alc.zip')
unzip("./data/alc.zip", exdir = "./data/student")

# Read the data into matrices
por <- read.table("./data/student/student-por.csv", sep = ";", header=TRUE)
math <- read.table("./data/student/student-mat.csv", sep = ";", header=TRUE)

# Explore the structure and dimensions of datasets
str(por)
str(math)
dim(por)
dim(math)

# Both data sets contain 33 variables. There are 649 observations in .por data and 395 observations in .math data.

# The datasets lack identifiers and we have to identify respondents "by hand". The following function creates a set of variables that are used instead of ID.
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mathpor <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

alc <- select(mathpor, one_of(join_by))
colnames(alc)

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]


# The next R code combines the "left over" columns. The loop checks each column name and joins them together if it's in numeric form.
for(column_name in notjoined_columns) {
  two_columns <- select(mathpor, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

# Next I create new variable alc_use by calculating the mean of alcohol use in weekdays and weekends
alc_pick <- c("Walc", "Dalc")
alc$alc_use <- rowMeans(alc[colnames(alc) %in% alc_pick])
alc <- mutate(alc, high_use = alc_use > 2)

# Now, let's glimpse at the data. There should be 382 observations and 35 variables..
glimpse(alc)

# Good to go! Let's save the data and get to work!

write.csv(alc, "./data/alc_data.R")