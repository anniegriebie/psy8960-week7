# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)


# Data Import and Cleaning
week7_tbl <- read.csv("../data/week3.csv",  header = TRUE) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeEnd = ymd_hms(timeEnd)) %>%
  mutate(gender = factor(gender, levels = c("F", "M"), labels = c("Female", "Male"))) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units =c("mins")))




# Visualization
week7_tbl %>% 
  select(starts_with("q")) %>% 
  ggpairs()
(ggplot(week7_tbl, aes(x=timeStart, y=q1)) +
    geom_point() +
    scale_x_datetime("Date of Experiment")+
    scale_y_continuous("Q1 Score")) %>%
  ggsave("../figs/fig1.png",., width = 9, height = 5 , units = "in") 