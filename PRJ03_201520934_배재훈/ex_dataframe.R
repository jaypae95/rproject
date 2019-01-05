## ----------------------------------------------
#
# PROJECT03. [EX] Data Structure
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

x <- read.csv("fruits.csv")

# Excercise for subset()
subset(x, Fruit=="Bananas")
#subset(x, Fruit==Bananas)
subset(x, Year>=2009)

cat("\nQ1) 판매량(Sales)가 90 이상인 데이터\n")
print(subset(x, Sales>=90))

y <- subset(x, select=c(Fruit, Sales))
cat("\nQ2) 인덱스 표현으로 {Fruit, Sales} 항목만 z 변수에 저장\n")
print(z<-x[,c(1,4)])

# Excercise for aggregate()
aggregate(Sales~Fruit, x, sum)
aggregate(Sales~Year, x, sum)

cat("\nQ3) 지역(Location)별 판매량 평균(mean)\n")
print(aggregate(Sales~Location, x, mean)) #앞의 것에 대해서 mean을 구하고 싶다, 뒤의 것은 기준

aggregate(Sales~Location+Fruit, x, sum)

cat("\nQ4) 과일별 지역별 판매량 합계\n")
print(aggregate(Sales~Fruit+Location, x, sum))

cat("\nQ5) 지역별 과일별  최대(max) 판매량\n")
print(aggregate(Sales~Location+Fruit,x, max))

# Excercise for merge()
d1 <- data.frame(name=c("Apple", "Banana", "Cherry"), price=c(300, 200, 100))
d2 <- data.frame(name=c("Apple", "Cherry", "Grape"), count=c(10, 20, 30))
merge(d1, d2)
merge(d1, d2, all=TRUE)

