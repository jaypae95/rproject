## ----------------------------------------------
#
# PROJECT_2. 데이터 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/11/12
#
## ----------------------------------------------
#install.packages("gmodels", "corrplot")
library(gmodels)
library(corrplot)

# Step 1. 교차표로 교차분석 수행
CrossTable(survey$자살충동이유, survey$가구소득, chisq=T)
CrossTable(edu_fee$일상스트레스, edu_fee$교육비부담인식, chisq=T)
CrossTable(survey$교육정도, survey$가구소득, chisq=T)

#Step 2. 상관분석 하기
cor_data<-subset(edu_fee, select=c(가족관계, 직장스트레스, 일상스트레스, 교육비부담인식))
summary(cor_data)
corrplot(cor(cor_data), method="number", type="lower")
