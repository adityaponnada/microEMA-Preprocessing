#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### get a specific participant from 
uEMA04Responses <- uEMAAllResponses[uEMAAllResponses$USER_ID == "uema04@micropa_com",]
head(uEMA04Responses)
tail(uEMA04Responses)
nrow(uEMA04Responses)

#### Keep only relevant columns
uEMA04Responses <- uEMA04Responses[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
head(uEMA04Responses)

uEMA04Responses$ANSWER_TIME <- as.POSIXct(uEMA04Responses$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMA04Responses$PROMPT_TIME <- as.POSIXct(uEMA04Responses$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
class(uEMA04Responses$PROMPT_TIME)
class(uEMA04Responses$ANSWER_TIME)

toMatch <- c("MISSED", "DISMISSED")
uEMA04AnsweredPrompts <- uEMA04Responses[- grep(paste(toMatch,collapse="|"), 
                                                uEMA04Responses$ACTIVITY_TYPE),]

uEMA04AnsweredPrompts <- subset(uEMA04AnsweredPrompts, ANSWER_TIME < "2018-02-19 23:00:00")

head(uEMA04AnsweredPrompts)
levels(uEMA04AnsweredPrompts$ACTIVITY_TYPE)

uEMA04AnsweredPrompts$ACTIVITY_CODED[uEMA04AnsweredPrompts$ACTIVITY_TYPE == "Sedentary"] <- "1000"
uEMA04AnsweredPrompts$ACTIVITY_CODED[uEMA04AnsweredPrompts$ACTIVITY_TYPE == "Light/Standing"] <- "1500"
uEMA04AnsweredPrompts$ACTIVITY_CODED[uEMA04AnsweredPrompts$ACTIVITY_TYPE == "Moderate/Walking"] <- "4000"
uEMA04AnsweredPrompts$ACTIVITY_CODED[uEMA04AnsweredPrompts$ACTIVITY_TYPE == "Vigorous"] <- "8000"

uEMA04AnsweredPrompts$ANSWER_TIME <- as.POSIXct(uEMA04AnsweredPrompts$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMA04AnsweredPrompts$PROMPT_TIME <- as.POSIXct(uEMA04AnsweredPrompts$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

uEMA04AnsweredPrompts$ACTIVITY_NUMERIC <- as.numeric(as.character(uEMA04AnsweredPrompts$ACTIVITY_CODED))
head(uEMA04AnsweredPrompts)

class(uEMA04AnsweredPrompts$ACTIVITY_NUMERIC)
