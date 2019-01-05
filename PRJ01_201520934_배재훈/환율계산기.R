## ----------------------------------------------
#
# PROJECT01. 환율 계산기
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/09/13
#
## ----------------------------------------------

message("\n원화를 달러로 변환해주는 계산기입니다.\n")

# Step 1. 원화, 환율 입력
cat("원화 입력: ")
won <- scan(n=1)
cat("환율 입력: ")
rate <- scan(n=1)

# Step 2. 환율 계산식
dollar <- won / rate

# Step 3. 달러화 출력
cat("[",won, "]원은", "[", round(dollar,digits=2),"]달러입니다\n")