#### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### Merge count files with uEMA data

head(combinedWristEMA)
head(combinedAnkleEMA)

keepWrist <- c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE", "ACTIVITY_CODED","ACTIVITY_NUMERIC", "COUNTS_AVERAGE_WRIST_BEFORE", 
          "COUNTS_SUM_WRIST_AFTER")

keepAnkle <- c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE", "ACTIVITY_CODED","ACTIVITY_NUMERIC", "COUNTS_AVERAGE_ANKLE_BEFORE", 
          "COUNTS_SUM_ANKLE_AFTER")

combinedWristEMA <- combinedWristEMA[keepWrist]

head(combinedWristEMA)

combinedAnkleEMA <- combinedAnkleEMA[keepAnkle]

head(combinedAnkleEMA)

countsEMADataFrame <- merge.data.frame(combinedAnkleEMA, combinedWristEMA)

head(countsEMADataFrame)

## rename odd columns

colnames(countsEMADataFrame)[8] <- "COUNTS_SUM_ANKLE_BEFORE"
colnames(countsEMADataFrame)[10] <- "COUNTS_SUM_WRIST_BEFORE"

head(countsEMADataFrame)
