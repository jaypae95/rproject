## ----------------------------------------------
#
# PROJECT15. 타이타닉호 생존규칙 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

# Step 1. 패키지 설치 및 로딩
#install.packages("arules")
library(arules)

# Step 2. 데이터 읽어오기
titanic <- read.csv("titanic.csv")
# Step 3. 요약통계summary(titanic)
summary(titanic)
# Step 4. 연관분석
rules.all <- apriori(titanic)
rules.all.df <- as(rules.all, "data.frame")
rules.survived <- inspect(subset(rules.all, subset=rhs %in% "Survived=Yes"))
rules.survived.df <- as(rules.survived, "data.frame")

## Survived=Yes
rules.all <- apriori(titanic, parameter=list(minlen=2, support=0.005))
rules.survived <- inspect(subset(rules.all, subset=rhs %in% "Survived=Yes"))
rules.survived.df <- as(rules.survived, "data.frame")

## Class and Age => Survived=Yes
rules.all <- apriori(titanic, parameter=list(minlen=2, support=0.002, confidence=0.2))
rules.class <- inspect(subset(rules.all, subset=lhs %ain% "Age=Child" & rhs %in% "Survived=Yes"))
rules.class.df <- as(rules.class, "data.frame")

## 조건 => Survived=Yes
### Q1) 남자/여자 의 성별에 따른 생존규칙
rules.all <- apriori(titanic, parameter=list(minlen=2, support=0.002, confidence=0.2))
rules.sx <- inspect(subset(rules.all, subset=lhs %in% c("Sex=Male", "Sex=Female") & rhs %in% "Survived=Yes"))
rules.sx.df <- as(rules.sx, "data.frame")
### Q2) 남자 어른의 생존규칙
rules.all <- apriori(titanic, parameter=list(minlen=2, support=0.002, confidence=0.2))
rules.sx <- inspect(subset(rules.all, subset=lhs %ain% c("Sex=Male", "Age=Adult") & rhs %in% "Survived=Yes"))
rules.sx.df <- as(rules.sx, "data.frame")

### Q3) 여자 어른의 생존규칙
rules.all <- apriori(titanic, parameter=list(minlen=2, support=0.002, confidence=0.2))
rules.sx <- inspect(subset(rules.all, subset=lhs %ain% c("Sex=Female", "Age=Adult") & rhs %in% "Survived=Yes"))
rules.sx.df <- as(rules.sx, "data.frame")
