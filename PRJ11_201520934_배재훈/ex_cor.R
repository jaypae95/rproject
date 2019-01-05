## ----------------------------------------------
#
# PROJECT11. [EX] Correlation Analysis
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
#
## ----------------------------------------------

install.packages("ggplot2")
library(ggplot2)

# Read data
student <- read.csv("student.csv")

# Correlation analysis
cor(student$성적, student$다니는학원수)
ggplot(student, aes(x=다니는학원수, y=성적)) + geom_point() + geom_smooth(method = "lm")
cor(student)
pairs(student)
pairs(student, panel = panel.smooth)

install.packages("corrplot")
library(corrplot)

corrplot(cor(student))
corrplot(cor(student), method='pie', type='lower')
corrplot(cor(student), method='number', type='lower')

