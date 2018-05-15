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
