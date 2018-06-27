library(rmcorr)

readTestFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/testFile.csv", sep = ",", header = TRUE)

readTestFile$Y_10 <- readTestFile$Y*10/60
readTestFile$Y_30 <- readTestFile$Y*30/60
readTestFile$Y_60 <- readTestFile$Y*60/60
readTestFile$Y_150 <- readTestFile$Y*150/60

rmcorr(ID, X, Y_10, readTestFile, CIs = c("analytic","bootstrap"), nreps = 100, bstrap.out = F)
rmcorr(ID, X, Y_30, readTestFile, CIs = c("analytic","bootstrap"), nreps = 100, bstrap.out = F)
rmcorr(ID, X, Y_60, readTestFile, CIs = c("analytic","bootstrap"), nreps = 100, bstrap.out = F)
rmcorr(ID, X, Y_150, readTestFile, CIs = c("analytic","bootstrap"), nreps = 100, bstrap.out = F)
