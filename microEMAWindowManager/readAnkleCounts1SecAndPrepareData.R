#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### read the actigraph counts file (1 sec epoch intervals): Ankle
uEMAAnkleCounts <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema21_activity/ANKLE/ROHAN_ANKLE (2018-07-09)1secDataTable.csv", 
                              sep = ",", header = TRUE)

head(uEMAAnkleCounts)

#### Concatinate date time columns in date time object
uEMAAnkleCounts$DATE_TIME_ANKLE <- as.POSIXct(paste(uEMAAnkleCounts$Date, uEMAAnkleCounts$Time), 
                                                format = "%m/%d/%Y %H:%M:%S")

head(uEMAAnkleCounts)

#### use only selected columns
uEMAAnkleCounts <- uEMAAnkleCounts[, c("DATE_TIME_ANKLE", "Vector.Magnitude")]
head(uEMAAnkleCounts)


#### rename these columns

colnames(uEMAAnkleCounts)[2] <- "COUNTS_MAGNITUDE_ANKLE"
head(uEMAAnkleCounts)

# uEMAAnkleCounts<-uEMAAnkleCounts[-which(is.na(uEMAAnkleCounts$DATE_TIME_ANKLE)),]
# nrow(uEMAAnkleCounts)
