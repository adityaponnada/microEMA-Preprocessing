



week1Subset <- subset(uEMAParticipantAnswered, ANSWER_TIME <= week1Ends)
week2Subset <- subset(uEMAParticipantAnswered, ANSWER_TIME > week1Ends & ANSWER_TIME <= week2Ends)
week3Subset <- subset(uEMAParticipantAnswered, ANSWER_TIME > week2Ends & ANSWER_TIME <= week3Ends)
week4Subset <- subset(uEMAParticipantAnswered, ANSWER_TIME > week3Ends & ANSWER_TIME <= week4Ends)

keepColumns <- c("USER_ID","ACTIVITY_TYPE")

week1Subset <- week1Subset[, keepColumns]
week2Subset <- week2Subset[, keepColumns]
week3Subset <- week3Subset[, keepColumns]
week4Subset <- week4Subset[, keepColumns]

levs <- c("Sedentary", "Light/Standing", "Moderate/Walking", "Vigorous")

uEMAResponseCounts1 <- sapply(week1Subset, function(x) table(factor(x, levels = levs, ordered = TRUE)))
uEMAResponseCounts1 <- as.data.frame(uEMAResponseCounts1)
uEMAResponseCounts1 <- as.data.frame(t(uEMAResponseCounts1))
uEMAResponseCounts1 <- uEMAResponseCounts1[-1,]
uEMAResponseCounts1$USER_ID <- username

uEMAResponseCounts2 <- sapply(week2Subset, function(x) table(factor(x, levels = levs, ordered = TRUE)))
uEMAResponseCounts2 <- as.data.frame(uEMAResponseCounts2)
uEMAResponseCounts2 <- as.data.frame(t(uEMAResponseCounts2))
uEMAResponseCounts2 <- uEMAResponseCounts2[-1,]
uEMAResponseCounts2$USER_ID <- username

uEMAResponseCounts3 <- sapply(week3Subset, function(x) table(factor(x, levels = levs, ordered = TRUE)))
uEMAResponseCounts3 <- as.data.frame(uEMAResponseCounts3)
uEMAResponseCounts3 <- as.data.frame(t(uEMAResponseCounts3))
uEMAResponseCounts3 <- uEMAResponseCounts3[-1,]
uEMAResponseCounts3$USER_ID <- username

uEMAResponseCounts4 <- sapply(week4Subset, function(x) table(factor(x, levels = levs, ordered = TRUE)))
uEMAResponseCounts4 <- as.data.frame(uEMAResponseCounts4)
uEMAResponseCounts4 <- as.data.frame(t(uEMAResponseCounts4))
uEMAResponseCounts4 <- uEMAResponseCounts4[-1,]
uEMAResponseCounts4$USER_ID <- username

weeklyParticipantActivity <- rbind(uEMAResponseCounts1, uEMAResponseCounts2, uEMAResponseCounts3, uEMAResponseCounts4)

write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uema16/weeklyData.csv", x = weeklyParticipantActivity, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
