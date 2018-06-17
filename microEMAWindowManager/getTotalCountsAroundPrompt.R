##### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

### Add before after for wrist and ankle
countsEMADataFrame$TOTAL_ANKLE_COUNTS <- countsEMADataFrame$COUNTS_SUM_ANKLE_BEFORE + countsEMADataFrame$COUNTS_SUM_ANKLE_AFTER
countsEMADataFrame$TOTAL_WRIST_COUNTS <- countsEMADataFrame$COUNTS_SUM_WRIST_BEFORE + countsEMADataFrame$COUNTS_SUM_WRIST_AFTER

head(countsEMADataFrame)

write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uema16/combinedData_60sec.csv", x = countsEMADataFrame, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
