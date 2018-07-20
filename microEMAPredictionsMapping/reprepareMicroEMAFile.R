library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAParticipantAnsweredPrompts$PREDICTED_ACTIVITY_TYPE[uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY == 1] <- "Sedentary"
uEMAParticipantAnsweredPrompts$PREDICTED_ACTIVITY_TYPE[uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY == 2] <- "Light/Standing"
uEMAParticipantAnsweredPrompts$PREDICTED_ACTIVITY_TYPE[uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY == 3] <- "Moderate/Walking"
uEMAParticipantAnsweredPrompts$PREDICTED_ACTIVITY_TYPE[uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY == 4] <- "Vigorous"


testFrame <- uEMAParticipantAnsweredPrompts

testFrame <- testFrame[!is.na(testFrame$PREDICTED_ACTIVITY_TYPE),]

testFrame$PREDICTED_ACTIVITY_TYPE <- as.factor(testFrame$PREDICTED_ACTIVITY_TYPE)


write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uema06/mappedPredictions_30.csv", x = testFrame, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
