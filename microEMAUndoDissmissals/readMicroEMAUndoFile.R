library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAUndoFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAUndoResponses.csv", 
                     sep = ",", header = TRUE)

subsetFile <- data.frame()

### Remove outliers 

uEMAUndoFile <- uEMAUndoFile[!(uEMAUndoFile$USER_ID == "uema17@micropa_com"),]
uEMAUndoFile <- uEMAUndoFile[!(uEMAUndoFile$USER_ID == "uema18@micropa_com"),]
uEMAUndoFile <- uEMAUndoFile[!(uEMAUndoFile$USER_ID == "uema20@micropa_com"),]

summary(uEMAUndoFile$PROMPT)


#### Get the first week undo responses

uEMAUndoFile$PROMPT_TIME <- as.POSIXct(uEMAUndoFile$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

username = "uema19@micropa_com"
week1Ends = as.POSIXct("2018-04-24 23:00:00")

subsetFile_user <- subset(uEMAUndoFile, uEMAUndoFile$USER_ID == username & uEMAUndoFile$PROMPT_TIME < week1Ends)



subsetFile <- rbind(subsetFile, subsetFile_user)

summary(subsetFile$PROMPT)
