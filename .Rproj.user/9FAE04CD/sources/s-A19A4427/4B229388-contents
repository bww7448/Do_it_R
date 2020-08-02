###4장

##엑셀파일, csv 파일 읽기

install.packages("readxl")
library(readxl)
df_exam <- read_excel("Data/excel_exam.xlsx")
df_exam
mean(df_exam$english)
mean(df_exam$science)

df_exam_novar <- read_excel("Data/excel_exam_novar.xlsx")
df_exam_novar
#컬럼네임이 없을때 False 를 준다.
df_exam_novar <- read_excel("Data/excel_exam_novar.xlsx", col_names = F)
#3sheet 읽어오기
df_exam_sheet <- read_excel("Data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

df_csv_exam <- read.csv("Data/csv_exam.csv")
df_csv_exam
#string들을 Factor로 읽어오면 오류가 많이 난다.
df_csv_exam <- read.csv("Data/csv_exam.csv", stringsAsFactors = F)

df_midterm <- data.frame(english = c(90,80,60,70),
                         math = c(50,60,100,20),
                         class = c(1,1,2,2))
df_midterm
##csv, RDS 파일 만들기
#RDS란 R에서만 쓰는 파일 형식으로써 빠르게 작업은 가능하다.
write.csv(df_midterm, file = "df_midterm.csv")
saveRDS(df_midterm, file = "df_midterm.rds")
df_midterm <- readRDS("df_midterm.rds")
View(df_midterm)


#####5-1 mpg 데이터를 활용한 여러가지 기능 확인 
install.packages("ggplot2")
library(ggplot2)

mpg<- as.data.frame(ggplot2::mpg)
mpg
head(mpg, 10) #상위 10개
tail(mpg, 10) #밑에 10개  둘다 default는 6 
View(mpg) #View는 반드시 V를 대문자로!
dim(mpg) #몇행 몇열인지
str(mpg) #자료 구조 확인
summary(mpg) #요약 확인


#####5-2 변수 명 변경하기
df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

install.packages("dplyr") #rename을 쓰려면 dplyr을 인스톨 해야한다!
library(dplyr)
df_new <- df_raw

df_new <- rename(df_new, v2 = var2) #var2를 v2로 수정
df_new
mpg_ex <- mpg
mpg_ex <- rename(mpg_ex, city = cty, highway = hwy)
mpg_ex


#####5-3 파생변수 만들기
df<- data.frame(var1 = c(4,3,8),
                var2 = c(2,6,1))
df$var_sum <- df$var1 + df$var2
df$var_mean <- (df$var1 + df$var2)/2
df
df$var2 <- (c(6,3,2))
mpg_ex
mpg_ex$total <- (mpg_ex$city + mpg_ex$highway)/2
mean(mpg_ex$total)
summary(mpg_ex$total)
#히스토그램 만들기!
hist(mpg_ex$total)
#조건문을 이용한 파생변수 만들기
mpg_ex$test <- ifelse(mpg_ex$total >= 20, "pass", "fail") #조건, 참일때, 거짓일때때
head(mpg_ex, 8)
table(mpg_ex$test) #빈도표로 합격 판정 확인
qplot(mpg_ex$test) #빈도 막대그래프 생성
###중첩조건문 활용하기
mpg_ex$grade <- ifelse(mpg_ex$total >=30, "A",
                       ifelse(mpg_ex$total >= 25, "B", 
                              ifelse(mpg_ex$total >= 20, "C", "D")))
table(mpg_ex$grade)
qplot(mpg_ex$grade)

######midwest자료 활용하기
midwest_ex<- as.data.frame(ggplot2::midwest)
midwest_ex
summary(midwest_ex)
dim(midwest_ex)

#rename활용하기
midwest_ex <- rename(midwest_ex, total = poptotal)
midwest_ex <- rename(midwest_ex, asian = popasian)

#백분율 만들기
midwest_ex$ratio <- (midwest_ex$asian / midwest_ex$total)
mean(midwest_ex$ratio)
#파생변수 만들기
midwest_ex$capa <- ifelse(midwest_ex$ratio >= mean(midwest_ex$ratio), "large", "small")
table(midwest_ex$capa)
qplot(midwest_ex$capa)
