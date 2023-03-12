# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)


# Data Import and Cleaning
week7_tbl <- read.csv("../data/week3.csv",  header = TRUE) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeEnd = ymd_hms(timeEnd)) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male",  "Female"))) %>%
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

(ggplot(week7_tbl, aes(x=q1, y=q2, color=gender)) +
    geom_jitter() +
    labs(color = "Participant Gender")) %>%
  ggsave("../figs/fig2.png",., width = 9, height = 4, units = "in")

(ggplot(week7_tbl, aes(x=q1, y=q2))+
    geom_jitter()+
    facet_grid(. ~ gender)+
    labs(x="Score on Q1",y="Score on Q2")) %>%
  ggsave("../figs/fig3.png",., width = 7, height = 4, units = "in")


(ggplot(week7_tbl, aes(x=gender, y=timeSpent)) +
    geom_boxplot() +
    labs(x="Gender", y ="Time Elapsed (mins)")) %>%
  ggsave("../figs/fig4.png",., width = 7, height = 4, unit = "in")
# showswarning for difftime object, defaulting to continuous recheck this later

(ggplot(week7_tbl, aes(x=q5, y=q7, color = condition)) +
    geom_jitter(width = 0.1) +
    geom_smooth(method = "lm", se = F) +
    labs(x="Score on Q5",y="Score on Q7") +
    scale_color_discrete("Experimental Condition") +
    theme(
      legend.position = "bottom",
      legend.background = element_rect("#DFDFDF"))) %>%
  ggsave("../figs/fig5.png",., width = 7, height = 4, unit = "in")
#come back and see if I should change the width/height to match a certain ratio and make sure all the line numbers are correct