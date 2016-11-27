setwd("~/Desktop/Project4")
dt_train <- read.csv("train.csv", header = T, stringsAsFactors = T)
dt_test <- read.csv("test.csv", header = T, stringsAsFactors = T)
temp_train <- dt_train[,-1]
temp_train$loss <- log(temp_train$loss + 200)
temp_test <- dt_test[,-1]
temp_test$loss <- NA                       

temp_test2 <- temp_test[c(1:round(0.1*nrow(temp_test))),]

temp <- rbind(temp_test2, temp_train)
pred <- VIM::kNN(temp, useImputedDist = FALSE)

results <- temp$loss[c(1:nrow(temp_test2))]
saveRDS(results, "results.RDS")