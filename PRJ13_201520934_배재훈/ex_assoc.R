## ----------------------------------------------
#
# PROJECT13. [EX] Association Relation Analysis
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages("arules")
library(arules)

# Read data
data("Groceries")
summary(Groceries)

# Association analysis
## Basic condition: support 0.2, confidence 0.8, minimum length 1
rule <- apriori(Groceries)

## Condition: support 2.5%, confidence 20%, minimum length 2
rule <- apriori(Groceries, parameter=list(support=0.025, confidence=0.2, minlen=2))
summary(rule)
rule.df <- as(rule, "data.frame")

## Analysis 'whole milk' 
rule.milk <- inspect(subset(rule, subset=rhs %in% "whole milk"))
rule.milk.df <- as(rule.milk, "data.frame")
inspect(subset(rule, subset=lhs %in% "whole milk"))
inspect(subset(rule, subset=lhs %in% "yogurt" & rhs %in% "whole milk"))

## Condition: support 2%, confidence 10%, minimum length 2
rule <- apriori(Groceries, parameter=list(support=0.02, confidence=0.1, minlen=2))
summary(rule)
rule.df <- as(rule, "data.frame")

## Q1) 'root vegetables'을 팔면 어떤 물건이 함께 잘 팔릴까
inspect(subset(rule, subset=lhs %in% "root vegetables"))

## Q2) 'vegetables' 그룹('root vegetables, other vegetables') 판매에 함께 영향을 받는 물건은 무엇일까
inspect(subset(rule, subset=lhs %ain% c("root vegetables", "other vegetables")))

## Q3) 'soda' 판매에 영향을 주는 물건은 무엇인가
inspect(subset(rule, subset=rhs %in% "soda"))

## Q4) 'soda'와 'yogurt' 판매에 동시에 영향을 주는 물건이 있는가
inspect(subset(rule, subset=rhs %ain% c("soda", "yogurt")))

# Save rules to file
write.csv(rule.df, "rule.csv")
