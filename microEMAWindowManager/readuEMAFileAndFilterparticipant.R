#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### get a specific participant from 
uEMA02Responses <- uEMAAllResponses[uEMAAllResponses$USER_ID == "uema02@micropa_com",]
head(uEMA02Responses)
tail(uEMA02Responses)
nrow(uEMA02Responses)

#### Keep only relevant columns
uEMA02Responses <- uEMA02Responses[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
head(uEMA02Responses)

uEMA02Responses$ANSWER_TIME <- as.POSIXct(uEMA02Responses$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMA02Responses$PROMPT_TIME <- as.POSIXct(uEMA02Responses$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
class(uEMA02Responses$PROMPT_TIME)
class(uEMA02Responses$ANSWER_TIME)

toMatch <- c("MISSED", "DISMISSED")
uEMA02AnsweredPrompts <- uEMA02Responses[- grep(paste(toMatch,collapse="|"), 
                                                uEMA02Responses$ACTIVITY_TYPE),]

uEMA02AnsweredPrompts <- subset(uEMA02AnsweredPrompts, ANSWER_TIME < "2018-02-14 23:00:00")

head(uEMA02AnsweredPrompts)
levels(uEMA02AnsweredPrompts$ACTIVITY_TYPE)

uEMA02AnsweredPrompts$ACTIVITY_CODED[uEMA02AnsweredPrompts$ACTIVITY_TYPE == "Sedentary"] <- "1000"
uEMA02AnsweredPrompts$ACTIVITY_CODED[uEMA02AnsweredPrompts$ACTIVITY_TYPE == "Light/Standing"] <- "1500"
uEMA02AnsweredPrompts$ACTIVITY_CODED[uEMA02AnsweredPrompts$ACTIVITY_TYPE == "Moderate/Walking"] <- "4000"
uEMA02AnsweredPrompts$ACTIVITY_CODED[uEMA02AnsweredPrompts$ACTIVITY_TYPE == "Vigorous"] <- "8000"

uEMA02AnsweredPrompts$ANSWER_TIME <- as.POSIXct(uEMA02AnsweredPrompts$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMA02AnsweredPrompts$PROMPT_TIME <- as.POSIXct(uEMA02AnsweredPrompts$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

uEMA02AnsweredPrompts$ACTIVITY_NUMERIC <- as.numeric(as.character(uEMA02AnsweredPrompts$ACTIVITY_CODED))
head(uEMA02AnsweredPrompts)

class(uEMA02AnsweredPrompts$ACTIVITY_NUMERIC)
