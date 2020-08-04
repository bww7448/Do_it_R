####그래프 만들기!!####
library(ggplot2)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
#######어떤 데이터 쓸거고 xy축 배경 생성 
  geom_point() +   
  #그래프 종류는 뭐?
  xlim(3,6) + ylim(10,30)
###x, y축의 범위를 설정해 준다! ##배경 생성 후에는 +로 연결연결


##막대 그래프
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col() #이친구가 막대그래프 만드는 친구
                                                              #근데 얘는 요약표를 활용하고

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()
                              ##이친구는 정렬해주는 친구

#빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar() #얘는 원자료를 활용해 막대그래프 만든다.
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

##혼자해보기
mpg_ex <- mpg
str(mpg_ex)
mpg_graph <- mpg_ex %>%  
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)
ggplot(data = mpg_graph, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + 
  geom_col() + ylim(0, 20) #왜 ylim(10, 20)은 안먹히는 걸까?

ggplot(data = mpg_ex, aes(x = class)) + geom_bar()

mpg_ex2 <-mpg_ex %>%  
