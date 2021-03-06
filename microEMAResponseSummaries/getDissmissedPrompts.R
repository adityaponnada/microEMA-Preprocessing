responseFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", sep = ",", header = TRUE)

user_id = "uema23@micropa_com"
endsOn = as.POSIXct("2018-07-27 23:00:00")

responseFile$PROMPT_TIME <- as.POSIXct(responseFile$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")


subjectResponse <- subset(responseFile, responseFile$USER_ID == user_id & responseFile$PROMPT_TIME < endsOn)

#### Get all the dismissed prompts
subjectResponse <- subset(subjectResponse, subjectResponse$ACTIVITY_TYPE == "DISMISSED")

subjectResponse$RESPONSE_TIME <- as.numeric(subjectResponse$RESPONSE_TIME)

mean(subjectResponse$RESPONSE_TIME)/1000

