

weeklyActivity$SEDENTARY_uEMA_10 <- weeklyActivity$SEDENTARY_uEMA*10/60
weeklyActivity$SEDENTARY_uEMA_30 <- weeklyActivity$SEDENTARY_uEMA*30/60
weeklyActivity$SEDENTARY_uEMA_60 <- weeklyActivity$SEDENTARY_uEMA*60/60
weeklyActivity$SEDENTARY_uEMA_150 <- weeklyActivity$SEDENTARY_uEMA*150/60
weeklyActivity$SEDENTARY_uEMA_300 <- weeklyActivity$SEDENTARY_uEMA*300/60
weeklyActivity$SEDENTARY_uEMA_600 <- weeklyActivity$SEDENTARY_uEMA*600/60

weeklyActivity$LIGHT_uEMA_10 <- weeklyActivity$LIGHT_STANDING_uEMA*10/60
weeklyActivity$LIGHT_uEMA_30 <- weeklyActivity$LIGHT_STANDING_uEMA*30/60
weeklyActivity$LIGHT_uEMA_60 <- weeklyActivity$LIGHT_STANDING_uEMA*60/60
weeklyActivity$LIGHT_uEMA_150 <- weeklyActivity$LIGHT_STANDING_uEMA*150/60
weeklyActivity$LIGHT_uEMA_300 <- weeklyActivity$LIGHT_STANDING_uEMA*300/60
weeklyActivity$LIGHT_uEMA_600 <- weeklyActivity$LIGHT_STANDING_uEMA*600/60

weeklyActivity$MODERATE_uEMA_10 <- weeklyActivity$MODERATE_WALKING_uEMA*10/60
weeklyActivity$MODERATE_uEMA_30 <- weeklyActivity$MODERATE_WALKING_uEMA*30/60
weeklyActivity$MODERATE_uEMA_60 <- weeklyActivity$MODERATE_WALKING_uEMA*60/60
weeklyActivity$MODERATE_uEMA_150 <- weeklyActivity$MODERATE_WALKING_uEMA*150/60
weeklyActivity$MODERATE_uEMA_300 <- weeklyActivity$MODERATE_WALKING_uEMA*300/60
weeklyActivity$MODERATE_uEMA_600 <- weeklyActivity$MODERATE_WALKING_uEMA*600/60

weeklyActivity$VIGOROUS_uEMA_10 <- weeklyActivity$VIGOROUS_uEMA*10/60
weeklyActivity$VIGOROUS_uEMA_30 <- weeklyActivity$VIGOROUS_uEMA*30/60
weeklyActivity$VIGOROUS_uEMA_60 <- weeklyActivity$VIGOROUS_uEMA*60/60
weeklyActivity$VIGOROUS_uEMA_150 <- weeklyActivity$VIGOROUS_uEMA*150/60
weeklyActivity$VIGOROUS_uEMA_300 <- weeklyActivity$VIGOROUS_uEMA*300/60
weeklyActivity$VIGOROUS_uEMA_600 <- weeklyActivity$VIGOROUS_uEMA*600/60

head(weeklyActivity)