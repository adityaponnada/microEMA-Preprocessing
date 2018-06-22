library(psych)
library(plotly)
library(reshape2)
library(MASS)
library(dplyr)
library(ggplot2)


## read file

filePath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/thirtySecMappedData.csv"

combinedFile <- read.csv(filePath, sep = ",", header = TRUE)

head(combinedFile)
tail(combinedFile)


### Remove NAs from the ankle before and after columns
combinedFile <- combinedFile[!is.na(combinedFile$COUNTS_SUM_ANKLE_BEFORE),]
combinedFile <- combinedFile[!is.na(combinedFile$COUNTS_SUM_ANKLE_AFTER),]

### Convert prompt time to date time object
combinedFile$PROMPT_TIME <- as.POSIXct(combinedFile$PROMPT_TIME, format = "%Y-%m-%d %H:%M:%OS")

