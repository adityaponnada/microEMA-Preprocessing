library(psych)
library(dplyr)
library(plyr)
library(MASS)


responseFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", sep = ",", header = TRUE)

head(responseFile)
tail(responseFile)

userName = "uema23@micropa_com"

subsetFile <- subset(responseFile, responseFile$USER_ID == "uema23@micropa_com")

levels(subsetFile$ACTIVITY_TYPE)

summary(subsetFile$ACTIVITY_TYPE)

subsetFile$RESPONSE_TIME <- as.numeric(subsetFile$RESPONSE_TIME)

describe(subsetFile$RESPONSE_TIME)
