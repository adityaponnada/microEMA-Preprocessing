#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

## Read uEMA file
uEMAAllResponses <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                                                sep = ",", header = TRUE)

nrow(uEMAAllResponses)
head(uEMAAllResponses)

#### uEMA participant file data frame format should be "uEMAnResponses" and "uEMAnnAnsweredPrompts"

username = "uema19@micropa_com"
endTime = as.POSIXct("2018-04-24 23:00:00") #### Always check the sheet for the
class(endTime)

#### get a specific participant from 
uEMAParticipantResponses <- uEMAAllResponses[uEMAAllResponses$USER_ID == username,]
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

### 10s values
sedValue = 446.16
lightValue = 505.75
modValues = 2390
vigValues = 2602


### 30s values
sedValue = 1338.5
lightValue = 1617.3
modValues = 7171
vigValues = 7805

### 60s values
sedValue = 1677.0
lightValue = 3035.0
modValues = 14341
vigValues = 15611

##### Start assignment

uEMAParticipantAnsweredPrompts$ACTIVITY_CODED[uEMAParticipantAnsweredPrompts$ACTIVITY_TYPE == "Sedentary"] <- "1677.0"
uEMAParticipantAnsweredPrompts$ACTIVITY_CODED[uEMAParticipantAnsweredPrompts$ACTIVITY_TYPE == "Light/Standing"] <- "3035.0"
uEMAParticipantAnsweredPrompts$ACTIVITY_CODED[uEMAParticipantAnsweredPrompts$ACTIVITY_TYPE == "Moderate/Walking"] <- "14341"
uEMAParticipantAnsweredPrompts$ACTIVITY_CODED[uEMAParticipantAnsweredPrompts$ACTIVITY_TYPE == "Vigorous"] <- "15611"

uEMAParticipantAnsweredPrompts$ANSWER_TIME <- as.POSIXct(uEMAParticipantAnsweredPrompts$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMAParticipantAnsweredPrompts$PROMPT_TIME <- as.POSIXct(uEMAParticipantAnsweredPrompts$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

class(uEMAParticipantAnsweredPrompts$ANSWER_TIME)

uEMAParticipantAnsweredPrompts$ACTIVITY_NUMERIC <- as.numeric(as.character(uEMAParticipantAnsweredPrompts$ACTIVITY_CODED))
head(uEMAParticipantAnsweredPrompts)

uEMAParticipantAnsweredPrompts$RESPONSE_TIME <- as.numeric(uEMAParticipantAnsweredPrompts$RESPONSE_TIME)

class(uEMAParticipantAnsweredPrompts$ACTIVITY_NUMERIC)
class(uEMAParticipantAnsweredPrompts$RESPONSE_TIME)
