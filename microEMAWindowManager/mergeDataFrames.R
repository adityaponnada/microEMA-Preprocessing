#### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### Merge count files with uEMA data

head(combinedWristEMA)

keep <- c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE", "COUNTS_AVERAGE_WRIST_BEFORE", 
          "COUNTS_AVERAGE_WRIST_AFTER")

combinedWristEMA <- combinedWristEMA[keep]

head(combinedWristEMA)

countsEMADataFrame <- merge.data.frame(combinedAnkleEMA, combinedWristEMA)

head(countsEMADataFrame)
