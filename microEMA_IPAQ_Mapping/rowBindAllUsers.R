library(dplyr)

weeklyActivity <- data.frame()

weeklyActivity <- rbind(weeklyActivity, categoryCounts)


weeklyActivity$SED_MIN <- weeklyActivity$Sedentary/60
weeklyActivity$MOD_MIN <- weeklyActivity$Moderate/60
weeklyActivity$VIG_MIN <- weeklyActivity$Vigorous/60



write.csv(file = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/weeklyActivities", x = weeklyActivity, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
