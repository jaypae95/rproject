## ----------------------------------------------
#
# PROJECT14. 보건 데이터 연관 분석
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
health <- read.csv("2016_사회조사_보건데이터.csv")
# Step 3. 분석에 필요한 데이터 항목만 가져오기
check <- subset(health, select=c(성별, 혼인상태, 주관적만족감, 건강평가, 가정생활스트레스, 일상생활스트레스, 가구소득))
# Step 4. 요약 통계 확인
summary(check)
# Step 5. 범주형 데이터 정제
check$주관적만족감 <- factor(check$주관적만족감, levels=c(1:5), labels=c('매우만족', '약간만족', '보통', '약간불만족', '매우불만족'))
check$건강평가 <- factor(check$건강평가, levels=c(1:5), labels=c('매우좋다',	'좋은편이다', '보통이다',	'나쁜편이다', '매우나쁘다'))
check$가정생활스트레스 <- factor(check$가정생활스트레스, levels=c(1:5), labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))
check$일상생활스트레스 <- factor(check$일상생활스트레스, levels=c(1:5), labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))
check$가구소득 <- factor(check$가구소득, levels=c(1:8), labels=c('100만원미만', '100~200만원', '200~300만원', '300~400만원', '400~500만원', '500~600만원', '600~700만원', '700만원이상'))
# Step 6. 정제 결과를 요약 통계로 확인
summary(check)

# Step 7. 연관 분석
## 기본조건 (support=0.1, confidence=0.8, minlen=1)으로 연관분석 시작
rule <- apriori(check)
## 기본규칙 요약 보기
summary(rule)
## 기본규칙 상세 보기
rule.df <- as(rule, "data.frame")

## Q1) 응답비중이 높은 응답패턴 분석
rule <- apriori(check, parameter=list(support=0.3, confidence=0.001, minlen=2))
rule.df <- as(rule, "data.frame")

## Q2) 스트레스(매우많이느꼈다/느끼는편이다)에 영향을 주는 응답패턴 찾기 
rule <- apriori(check, parameter=list(support=0.05, confidence=0.8, minlen=2))
###### 가정생활스트레스 규칙
inspect(subset(rule, subset=rhs %in% c("가정생활스트레스=매우많이느꼈다", "가정생활스트레스=느끼는편이다")))
###### 일상생활스트레스 규칙
inspect(subset(rule, subset=rhs %in% c("일상생활스트레스=매우많이느꼈다", "일상생활스트레스=느끼는편이다")))


## Q3) 스트레스(전혀느끼지않았다/느끼지않는편이다)에 영향을 주는 응답패턴 찾기 
###### 가정생활스트레스 규칙
inspect(subset(rule, subset=rhs %in% c("가정생활스트레스=전혀느끼지않았다", "가정생활스트레스=느끼지않는편이다")))
###### 일상생활스트레스 규칙
inspect(subset(rule, subset=rhs %in% c("일상생활스트레스=전혀느끼지않았다", "일상생활스트레스=느끼지않는편이다")))

## Q4) 혼인상태가 스트레스에 영향을 주는 지 분석
###### 가정생활스트레스 규칙
inspect(subset(rule, subset=lhs %pin% c("혼인상태=") & rhs %in% c("가정생활스트레스=매우많이느꼈다", "가정생활스트레스=느끼는편이다")))
###### 일상생활스트레스 규칙


## Q5) 가구소득이 스트레스에 영향을 주는 지 분석
###### 가정생활스트레스 규칙
inspect(subset(rule, subset=lhs %pin% c("가구소득=") & rhs %in% c("가정생활스트레스=매우많이느꼈다", "가정생활스트레스=느끼는편이다")))
###### 일상생활스트레스 규칙

