library(limma)
library(readr)


setwd("C:/Users/tolgahaninan/Documents/data")
data <- read.csv("covid19-GSE160435" , header = T , sep = ",")
View(data)


normalizedData <- normalizeBetweenArrays(data[2:3000])
dataFrame <- as.data.frame(normalizedData)
normalizedMatrix <-as.matrix(normalizedData)
boxplotNotNormalized<-boxplot(data[2:26])
boxplotNormalized<-boxplot(dataFrame[1:25])


TtestToNormalizedData <- t.test(normalizedData)
TtestToNormalizedData2 <- t.test(dataFrame)
TtestToNormalizedData3 <- t.test(normalizedMatrix)


pValue <- 1.132e-06
PValuesOfFrame<-p.adjust(normalizedMatrix,method="fdr")
View(PValuesOfFrame)
adjustedAsMatrix<-as.matrix(PValuesOfFrame)
sortedAdjusted<-sort(adjustedAsMatrix)
matrixSortedAdjusted<-as.matrix(sortedAdjusted)
plot(sortedAdjusted[1:100])


clustering <-hclust(dist(matrixSortedAdjusted[1:100]))
plot(clustering)
heatmap(as.matrix(dataFrame[0:100]))


dataToFactor <- c("covid","covid","mock","mock","covid","mock","covid","covid","mock","mock")
factorData <- as.factor (dataToFactor)
numericFactor <- as.numeric(factorData)


fit <- lmFit(t(data[2:3000]),numericFactor)
eBayesFit <- eBayes(fit)
TopGenes <-topTable(eBayesFit,number = 100,adjust.method="fdr") 

plot(TopGenes)
clustering2 <-hclust(dist(TopGenes))
plot(clustering2)

topFrame <- as.matrix(TopGenes)
heatmap(topFrame)