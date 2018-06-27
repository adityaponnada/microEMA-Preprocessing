library(rmcorr)

rmcorr(USER_ID, SEDENTARY_IPAQ, SEDENTARY_uEMA_600, weeklyActivity, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 100, bstrap.out = F)

rmcorr(USER_ID, LIGHT_IPAQ, LIGHT_uEMA_600, weeklyActivity, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 100, bstrap.out = F)

rmcorr(USER_ID, MODERATE_IPAQ, MODERATE_uEMA_600, weeklyActivity, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 100, bstrap.out = F)

rmcorr(USER_ID, VIGOROUS_IPAQ, VIGOROUS_uEMA_600, weeklyActivity, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 100, bstrap.out = F)

