library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

predictionFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/Predictions/ankle_uEMA_prediction_samples_on_SPADES_model.csv", 
                           sep = ",", header = TRUE)
