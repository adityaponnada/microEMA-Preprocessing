library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

predictionFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema06_activity/ANKLE/Predictions/ankle_uEMA_prediction_samples_on_SPADES_model.csv", 
                           sep = ",", header = TRUE)


colnames(predictionFile)[1] <- "PARTICIPANT_ID"

predictionFile$PARTICIPANT_ID <- paste0("SPADES_", predictionFile$PARTICIPANT_ID)
