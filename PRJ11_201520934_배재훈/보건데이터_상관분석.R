## ----------------------------------------------
#
# PROJECT11. 보건 데이터 상관 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages("corrplot")
library(corrplot)
library(ggplot2)

# Step 1. 보건 데이터 읽어오기
health <- read.csv("2016_사회조사_보건데이터.csv")

# Step 2. 상관분석할 데이터 항목 추출하기
check <- subset(health, select=c(나이, 주관적만족감, 건강평가, 가정생활스트레스, 일상생활스트레스))
summary(check)

# Step 3. 상관 분석
## Q1) 상관관계 분석
cor(check)

## Q2) 상관계수 그래프 출력
ggplot(check, aes(x=나이, y=일상생활스트레스)) + geom_point() + geom_smooth(method = "lm")

## Q3) 산점도 그래프 출력
pairs(check, panel = panel.smooth)


# MISSION. 성별(남자/여자)에 따른 상관관계 차이 분석
# 남자
## Q4) 전체 보건데이터 중 남자 데이터만 추출
m<-subset(health, 성별=='남자')


## Q5) 남자 데이터 중 상관분석할 데이터 항목 추출하기
m<-subset(m, select=c(나이, 주관적만족감, 건강평가, 가정생활스트레스, 일상생활스트레스))
summary(m)

## Q6) 남자 데이터 상관분석
cor(m)
corrplot(cor(m), method="number", type="lower")
# 여자
## Q7) 전체 보건 데이터 중 여자 데이터만 추출
f<-subset(health, 성별=='여자')


## Q8) 여자 데이터 중 상관분석할 데이터 항목만 추출
f<-subset(f, select=c(나이, 주관적만족감, 건강평가, 가정생활스트레스, 일상생활스트레스))
summary(f)
## Q9) 여자 데이터 상관분석
cor(f)
