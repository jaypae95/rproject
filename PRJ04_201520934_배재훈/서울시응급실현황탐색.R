## ----------------------------------------------
#
# PROJECT04. 서울시 응급실 현황 데이터
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages(c("ggmap"))
#library(ggmap)

# Step 1. 서울시 응급실 데이터 읽어오기
info <- read.csv("서울시 응급실 위치 정보.csv")

# Step 2. 요약통계로 서울시 응급실 현황 확인하기
summary(info)

# Step 3. '기관명(2), 기관분류(4), 의료기관분류(5), 소아야간진료(12), 경도(15), 위도(16), 허가병상수(18)' 만 선택
sub <- info[, c(2,4,5,12,15,16,18)]
#sub <- subset(info, select=c(기관명, 기관분류, 의료기관분류, 소아야간진료, WGS84경도, WGS84위도, 허가병상수))

summary(sub)

# Step 4. 기관분류 별 허가병상수 통계
aggregate(허가병상수~기관분류, sub, sum)
plot(sub$기관분류, main="기관분류별 병원수", xlab="기관분류", ylab="병원수", col="yellow")
(x <- aggregate(허가병상수~기관분류, sub, sum))
pie(x$허가병상수, x$기관분류, main="기관분류별 허가병상수 합계")

## Q1)  의료기관분류 별 허가병상수 통계 (병원수 막대그래프, 허가병상수 합계, 허가병상수 파이그래프)

plot(sub$의료기관분류, main="의료기관분류별 병원수", xlab="의료기관분류", ylab="병원수", col="yellow")
(x <- aggregate(허가병상수~의료기관분류, sub, sum))
pie(x$허가병상수, x$의료기관분류, main="의료기관분류별 허가병상수 합계")

## Q2) 소아야간진료 별 허가병상수 통계 (병원수 막대그래프, 허가병상수 합계, 허가병상수 파이그래프)

plot(sub$소아야간진료, main="소아야간진료별 병원수", xlab="소아야간진료", ylab="병원수", col="yellow")
(x <- aggregate(허가병상수~소아야간진료, sub, sum))
pie(x$허가병상수, x$소아야간진료, main="소아야간진료별 허가병상수 합계")

# Step 5. 응급실 위치 지도 시각화
(map <- qmap("Seoul", zoom = 11, maptype = "roadmap"))

## 기관분류: 병원 - red, 상급종합병원 - blue, 종합병원 - green
sub1 <- subset(sub, 기관분류=="병원")
(map <- map + geom_point(data=sub1, aes(x=WGS84경도, y=WGS84위도), size=5, alpha=0.7, color="red"))

## Q3) 기관분류: 상급종합병원 - blue


## Q4) 기관분류: 종합병원 - green
