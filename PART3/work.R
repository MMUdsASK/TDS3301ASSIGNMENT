#-----------------------------------
# Dataset loading and processing
#-----------------------------------
# load library
library(ggplot2) # plotting
library(caret) # scaling
library(rpart) # decision tree
library(rpart.plot) # plotting decision tree
library(ROCR) # ROC curve
library(arules) # discretize
library(e1071) # bayes
library('neuralnet') # ANN

# dates are not factors
datatraining <- read.table("datatraining.txt",header=TRUE,sep=",",stringsAsFactors = FALSE)


# convert dates to POSIXct
datatraining$date <- as.POSIXct(strptime(datatraining$date, "%Y-%m-%d %H:%M:%S"))

#--------------------------------
# dataset description
#--------------------------------

# get dimensions
dim(datatraining)

# get datatypes of dataset
str(datatraining)

# class distribution
ggplot(data=datatraining, aes(x=as.factor(Occupancy))) +
  geom_bar(fill = 'blue') +
  geom_text(stat = 'count', aes(label=..count..),position=position_dodge(width=0.9), vjust=-0.25) +
  scale_x_discrete(labels=c('Not Occupied','Occupied')) +
  xlab("Occupancy") +
  ylab("Count")

# boxplot for each column
ggplot(datatraining, aes(x=as.factor(Occupancy),y=date)) +
  geom_boxplot() +
  scale_x_discrete(labels=c('Not Occupied','Occupied')) +
  xlab("Occupancy") +
  ylab("Date")

ggplot(datatraining, aes(x='',y=Temperature)) +
  geom_boxplot() +
  xlab("Temperature") +
  ylab("Degree Celcius")

ggplot(datatraining, aes(x='',y=Humidity)) +
  geom_boxplot() +
  xlab("Humidity") +
  ylab("%")

ggplot(datatraining, aes(x='',y=Light)) +
  geom_boxplot() +
  xlab("Light") +
  ylab("Lux")

ggplot(datatraining, aes(x='',y=CO2)) +
  geom_boxplot() +
  xlab("Carbon Dioxide Concentration") +
  ylab("Parts-per-million")

ggplot(datatraining, aes(x='',y=HumidityRatio)) +
  geom_boxplot() +
  xlab("Humidity/Temperature Ratio") +
  ylab("kgwater-vapor/kg-air ")

# pre-process task
# TREE : DO NOTHING
# ANN : NORMALIZE VALUES

#----------------------------------------------------
# decision tree
#----------------------------------------------------


# factorize the class variable
datatraining$Occupancy = as.factor(datatraining$Occupancy)


# create decision tree
dTree <- rpart(Occupancy ~ . - date, datatraining,control = rpart.control(cp = 0.001))
prp(dTree, faclen = 0, cex = 0.8, extra = 1)

# pruning post-tree
bestcp <- dTree$cptable[which.min(dTree$cptable[,"xerror"]),"CP"]

# Step3: Prune the tree using the best cp.
tree.pruned <- prune(dTree, cp = bestcp)

prp(dTree, faclen = 0, cex = 0.8, extra = 1)

#----------------------------------------------------
# Naive Bayes
#----------------------------------------------------

datatrainingNB = datatraining

