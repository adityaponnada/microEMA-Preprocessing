library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                     sep = ",", header = TRUE)

nrow(uEMAFile)
head(uEMAFile)

username = "uema23@micropa_com"
endTime = as.POSIXct("2018-07-27 23:00:00") #### Always check the sheet for the
class(endTime)

#### get a specific participant from 
uEMAParticipantResponses <- uEMAFile[uEMAFile$USER_ID == username,]
head(uEMAParticipantResponses)
tail(uEMAParticipantResponses)
nrow(uEMAParticipantResponses)


#### Keep only relevant columns
uEMAParticipantResponses <- uEMAParticipantResponses[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
head(uEMAParticipantResponses)

uEMAParticipantResponses$ANSWER_TIME <- as.POSIXct(uEMAParticipantResponses$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMAParticipantResponses$PROMPT_TIME <- as.POSIXct(uEMAParticipantResponses$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
class(uEMAParticipantResponses$PROMPT_TIME)
class(uEMAParticipantResponses$ANSWER_TIME)

toMatch <- c("MISSED", "DISMISSED")
uEMAParticipantAnsweredPrompts <- uEMAParticipantResponses[- grep(paste(toMatch,collapse="|"), 
                                                                  uEMAParticipantResponses$ACTIVITY_TYPE),]

uEMAParticipantAnsweredPrompts <- subset(uEMAParticipantAnsweredPrompts, ANSWER_TIME < endTime)

head(uEMAParticipantAnsweredPrompts)
levels(uEMAParticipantAnsweredPrompts$ACTIVITY_TYPE)

class(uEMAParticipantAnsweredPrompts$PROMPT_TIME)
class(uEMAParticipantAnsweredPrompts$ANSWER_TIME)

uEMAParticipantAnsweredPrompts$RESPONSE_TIME <- as.numeric(uEMAParticipantAnsweredPrompts$RESPONSE_TIME)

class(uEMAParticipantAnsweredPrompts$RESPONSE_TIME)
