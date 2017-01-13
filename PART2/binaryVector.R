# TDS 3301 DATA MINING ASSIGNMENT 2 : binaryVector.R
# building binary vectors
# requires construction.R to be executed to obtain the tables
# create database connection
library(sqldf)


db <- dbConnect(SQLite(), dbname="bakery1000")
options(warn=-1)


# read goods table to a dataframe
goods <- dbGetQuery(db,'select * from goods')
# read item table to a dataframe
items <- dbGetQuery(db,'select * from items')
# read receipts table to a dataframe
receipts <- dbGetQuery(db,'select * from receipts')

# get the list of goods in database
goodsList <- paste(goods$Flavor, goods$Food)

# create empty matrix as binary vector
binaryVector <- matrix(0, ncol = nrow(goods), nrow = max(items$Receipt))

# get vector of recepits id in item
idVector <- as.vector(items$Receipt)

# get vector of goods id in item
# must plus one because database ID is zero-indexed
# while R matrices are one-indexed
goodsVector <- as.vector(items$Item + 1)

# setup binary vector columns
colnames(binaryVector) <- goodsList

# combine id and goods vector for indexing
idx <- cbind(idVector,goodsVector)

# setup vector
binaryVector[idx] <- 1

binaryDF <- data.frame(binaryVector)

# get goods inside a receipt
receiptNumber <- 1 # select from 1 to 1000


goodsList[binaryVector[receiptNumber,] == 1]



