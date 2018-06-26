library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

## Read uEMA file
uEMAAll <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                             sep = ",", header = TRUE)

head(uEMAAll)

### Please verify using participant logs

username = "uema01@micropa_com"
week1Ends = as.POSIXct("2018-02-09 23:00:00")
week2Ends = as.POSIXct("2018-02-16 23:00:00")
week3Ends = as.POSIXct("2018-02-23 23:00:00")
week4Ends = as.POSIXct("2018-03-02 23:00:00")

uEMAParticipant <- uEMAAll[uEMAAll$USER_ID == username,]
head(uEMAParticipant)
tail(uEMAParticipant)
nrow(uEMAParticipant)

uEMAParticipant <- uEMAParticipant[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
head(uEMAParticipant)

uEMAParticipant$ANSWER_TIME <- as.POSIXct(uEMAParticipant$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMAParticipant$PROMPT_TIME <- as.POSIXct(uEMAParticipant$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
class(uEMAParticipant$PROMPT_TIME)
class(uEMAParticipant$ANSWER_TIME)


toMatch <- c("MISSED", "DISMISSED")
uEMAParticipantAnswered <- uEMAParticipant[- grep(paste(toMatch,collapse="|"), 
                                                  uEMAParticipant$ACTIVITY_TYPE),]
