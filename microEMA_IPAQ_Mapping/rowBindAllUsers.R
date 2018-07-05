library(dplyr)

weeklyActivity <- data.frame()

weeklyActivity <- rbind(weeklyActivity, categoryCounts)




##### Only after row binding all the datasets

weeklyActivity$SED_MIN <- weeklyActivity$Sedentary/60
weeklyActivity$MOD_MIN <- weeklyActivity$Moderate/60
weeklyActivity$VIG_MIN <- weeklyActivity$Vigorous/60

### Reverse the rows
testWeekly <- weeklyActivity[seq(dim(weeklyActivity)[1],1),]

write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/weeklyActivities", x = weeklyActivity, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
