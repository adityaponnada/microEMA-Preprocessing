#### Include library

library(psych)
library(MASS)
library(ggplot2)
library(plotly)


#### Read file\

labelPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/AllLabCountsCombined.csv"


AllLabCounts <- read.csv(labelPath, sep = ",", header = TRUE)

head(AllLabCounts)

lapply(AllLabCounts, class)


AllLabCounts$DURATION <- as.numeric(AllLabCounts$DURATION)


#### Remove zero seconds label
AllLabCounts <- AllLabCounts[AllLabCounts$DURATION != 0,]

head(AllLabCounts)


### get the per second counts
AllLabCounts$ANKLE_COUNTS_PER_SECOND <- AllLabCounts$ANKLE_COUNTS_ADDED/AllLabCounts$DURATION
AllLabCounts$WRIST_COUNTS_PER_SECOND <- AllLabCounts$WRIST_COUNTS_ADDED/AllLabCounts$DURATION

head(AllLabCounts)


### Get per second counts for 10, 30, and 60 seconds
AllLabCounts$ANKLE_300 <- AllLabCounts$ANKLE_COUNTS_PER_SECOND*300
AllLabCounts$ANKLE_150 <- AllLabCounts$ANKLE_COUNTS_PER_SECOND*150
AllLabCounts$ANKLE_60 <- AllLabCounts$ANKLE_COUNTS_PER_SECOND*60
AllLabCounts$ANKLE_30 <- AllLabCounts$ANKLE_COUNTS_PER_SECOND*30
AllLabCounts$ANKLE_10 <- AllLabCounts$ANKLE_COUNTS_PER_SECOND*10

# AllLabCounts$WRIST_60 <- AllLabCounts$WRIST_COUNTS_PER_SECOND*60
# AllLabCounts$WRIST_30 <- AllLabCounts$WRIST_COUNTS_PER_SECOND*30
# AllLabCounts$WRIST_10 <- AllLabCounts$WRIST_COUNTS_PER_SECOND*10

AllLabCounts <- select(AllLabCounts, -TOTAL_ROWS_TEMP_ANKLE)
AllLabCounts <- select(AllLabCounts, -TOTAL_ROWS_TEMP_WRIST)

head(AllLabCounts)
