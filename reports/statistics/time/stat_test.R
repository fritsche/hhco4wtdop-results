require(PMCMR)
require(PMCMRplus)
library(effsize)
library(lsr)
require(methods)
# set.seed(42)

options("width"=10000)

args = commandArgs(trailingOnly=TRUE)
MyData <- read.csv(file=args, header=TRUE, sep=",")

MyData = MyData[,-1] # Ignore first column

sapply(MyData, function(x) round(c( "Stand dev" = sd(x), 
                         "Mean"= mean(x,na.rm=TRUE),
                         "n" = length(x),
                         "Median" = median(x),
                         "CoeffofVariation" = sd(x)/mean(x,na.rm=TRUE),
                         "Minimum" = min(x),
                         "Maximun" = max(x),
                         "Upper Quantile" = quantile(x,1),
                         "LowerQuartile" = quantile(x,0)
                    ),digits=10)
)

# names(MyData)
# as.vector(t(MyData))
# nrow(MyData)
# ncol(MyData)

# ARRAY <- c(0.056894,0.063017,0.063898,0.061365,0.061986,0.056605,0.056272,0.059908,0.058445,0.059153,0.049363,0.068349,0.039008,0.059362,0.065055,0.052571,0.058453,0.063936,0.05362,0.052429,0.027581,0.021072,0.046447,0.011447,0.043751,0.04014,0.046531,0.024586,0.046271,0.016294,0.0346,0.035631,0.038347,0.021145,0.030387,0.012446,0.024008,0.042234,0.014947,0.034411)
ARRAY <- as.vector(t(t(MyData)))
categs<-as.factor(rep(names(MyData),each=nrow(MyData)));
# result <- kruskal.test(ARRAY,categs)
result <- kruskal.test(ARRAY,categs)
print(result);pos_teste<-kwAllPairsNemenyiTest(ARRAY, categs, method='Tukey');print(pos_teste);


# probs<-as.factor(rep(c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44"),2))
probs <- as.factor(rep(sprintf("%d",seq(0,(nrow(MyData)-1))),ncol(MyData)))
result <- friedman.test(ARRAY,categs,probs)
print(result);
pos_teste<-frdAllPairsNemenyiTest(ARRAY, categs, probs, method='Tukey');
print(pos_teste)
# pos_teste<-posthoc.friedman.nemenyi.test(ARRAY, categs, probs);
# print(pos_teste)


# summary(welchManyOneTTest(ARRAY, categs, p.adjust="holm"))
# summary(bwsManyOneTest(ARRAY, categs))
# two.sided(ARRAY,categs)

"###################################"
# MyData$orig

# result <- by(MyData, MyData$orig, 
#     function(x) t.test(x$orig, x$Price_offline, mu=0, alt="two.sided", paired = TRUE, conf.level = 0.99))

# for (x in c("orig", "ww1", "ww2", "ww3", "ww4")){
#      for (y in c("orig", "ww1", "ww2", "ww3", "ww4")){
#           pval <- t.test(MyData[x], MyData[y])$p.value
#           # cat(x)
#           # cat(" ")
#           # cat(y)
#           cat(round(pval,digits=4))
#           cat("\t\t")
#      }
#      cat("\n")
# }

for (x in names(MyData)){
     for (y in names(MyData)){
          # pval <- t.test(MyData[x], MyData[y])$p.value
          # print(c(as.vector(MyData[x])))
          # print(class(MyData[x,2]))
          # pval <- cohen.d(c(as.vector(MyData[x])), c(as.vector(MyData[y])))
          # pval <- cohensD(c(as.vector(MyData[x])), c(as.vector(MyData[y])))
          # print(as.vector(c(MyData[[x]])))
          # print(as.vector(c(MyData[[y]])))
          # gradesA <- c(55, 65, 65, 68, 70) # 5 students with teacher A
          # gradesB <- c(56, 60, 62, 66)     # 4 students with teacher B
          pval <- cohensD(c(MyData[[x]]), c(MyData[[y]]))
          # pval <- cohensD(gradesA,gradesB)
          # cat(x)
          # cat(" ")
          # cat(y)
          cat(round(pval,digits=4))
          cat("\t\t")
     }
     cat("\n")
}

# cohen.d(control, treatment1)
# cohen.d(control, treatment2)
# cohen.d(treatment1, treatment2)'

# print("######")
# pos_teste["p.value"]["p.value"]["p.value"]
