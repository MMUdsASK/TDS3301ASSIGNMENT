#-----------------------------------
# Dataset loading and processing
#-----------------------------------

# exploring occupancy dataset
library(ggplot2)

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
library(rpart)
library(rpart.plot)

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
# ANN
#----------------------------------------------------
# get maximum and minimum of column values
maximums <- apply(datatraining[,2:6],2, max)
minimums <- apply(datatraining[,2:6],2, min)

# begin scaling

# Use scale() and convert the resulting matrix to a data frame
datatrainingANN <- as.data.frame(scale(datatraining[,2:6],center = minimums, scale = maximums - minimums))

# add the class variable to the ANN training
datatrainingANN <- cbind(datatraining$Occupancy, datatrainingANN)







