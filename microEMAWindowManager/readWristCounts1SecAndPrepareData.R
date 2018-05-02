#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### read the actigraph counts file (1 sec epoch intervaLS) :  Wrist

uEMAWristCounts <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/WRIST/YASEEN_WRIST (2018-02-02)1secDataTable.csv", 
                              sep = ",", header = TRUE)

head(uEMAWristCounts)

#### Concatinate date time columns in date time object
uEMAWristCounts$DATE_TIME_ANKLE <- as.POSIXct(paste(uEMAWristCounts$Date, uEMAWristCounts$Time), 
                                                format = "%m/%d/%Y %H:%M:%S")

head(uEMAWristCounts)

#### use only selected columns
uEMAWristCounts <- uEMAWristCounts[, c("DATE_TIME_ANKLE", "Vector.Magnitude")]
head(uEMAWristCounts)


#### rename these columns

colnames(uEMAWristCounts)[2] <- "COUNTS_MAGNITUDE_WRIST"
head(uEMAWristCounts)