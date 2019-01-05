## ----------------------------------------------
#
# PROJECT07. [EX] Math Functions
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

# Excercise of math functions for numeric data
d <- c(1, 2, 2, 3, 3, 3, 4, 5, 6, 7, 8, 9, 9, 9, 9 ,9, 10, 10, 10)
mean(d)
median(d)
min(d)
max(d)
sd(d)
var(d)

summary(d)

# Excercise of math functions for categorical or character data
d <- c('A', 'B', 'B', 'C', 'C', 'C', 'C', 'D', 'E', 'F', 'G', 'G')
mean(d)
median(d)
min(d)
max(d)

table(d)                      # x <- table(d)
max(table(d))                 
which.max(table(d))           # y <- which.max(x))
names(which.max((table(d))))  # names(y)