# discretize the continuous values
datatrainingNB$Temperature<- discretize(datatrainingNB$Temperature, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatrainingNB$Humidity <- discretize(datatrainingNB$Humidity, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatrainingNB$HumidityRatio <- discretize(datatrainingNB$HumidityRatio, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatrainingNB$Light <- discretize(datatrainingNB$Light, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatrainingNB$CO2 <- discretize(datatrainingNB$CO2, method = "interval",4,labels=c("Low","Medium","High","Very High"))


bayesPred <- naiveBayes(Occupancy~ . -date, datatrainingNB)

#----------------------------------------------------
# ANN
#----------------------------------------------------
# get maximum and minimum of column values
maximums <- apply(datatraining[,2:6],2, max)
minimums <- apply(datatraining[,2:6],2, min)

# begin scaling

# Use scale() and convert the resulting matrix to a data frame
datatrainingANN <- as.data.frame(scale(datatraining[,2:6],center = minimums, scale = maximums - minimums))

# add the class variable to the ANN training
datatrainingANN <- cbind(Occupancy=as.numeric(datatraining$Occupancy)-1, datatrainingANN)


# getting the formula
feats <- names(datatrainingANN)
# Concatenate strings
f <- paste(feats[2:6],collapse=' + ')
f <- paste(feats[1], ' ~ ',f)

# Convert to formula
f <- as.formula(f)



nn <- neuralnet(f,datatrainingANN,hidden=c(3,2,1), linear.output = FALSE)




#----------------------------------------------------
# TEST DATA PREDICTION (TREE)
#----------------------------------------------------

# load test data
datatestTREE <- read.table("datatest2.txt",header=TRUE,sep=",",stringsAsFactors = FALSE)


# convert dates to POSIXct
datatestTREE$date <- as.POSIXct(strptime(datatestTREE$date, "%Y-%m-%d %H:%M:%S"))

# do prediction
predT <- predict(dTree, newdata = datatestTREE, type = 'class')

# get confusion matrix
confusionMatrix(predT, datatestTREE$Occupancy)

# get ROC curve
# need to turn factors to binary values
roc_predDT <- ROCR::prediction(as.numeric(predT), as.numeric(datatestTREE$Occupancy))
plot(performance(roc_predDT, measure="tpr", x.measure="fpr"), colorize=TRUE)

# precision recall curve
plot(performance(roc_predDT, measure="sens", x.measure="spec"), colorize=TRUE)

#----------------------------------------------------
# TEST DATA PREDICTION (NAIVE BAYES)
#----------------------------------------------------

# load test data
datatestNB <- read.table("datatest2.txt",header=TRUE,sep=",",stringsAsFactors = FALSE)

# factorize the class variable
datatestNB$Occupancy = as.factor(datatestNB$Occupancy)

# discretize the continuous values
datatestNB$Temperature<- discretize(datatestNB$Temperature, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatestNB$Humidity <- discretize(datatestNB$Humidity, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatestNB$HumidityRatio <- discretize(datatestNB$HumidityRatio, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatestNB$Light <- discretize(datatestNB$Light, method = "interval",4,labels=c("Low","Medium","High","Very High"))
datatestNB$CO2 <- discretize(datatestNB$CO2, method = "interval",4,labels=c("Low","Medium","High","Very High"))

# convert dates to POSIXct
datatestNB$date <- as.POSIXct(strptime(datatestNB$date, "%Y-%m-%d %H:%M:%S"))

# do prediction
predB <- predict(bayesPred, newdata = datatestNB[,2:6])

# get confusion matrix
confusionMatrix(predB, datatestNB$Occupancy)

# get ROC curve
# need to turn factors to binary values
roc_predNB <- ROCR::prediction(as.numeric(predB), as.numeric(datatestNB$Occupancy))
plot(performance(roc_predNB, measure="tpr", x.measure="fpr"), colorize=TRUE)

# precision recall curve
plot(performance(roc_predNB, measure="sens", x.measure="spec"), colorize=TRUE)


#----------------------------------------------------
# TEST DATA PREDICTION (ANN)
#----------------------------------------------------

# load test data
datatestANN <- read.table("datatest2.txt",header=TRUE,sep=",",stringsAsFactors = FALSE)

# numerize the class variable
datatestANN$Occupancy = as.numeric(datatestANN$Occupancy)

# get maximum and minimum of column values
maximums <- apply(datatestANN[,2:6],2, max)
minimums <- apply(datatestANN[,2:6],2, min)

# begin scaling
# Use scale() and convert the resulting matrix to a data frame
scaled.dataANN <- as.data.frame(scale(datatestANN[,2:6],center = minimums, scale = maximums - minimums))

# add the class variable to the ANN training
datatestANN <- cbind(Occupancy=datatestANN$Occupancy, scaled.dataANN )

# prediction
predN <- compute(nn,datatestANN[,2:6])

# round off results
predN <- sapply(predN$net.result,round,digits=0)



# get confusion matrix
confusionMatrix(predN, datatestANN$Occupancy)

# get ROC curve
# need to turn factors to binary values
roc_predANN <- ROCR::prediction(predN, as.numeric(datatestANN$Occupancy))
plot(performance(roc_predANN, measure="tpr", x.measure="fpr"), colorize=TRUE)

# precision recall curve
plot(performance(roc_predANN, measure="sens", x.measure="spec"), colorize=TRUE)

# COMBINING THE ROC CURVES FOR MULTIPLE CLASSIFIER
perf <- performance( roc_predDT, "tpr", "fpr" )
perf2 <- performance(roc_predNB, "tpr", "fpr")
perf3 <- performance(roc_predANN, "tpr", "fpr")
plot( perf, col = 'red')
plot(perf2, add = TRUE, col = 'blue')
plot(perf3, add = TRUE, col = 'green')
legend(0.6,0.6, legend=c("Decision Tree", "Naive Bayes", "ANN"),
       col=c("red", "blue", "green"), lty=1, cex=0.8)

# For sens/spec curve
perf4 <- performance( roc_predDT, "sens", "spec" )
perf5 <- performance(roc_predNB, "sens", "spec")
perf6 <- performance(roc_predANN, "sens", "spec")
plot( perf4, col = 'red')
plot(perf5, add = TRUE, col = 'blue')
plot(perf6, add = TRUE, col = 'green')
legend(0.6,0.6, legend=c("Decision Tree", "Naive Bayes", "ANN"),
       col=c("red", "blue", "green"), lty=1, cex=0.8)

save(perf,perf2,perf3,perf4,perf5,perf6,file = 'perf.RO')
load('perf.RO')
