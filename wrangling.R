# Installing some packages to get select function
# WARNING! It takes quite a long time to download and install the whole tidyverse package. But once it's done, it's done!
install.packages("dplyr")
library(dplyr)

# Loading data to data frame
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = T, sep = "\t")

# Inspecting the structure of the data. There seems to be 183 observations and 60 variables. Most of them
# are in numeric form. Only gender is a string variable.
str(data)

# Picking up and making the sum variables for deep, strategic and surface learning
deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_col <- select(data, one_of(deep))
data$deep <- rowMeans(deep_col)
surf_col <- select(data, one_of(surface))
data$surf <- rowMeans(surf_col)
stra_col <- select(data, one_of(strategic))
data$stra <- rowMeans(stra_col)

# Making the analysis data set
analysis <- c("gender", "Age", "Attitude", "deep", "surf", "stra", "Points")
dataset <- select(data, one_of(analysis))

# Checking the structure of analysis data set
str(analysis)

# 183 observations and 7 variables. All is good!

# Setting working directory
setwd("C:/Users/Samuli/OneDrive/Tilastotiede/Open data/IODS-project")

# Saving the data and opening it again
write.csv(dataset, "./data/learning.csv", row.names = F)
dataset2 <- read.csv("./data/learning.csv")

# Checking the structure if it's correct
str(dataset2)
head(dataset)
head(dataset2)

# All checks out!