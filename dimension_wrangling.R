# Dimension wrangling
# Samuli Koponen
# Data is downloaded from http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# I totally forgot the clustering exercises, so I have to download the data.

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep =",", header = T)

library(dplyr)
library(stringr)

# The variable GNI is in string format. I needs to be converted to numeric form with the following command:
human$GNI <- str_replace(human$GNI, pattern = ",", replace = "") %>% as.numeric()

# Let's choose some interesting variables and select only the cases without missing values.

keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
human2 <- filter(human, complete.cases(human))

data.frame(human, comp = complete.cases(human)) %>% tail(, n = 10)
last <- nrow(human2) - 7
human2 <- human2[1:last, ]
rownames(human2) <- human2$Country

# Let's check the data! There _should_ be 155 observations and 9 variables.

dim(human2)
write.table(human2, "./data/human.csv")

# Hooray! The data is ready for analysis!