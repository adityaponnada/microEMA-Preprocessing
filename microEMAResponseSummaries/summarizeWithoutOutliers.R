#### Include libraires

library(psych)
library(MASS)
library(ggplot2)
library(plotly)
library(reshape2)
library(dplyr)

uEMAResponseRate_sansOutliers <- uEMAResponseRate[!(uEMAResponseRate$USER_ID == "uema17" | uEMAResponseRate$USER_ID == "uema18"),]

withOutliers <- describe(uEMAResponseRate)

withoutOutliers <- describe(uEMAResponseRate_sansOutliers)

write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/withOutliers.csv", 
          x = withOutliers, quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")

write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/withoutOutliers.csv", 
          x = withoutOutliers, quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")

withOutliers
withoutOutliers

