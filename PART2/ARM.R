# TDS 3301 DATA MINING ASSIGNMENT 2 : ARM.R
# requires the binaryVector object by executing binaryVector.R!

library(sqldf)
library(pmml)
library("arules")

timing <- proc.time()
rulesB <- apriori(binaryVector,parameter=list(minlen=2,supp=0.005,conf=0.8))
timing <- proc.time() - timing
print(timing)
quality(rulesB)<-round(quality(rulesB),digits=3)

#Run sorted rulesB in support
rulesB.sorted<-sort(rulesB,by="support")

# save the rules to xml for Shiny app use
write.PMML(rulesB.sorted, file = 'rules.xml')