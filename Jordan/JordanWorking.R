install.packages("neuralnet")
train.cat <- train[,sapply(train,is.factor)]
train.num <- train[,sapply(train,is.numeric)]
train.num.min <- apply(train.num, 2 , min)
train.num.max <- apply(train.num, 2 , max)
scaled <- as.data.frame(scale(train.num, center = train.num.min, scale = train.num.max - train.num.min))

n <- names(scaled)
f <- as.formula(paste("loss ~", paste(n[!n %in% "loss"], collapse = " + ")))
nn <- neuralnet(f,data=scaled,hidden=c(5,3),linear.output=T)

library(randomForest)
library(mlbench)
library(caret)

# Load Dataset
test <- read.csv('allstate/test.csv')

x <- train[,1:131]
y <- train[,132]

control <- trainControl(method="repeatedcv", number=5, repeats=2)
metric <- "Accuracy"
set.seed(0)
mtry <- 5
tunegrid <- expand.grid(.mtry=mtry)
rf_default <- train(loss ~., data=train, method="rf", tuneGrid=tunegrid, trControl=control)
summary(rf_default)

