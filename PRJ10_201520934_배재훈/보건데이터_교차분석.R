## ----------------------------------------------
#
# PROJECT10. 보건 데이터 교차 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages("gmodels")
library(gmodels)

# Step 1. 보건 데이터 읽어오기
health <- read.csv("2016_사회조사_보건데이터.csv")

# Step 2. 요약 통계 확인
summary(health)

# Step 3. 범주형 데이터 추가 정제
health$주관적만족감 <- factor(health$주관적만족감, levels=c(1:5), labels=c('매우만족', '약간만족', '보통', '약간불만족', '매우불만족'))
health$건강평가 <- factor(health$건강평가, levels=c(1:5), labels=c('매우좋다',	'좋은편이다', '보통이다',	'나쁜편이다', '매우나쁘다'))
health$가정생활스트레스 <- factor(health$가정생활스트레스, levels=c(1:5), labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))
health$일상생활스트레스 <- factor(health$일상생활스트레스, levels=c(1:5), labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))

# Step 4. 정제 결과를 요약 통계로 확인
summary(health)

# Step 5. 교차 분석
## 자살충동여부
## 1) ‘성별’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$성별, chisq=T)
## 2) ‘주관적만족감’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$주관적만족감, chisq=T)
chisq.test(health$자살충동여부, health$주관적만족감)
## 3) ‘건강평가’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$건강평가, chisq=T)
## 4) ‘가정생활스트레스’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$가정생활스트레스, chisq=T)
## 5) ‘일상생활스트레스’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$일상생활스트레스, chisq=T)
## 6) ‘본인경제활동여부’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
CrossTable(health$자살충동여부, health$본인경제활동여부, chisq=T)
## 7) ‘배우자경제활동여부’에 따른 ‘자살충동여부’는 유의미한 관계를 갖는다.
##### 주의: 배우자경제활동여부는 배우자가 있는 경우에만 응답했기에 결측값(NA) 존재
married <- subset(health,!is.na(배우자경제활동여부))
CrossTable(married$자살충동여부, married$배우자경제활동여부, chisq=T)
# A때문에 B가됐다가 아닌(인과관계 X) A와 B가 관계있다(연관관계)를 보기때문에
# A가 x축인 지 y축인지 상관이 없다.

## MISSION 1: 성별
## Q1) 혼인상태
CrossTable(health$성별, health$혼인상태, chisq=T)
## Q2) 주관적만족감
CrossTable(health$성별, health$주관적만족감, chisq=T)
## Q3) 건강평가
CrossTable(health$성별, health$건강평가, chisq=T)
## Q4) 가정생활스트레스
CrossTable(health$성별, health$가정생활스트레스, chisq=T)
## Q5) 일상생활스트레스
CrossTable(health$성별, health$일상생활스트레스, chisq=T)
## Q6) 본인경제활동여부
CrossTable(health$성별, health$본인경제활동여부, chisq=T)
## Q7) 배우자경제활동여부
CrossTable(married$성별, married$배우자경제활동여부, chisq=T)
## MISSION 2: 혼인상태
## Q1) 성별
CrossTable(health$혼인상태, health$성별, chisq=T)
## Q2) 주관적만족감
CrossTable(health$혼인상태, health$주관적만족감, chisq=T)
## Q3) 건강평가
CrossTable(health$혼인상태, health$건강평가, chisq=T)
## Q4) 가정생활스트레스
CrossTable(health$혼인상태, health$가정생활스트레스, chisq=T)
## Q5) 일상생활스트레스
CrossTable(health$혼인상태, health$일상생활스트레스, chisq=T)
## Q6) 본인경제활동여부
CrossTable(health$혼인상태, health$본인경제활동여부, chisq=T)
## Q7) 배우자경제활동여부
CrossTable(married$혼인상태, married$배우자경제활동여부, chisq=T)
