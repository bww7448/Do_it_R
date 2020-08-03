df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
is.na(df)
table(is.na(df))

library(dplyr)
df %>%filter(is.na(score)) #is.na -> 결측치 있는지 확인
df_nom <- df %>% filter(!is.na(score))
mean(df_nom$score)
sum(df_nom$score)

df_nom2 <- na.omit(df) #na.omit -> 결측치 제거
df_nom2

mean(df$score, na.rm = T) #na.rm -> 결측치를 빼고

##summrise()를 활용할때도 na.rm을 활용할 수 있다.
exam <- read.csv("Data/csv_exam.csv")
exam[c(3, 8, 15), "math"] <- NA
exam %>%summarise(mean_math = mean(math, na.rm = T),
                  median_math = median(math, na.rm = T),
                  sum_math = sum(math, na.rm = T))
mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math) #NA에 평균값 집어넣기


mpg <- as.data.frame(ggplot2 :: mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
table(is.na(mpg))
mpg %>% filter(!is.na(hwy)) %>% 
  group_by(trans) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))

##이상치 정제하기
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
table(outlier$sex)
table(outlier$score)
outlier$sex <- ifelse(outlier$sex ==1 | outlier$sex ==2, outlier$sex, NA)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

###혼자서 해보기
mpg<- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

#이상치를 결측처리 후 이상치가 없는지 확인
mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
table(is.na(mpg$drv))
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty > 26 | mpg$cty < 9, NA, mpg$cty)
boxplot(mpg$cty)

#이상치를 제외한 다음 drv별로 cty평균이 다른지 확인
mpg %>%
  filter(!is.na(drv)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty, na.rm = T))
