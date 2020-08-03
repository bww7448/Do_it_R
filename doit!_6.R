#### filter활용하기

library(dplyr)
exam <- read.csv("Data/csv_exam.csv")
exam %>% filter(class == 1) #class가 1인 행만 출력한다!
#  %>%는 파이프 연산자로 부르고 ctrl+shift+m을 누르면 삽입된다.
# 파라미터 지정시에는 = / 같다는 의미는 ==

exam %>% filter(class != 2) #2반이 아닌 경우!
exam %>% filter(math > 50) #math점수가 50 초과 인 경우!
#응용해서 > < >= <= 모두 가능!

exam %>% filter(class ==1 & math >=50) #&를 이용해 and연산 가능!
exam %>% filter(math>=90 | english >=90) #|를 이용해 or연산도 가능!
exam %>% filter(class %in% c(1,3,5)) #1,3,5반 출력 이렇게도 쓸 수 있다.

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$science)

install.packages("ggplot2")
library(ggplot2)
mpg_ex<-as.data.frame(ggplot2::mpg)
cls1 <- mpg_ex %>% filter(displ <= 4)
cls2 <- mpg_ex %>% filter(displ >= 5)
mean(cls1$hwy)
mean(cls2$hwy)

cls3 <- mpg_ex %>% filter(manufacturer == "audi")
cls4 <- mpg_ex %>% filter(manufacturer == "toyota")
mean(cls3$cty)
mean(cls4$cty)

cls5 <- mpg_ex %>% filter(manufacturer == "chevrolet")
cls6 <- mpg_ex %>% filter(manufacturer == "ford")
cls7 <- mpg_ex %>% filter(manufacturer == "honda")
cls8 <- mpg_ex %>% filter(manufacturer %in% c("honda", "ford", "chevrolet"))
mean(cls8$hwy)


####select 이용하기
exam %>% select(class, english) #변수명 선택해서 출력한다.
exam %>% select(-math, science) #-를 붙이면 그 변수만 빼고 출력한다.

####dplyr 함수를 조합할 수도 있다!
exam %>% 
  filter(class == 1) %>% 
  select(math) %>% 
  head(2)

mpg_ex2<- mpg_ex %>% select(class, cty)
head(mpg_ex2, 4)

suv <- mpg_ex2 %>% filter(class == "suv")
com <- mpg_ex2 %>% filter(class == "compact")
mean(suv$cty)
mean(com$cty)

####정렬하기
exam %>% arrange(math)
exam %>% arrange(desc(science))
exam %>% arrange(class, desc(english)) #class로 먼저 정렬 후 math 로 정렬한다!


mpg_ex %>% 
  filter(manufacturer == "audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)

####파생변수 추가하기
exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>% 
  arrange(total) %>% 
  head

exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

##mutate를 쓴다고 컬럼이 추가되는 것은 아니다!
exam


####집단별로 요약하기 summarise
exam %>%
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())# n() 은 각 그룹이 몇행을 돼 있는지를 나타낸다.

#참고 표준편차 sd

mpg_ex %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(mean_cty) %>% 
  head(10)

##가로로 합치기
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70, 83, 65, 95, 80))

test1
total <- left_join(test1, test2, by = "id")
total


name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new


##세로로 합치기
group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85))
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,83,65,95,80))
group_all <- bind_rows(group_a, group_b)
group_all

##변수명이 다를경우 rename을 활용해 변수 명을 일치시켜준 뒤 실시한다.
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                  price_f1 = c(2.35, 2.38, 2.11, 2.76, 2.22),
                  stringsAsFactors = F)
mpg_ex
mpg_ex <- left_join(mpg_ex, fuel, by = "fl")
mpg_ex %>% 
  select(c("model", "fl", "price_f1")) %>%
  head(5)

midwest_ex <- midwest
str(midwest_ex)
##popkid 만들기
midwest_ex$popkid <- (1 - midwest_ex$popadults/midwest_ex$poptotal)*100
midwest_ex %>% 
  select(popkid) %>% 
  arrange(desc(popkid)) %>% 
  head(5)
##비율별 도시 수
midwest_ex$how <- ifelse(midwest_ex$popkid >= 40, "large",
                         ifelse(midwest_ex$popkid >= 30, "middle", "small"))
midwest_ex %>% 
  group_by(how) %>% 
  summarise(num = n())

##popasian
midwest_ex$asitio <- (midwest_ex$popasian / midwest_ex$poptotal)*100
midwest_ex %>% 
  select(state, county, asitio) %>% 
  arrange(asitio) %>% 
  head(10)
