## ----------------------------------------------
#
# PROJECT02. 공공 데이터
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages("ggmap")
library(ggmap)

# Step 1. 서울시 응급실 데이터 읽어오기
info <- read.csv("서울시 응급실 위치 정보.csv")

# Step 2. 요약 통계로 데이터 확인하기
summary(info)

# Step 3. 응급실 위치 정보 시각화
(map <- qmap("Seoul", zoom = 11, maptype = "roadmap"))
(map <- map + geom_point(data=info, aes(x=WGS84경도, y=WGS84위도), size=5, alpha=0.7, color="red"))
