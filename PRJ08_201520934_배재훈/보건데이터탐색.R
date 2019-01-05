## ----------------------------------------------
#
# PROJECT08. 사회조사 - 보건 - 데이터 탐색
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages(c("ggplot2", "treemap"))
library(ggplot2)
library(treemap)

# Step 1. 보건 데이터 읽어오기
health <- read.csv("2016_사회조사_보건데이터.csv")


# Step 2. 요약 통계 확인하기
summary(health)

# Step 3. 응답 분포 시각화 탐색하기 
### 나이
ggplot(health, aes(x="", y=나이)) + geom_boxplot()
### 주관적만족감: 1-매우만족 2-약간만족 3-보통 4-약간불만족 5-매우불만족
ggplot(health, aes(x="", y=주관적만족감)) + geom_boxplot()
### 건강평가: 1-매우좋다 2-좋은편이다 3-보통이다 4-나쁜편이다 5-매우나쁘다
ggplot(health, aes(x="", y=건강평가)) + geom_boxplot()
### 가정생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x="", y=가정생활스트레스)) + geom_boxplot()
### 일상생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x="", y=일상생활스트레스)) + geom_boxplot()
### 가구소득(월): 1-100만원미만 2-100~200만원 3-200~300만원 4-300~400만원 5-400~500만원 6-500~600만원 7- 600~700만원 8-700만원이상
ggplot(health, aes(x="", y=가구소득)) + geom_boxplot()
## 자살충동여부
#### 막대그래프
ggplot(health, aes(자살충동여부, fill=자살충동여부)) + geom_bar()
#### table() 함수로 빈도수 집계
suicide <- as.data.frame(table(health$자살충동여부))
colnames(suicide) <- c("자살충동여부", "응답자")
#### 파이차트
ggplot(suicide, aes(x="", y=응답자, fill=자살충동여부)) + geom_bar(stat="identity") + coord_polar(theta="y", start=0)
#### 트리맵
treemap(suicide, index=c("자살충동여부"), vSize="응답자") 

# Step 4. 자살충동여부에 따른 응답별 나이/주관적만족감/가구소득/건강평가/가정생활스트레스/일상생활스테스 분포 비교 탐색
### 나이
ggplot(health, aes(x=자살충동여부, y=나이, color=자살충동여부)) + geom_boxplot()
### 주관적만족감: 1-매우만족 2-약간만족 3-보통 4-약간불만족 5-매우불만족
ggplot(health, aes(x=자살충동여부, y=주관적만족감, color=자살충동여부)) + geom_boxplot()
### 건강평가: 1-매우좋다 2-좋은편이다 3-보통이다 4-나쁜편이다 5-매우나쁘다
ggplot(health, aes(x=자살충동여부, y=건강평가, color=자살충동여부)) + geom_boxplot()
### 가정생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x=자살충동여부, y=가정생활스트레스, color=자살충동여부)) + geom_boxplot()
### 일상생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x=자살충동여부, y=일상생활스트레스, color=자살충동여부)) + geom_boxplot()
### 가구소득(월): 1-100만원미만 2-100~200만원 3-200~300만원 4-300~400만원 5-400~500만원 6-500~600만원 7- 600~700만원 8-700만원이상
ggplot(health, aes(x=자살충동여부, y=가구소득, color=자살충동여부)) + geom_boxplot()

 
## MISSION: 혼인상태에 따른 응답별 나이/주관적만족감/가구소득/건강평가/가정생활스트레스/일상생활스테스 분포 비교탐색
ggplot(health, aes(혼인상태, fill=혼인상태)) + geom_bar()
marriage <- as.data.frame(table(health$혼인상태))
### Q1) 나이
ggplot(health, aes(x=혼인상태, y=나이, color=혼인상태)) + geom_boxplot()

### Q2) 주관적만족감: 1-매우만족 2-약간만족 3-보통 4-약간불만족 5-매우불만족
ggplot(health, aes(x=혼인상태, y=주관적만족감, color=혼인상태)) + geom_boxplot()

### Q3) 건강평가: 1-매우좋다 2-좋은편이다 3-보통이다 4-나쁜편이다 5-매우나쁘다
ggplot(health, aes(x=혼인상태, y=건강평가, color=혼인상태)) + geom_boxplot()

### Q4) 가정생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x=혼인상태, y=가정생활스트레스, color=혼인상태)) + geom_boxplot()

### Q5) 일상생활스트레스: 1-매우많이느꼈다 2-느끼는편이다 3-느끼지않는편이다 4-전혀느끼지않았다 5-해당없음
ggplot(health, aes(x=혼인상태, y=일상생활스트레스, color=혼인상태)) + geom_boxplot()

### Q6) 가구소득(월): 1-100만원미만 2-100~200만원 3-200~300만원 4-300~400만원 5-400~500만원 6-500~600만원 7- 600~700만원 8-700만원이상
ggplot(health, aes(x=혼인상태, y=가구소득, color=혼인상태)) + geom_boxplot()
