## ----------------------------------------------
#
# PROJECT_1. 보건.복지 - 사망원인통계
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/10/12
#
## ----------------------------------------------

#install.packages(c("readxl", "dplyr"))
library(readxl)
library(dplyr)

#2016년 사망원인 데이터 읽어오기
annual <- read.csv("사망원인_2016.csv", header=FALSE)

#분석에 사용할 항목만 데이터 선택하기
death <- annual[,c(2, 4, 5, 7, 9:14, 20)]

#column 이름 부여하기
names(death) <- c("신고날짜(월)", "사망자주소", "사망자성별", "사망일자(월)", "사망시간", "사망연령", 
                  "사망장소", "사망자직업", "혼인상태", "교육정도", "사망원인")

#사망자 주소 전처리
death$사망자주소 <- factor(death$사망자주소, 
                      levels=c(11, 21, 22, 23, 24, 25, 26, 29,
                               31, 32, 33, 34, 35, 36, 37, 38, 39),
                      labels=c("서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", 
                               "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"))
#사망장소 전처리
death$사망장소 <- factor(death$사망장소,
                     levels=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 99),
                     labels=c("주택", "의료기관", "사회복지시설", "공공시설", 
                              "도로", "상업.서비스시설", "산업장", "농장", 
                              "병원 이송 중", "기타", "미상"))
#혼인상태 전처리
death$혼인상태 <- factor(death$혼인상태,
                     levels=c(1, 2, 3, 4, 9), 
                     labels=c("미혼", "배우자있음", "이혼", "사별", "미상"))

#교육정도 전처리
death$교육정도 <- factor(death$교육정도, 
                     levels=c(1, 2, 3, 4, 6, 7, 9),
                     labels=c("불취학", "초등학교", "중학교",
                              "고등학교", "대학교", "대학원이상", "미상"))

#직업 코드 시트
code_job <- read_excel("2016년 사망(원인) 통계 설계서 및 코드집 _ 공공용.xlsx", col_names = T, sheet = 3)

job <- code_job[c(2:11),c(1, 2)] #직업코드
job[, c(1)] <- sapply(job[,c(1)], as.numeric) #직업코드 정수화

#사망자직업 전처리
death$사망자직업 <- factor(death$사망자직업,
                           levels=job$`2008~2016년`,
                           labels=job$X__1)

#사망원인 코드 시트
code_reason <- read_excel("2016년 사망(원인) 통계 설계서 및 코드집 _ 공공용.xlsx", col_names = T, sheet = 5)
names(code_reason) <- c("가", "나", "다")
code_reason <- subset(code_reason, !is.na(가)) #na제거

reason <- code_reason[c(2:57), c(1, 2)] #사망원인 코드
reason[, c(1)] <- sapply(reason[,c(1)], as.numeric) #코드 정수화
#사망원인 전처리
death$사망원인 <- factor(death$사망원인, levels=reason$가, labels=reason$나)

summary(death) #요약

head(death)
death<-death[death$사망연령 != 999,] #999세(미상) 제거

suicide<-subset(death, 사망원인 == "고의적자해(자살) (Intentional self-harm )")
summary(suicide) #요약


###################################################################################################################

# Step 1. 2016년 사망원인 데이터 읽어오기
survey <- read.csv("자살충동여부조사.csv", header=FALSE)

#분석에 사용할 항목만 데이터 선택하
survey<- survey[,c(1:14, 18,21)]
names(survey) <- c("성별", "만나이", "교육정도", "혼인상태", "흡연여부", "금연어려운이유", 
                  "음주여부", "직장스트레스", "일상스트레스", "자살충동", "자살충동이유",
                  "교육비부담인식", "부모생존여부", "이혼에대한견해", "가족관계", "가구소득")

#데이터 범위 설정
survey <-subset(survey, 만나이 >= 50)
survey <- subset(survey, 만나이 < 60)
survey <- subset(survey, 자살충동 == 1)
#성별 전처리
survey$성별 <- factor(survey$성별, levels = c(1,2), labels=c("Male", "Female"))
#교육정도 전처리
survey$교육정도 <- factor(survey$교육정도, levels=c(0,1,2,3,4,5,6,7),
                      labels=c("lack of schooling", "elementary school", "middle school", "high school", "two-year univ.", 
                               "four-year univ.", "postgraduate master's", "graduate doctor"))
#혼인상태 전처리
survey$혼인상태 <- factor(survey$혼인상태, levels=c(1,2,3,4), labels=c("single", "has a spouse",
                                                               "bereavement", "divorce"))
#흡연여부 전처리
survey$흡연여부 <- factor(survey$흡연여부, levels=c(1,2), labels=c("피운다", "피우지않는다"))
#금연이어려운이유 전처리
survey$금연어려운이유 <- factor(survey$금연어려운이유,
                          levels=c(1,2,3,4,5), labels=c("stress", "influence of others",
                                                        "withdrawal symptoms", "habbit", "etc"))
#자살충동이유 전처리
survey$자살충동이유 <- factor(survey$자살충동이유, levels=c(1,2,3,4,5,6,7,8,9),
                        labels=c("financial problem", "heterosexual problem", "physical.mental illness",
                                 "work problem", "loneliness", "family discord", "school grade",
                                 "being bullied", "etc"))
#부모생존여부 전처리
survey$부모생존여부 <- factor(survey$부모생존여부, levels=c(1,2,3,4),
                        labels=c("all of parents are alive", "only father is alive", "only mother is alive", "all of parents died"))
#이혼에대한견해 전처리
survey$이혼에대한견해 <- factor(survey$이혼에대한견해, levels=c(1,2,3,4,5),
                         labels=c("never", "not necessarily",
                                  "may", "divorce if there is a reason", "not sure"))
#가구소득 전처리 . 단위: 백만원
survey$가구소득 <- factor(survey$가구소득, levels=c(1,2,3,4,5,6,7,8),
                      labels=c("~100", "100~200", "200~300", "300~400",
                               "400~500", "500~600", "600~700", "700~"))
#교육비부담인식 전처리
#survey$교육비부담인식 <- factor(survey$교육비부담인식, levels=c(1,2,3,4,5),
#                         labels=c("매우부담", "약간부담", "보통", "별로부담X", "전혀부담X"))
summary(survey)
#음주여부 1.있다  2. 없다
#직장 및 일상 스트레스 1.매우 느낌 2. 느끼는 편  3. 느끼지 않는 편
#                      4. 전혀 느끼지 않음 5. 해당없음
#형제, 부모, 가족관계  1. 매우만족, 2, 약간 만족, 3, 보통,
#                      4. 약간 불만족, 5.매우 불만족, 6. 해당없음

