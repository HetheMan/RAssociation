library(arules)
library(arulesViz)
dat = read.csv("student-por.csv")

#SUBSETOFVARIABLES

mine = dat[,c("Dalc","Walc","failures","health","Pstatus")]
#Mine$romantic <- mine$romantic == "yes"
mine$Walc <- factor(mine$Walc, labels = c("very low", "low","normal","high","very high"))
mine$Dalc <- factor(mine$Dalc, labels = c("very low", "low","normal","high","very high"))
mine$male <- dat$sex == "M"
mine$female <-dat$sex =="F"
mine$notRomantic <- dat$romantic == "no"
mine$romantic <-dat$romantic == "yes"
mine$failures <- factor(mine$failures, labels = c("cero", "uno","dos","tres"))
mine$health <- factor(mine$health, labels = c("very bad","bad","normal","good","very good"))
mine$Pstatus <- factor(mine$Pstatus, labels = c("living together","apart"))

tbl <- table(factor(dat$sex, labels = c("Mujer","Hombre")))
ylim <- c(0, 1.1*max(table(dat$sex)))
xx <- barplot(tbl,ylab="Numero de hombres y mujeres",ylim=ylim,main=paste(nrow(dat),"estudiantes",sep=" "))
text(x=xx,y=table(dat$sex),label=table(dat$sex), pos = 3, col="blue")
#barplot(table(mine$Walc),ylab = "Number os students", xlab = "Level of Alcohol consumption on the weekends",las = 1 )
trans <- as(mine,"transactions")


# 

#Romatic sale igual al numero de trues
sum(mine$romantic ==TRUE)
#as(trans,"matrix")
itemFrequencyPlot(trans)
#Comprobamos que es correcto
romantic = mine$romantic
romantic.freq = table(romantic) 
romantic.relfreq = romantic.freq / nrow(mine)
romantic.relfreq
#Comprobamos que es correcto
walc.freq=table(mine$Walc)
walc.relfreq = walc.freq /nrow(mine)
walc.relfreq
#Subset of population
trans_female <- subset(trans, items %in% "female")
trans_notromantic <- subset(trans, items %in% "romantic =no")

par(mfrow=c(1,2))
itemFrequencyPlot(trans_romantic, population = trans)
itemFrequencyPlot(trans_r, population = trans)

trans_female <- subset(trans, items %in% "female")

apriori_p <- function (x){
    apriori(x,parameter=list(supp=0.6,conf=0.8))
}
total_rules= apriori(trans)
 
