library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                     sep = ",", header = TRUE)

dismissFile <- data.frame()


uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema17@micropa_com"),]
uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema18@micropa_com"),]
uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema20@micropa_com"),]


uEMAFileDissmised <- uEMAFile[uEMAFile$ACTIVITY_TYPE == "DISMISSED", ]

uEMAFileDissmised$RESPONSE_TIME <- as.numeric(uEMAFileDissmised$RESPONSE_TIME)

summary(uEMAFileDissmised$RESPONSE_TIME)


### Get week 1 data on dissmissal
username = "uema19@micropa_com"
week1Ends = as.POSIXct("2018-04-24 23:00:00")

dismissFile_user <- subset(uEMAFileDissmised, uEMAFileDissmised$USER_ID == username & uEMAFileDissmised$PROMPT_TIME < week1Ends)

dismissFile <- rbind(dismissFile, dismissFile_user)

