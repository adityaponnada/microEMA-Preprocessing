library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                     sep = ",", header = TRUE)

uEMAWeek <- data.frame()

uEMAFile$PROMPT_TIME <- as.POSIXct(uEMAFile$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema17@micropa_com"),]
uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema18@micropa_com"),]
uEMAFile <- uEMAFile[!(uEMAFile$USER_ID == "uema20@micropa_com"),]

summary(uEMAFile$ACTIVITY_TYPE)


### Get week 1 data on dissmissal
username = "uema19@micropa_com"
week1Ends = as.POSIXct("2018-04-24 23:00:00")

uEMAWeek_user <- subset(uEMAFile, uEMAFile$USER_ID == username & uEMAFile$PROMPT_TIME < week1Ends)

uEMAWeek <- rbind(uEMAWeek, uEMAWeek_user)

summary(uEMAWeek$ACTIVITY_TYPE)
