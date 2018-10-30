
uEMAFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uema23/combinedData_600sec.csv", header = TRUE, sep = ",")

uEMAFile$PROMPT_TIME <- as.POSIXct(uEMAFile$PROMPT_TIME, format = "%Y-%m-%d %H:%M:%OS")
uEMAFile$ANSWER_TIME <- as.POSIXct(uEMAFile$ANSWER_TIME, format = "%Y-%m-%d %H:%M:%OS")

class(uEMAFile$PROMPT_TIME)
class(uEMAFile$ANSWER_TIME)

for (i in 1:nrow(nonWearFile)){
  
  pickedNonWear <- nonWearFile[i,]
  uEMAFile <- subset(uEMAFile, !(uEMAFile$PROMPT_TIME >= pickedNonWear$Date.Time.Start & uEMAFile$PROMPT_TIME <= pickedNonWear$Date.Time.Stop))
  
}


write.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uema23/combinedData_600sec.csv", x = uEMAFile, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
