## ----------------------------------------------
#
# PROJECT_2. 데이터 탐색
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/11/12
#
## ----------------------------------------------
############data_refining.c 실행 이후에 실행해 주세요###############
#install.packages(c("ggplot2", "googleVis"))
                   
library(googleVis)
library(ggplot2)

summary(survey)

#googleVis를 이용해 도넛 차트 생성하기
plot(gvisPieChart(data.frame(table(survey$자살충동이유)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
plot(gvisPieChart(data.frame(table(survey$성별)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
plot(gvisPieChart(data.frame(table(survey$가구소득)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
plot(gvisPieChart(data.frame(table(survey$교육정도)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
plot(gvisPieChart(data.frame(table(survey$혼인상태)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
plot(gvisPieChart(data.frame(table(survey$이혼에대한견해)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))
quit_smoking <- subset(survey, !is.na(금연어려운이유))
plot(gvisPieChart(data.frame(table(quit_smoking$금연어려운이유)), option=list(width=600, height=600, pieHole=0.5), chartid="donut"))

# ggplot(survey, aes(자살충동이유, fill=자살충동이유)) + geom_bar()
# ggplot(survey, aes(성별, fill=성별)) + geom_bar()
# ggplot(survey, aes(가구소득, fill=가구소득)) + geom_bar()
# ggplot(survey, aes(교육정도, fill=교육정도)) + geom_bar()
# ggplot(survey, aes(혼인상태, fill=혼인상태)) + geom_bar()
# ggplot(survey, aes(이혼에대한견해, fill=이혼에대한견해)) + geom_bar()
# quit_smoking <- subset(survey, !is.na(금연어려운이유))
# ggplot(quit_smoking, aes(금연어려운이유, fill=금연어려운이유)) + geom_bar()


#박스 플롯 생성하
#1.매우만족 2.약간만족 3.보통 4.약간 불만족 5.매우불만족 6.해당없음
ggplot(survey, aes(x="", y=가족관계)) + geom_boxplot()
#1.매우많이느낌 2.느끼는 편 3.느끼지 않는 편 4.전혀 느끼지 않음 5.해당 없음
ggplot(survey, aes(x="", y=직장스트레스)) + geom_boxplot()
#1.매우많이느낌 2.느끼는 편 3.느끼지 않는 편 4.전혀 느끼지 않음 5.해당 없음
ggplot(survey, aes(x="", y=일상스트레스)) + geom_boxplot()

edu_fee <- subset(survey, !is.na(교육비부담인식))
#1.매우부담스럽다 2.약간 부담스럽다. 3.보통이다. 4.별로 부담스럽지 않다. 5.전혀 부담스럽지 않다.
ggplot(edu_fee, aes(x="", y=교육비부담인식)) + geom_boxplot()
