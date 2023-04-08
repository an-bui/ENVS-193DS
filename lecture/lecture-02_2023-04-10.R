##########################################################################-
# 0. set up ---------------------------------------------------------------
##########################################################################-

# cleaning
library(tidyverse)

# visualization
library(showtext)
font_add_google("Lato", "Lato")

##########################################################################-
# 1. descriptive statistics -----------------------------------------------
##########################################################################-

## a. central tendency ----------------------------------------------------

set.seed(1000)

betadist_right <- rbeta(10000,5,2) %>% 
  as_tibble(rownames = "x")

ggplot(betadist_right) +
  geom_histogram(aes(x = value), fill = "white", color = "black", bins = 20) +
  geom_vline(aes(xintercept = mean(value)), color = "red") +
  geom_vline(aes(xintercept = median(value)), color = "yellow") +
  geom_vline(xintercept = 0.785, color = "green") 

betadist_left <- rbeta(10000,2, 5) %>% 
  as_tibble(rownames = "x")

ggplot(betadist_left) +
  geom_histogram(aes(x = value), fill = "white", color = "black", bins = 20) +
  geom_vline(aes(xintercept = mean(value)), color = "red") +
  geom_vline(aes(xintercept = median(value)), color = "yellow") +
  geom_vline(xintercept = 0.235, color = "green") 

betadist_symm <- rbeta(10000,5, 5) %>% 
  as_tibble(rownames = "x")

ggplot(betadist_symm) +
  geom_histogram(aes(x = value), fill = "white", color = "black", bins = 20) +
  geom_vline(aes(xintercept = mean(value)), color = "red") +
  geom_vline(aes(xintercept = median(value)), color = "yellow") +
  geom_vline(xintercept = 0.5, color = "green") 

## b. data spread ---------------------------------------------------------

rbeta(50, 5, 5) %>% 
  as_tibble(rownames = "x") %>% 
  ggplot(aes(x = x, y = value)) +
  geom_point()

##########################################################################-
# 2. probability distributions --------------------------------------------
##########################################################################-
normdist <- rnorm(n = 1000, mean = 0, sd = 1) %>% 
  as_tibble(rownames = "x")

normdist <- rnorm(n = 1000, mean = 0, sd = 1) %>% 
  as_tibble(rownames = "x")

ggplot(normdist) +
  geom_histogram(aes(x = value, after_stat(density)), fill = "white", color = "black", bins = 100) +
  stat_function(fun = dnorm, args = list(mean = 0, sd = 1), color = "blue", linewidth = 1)

normdist <- rnorm(n = 100000, mean = 0, sd = 1) %>% 
  as_tibble(rownames = "x")

ggplot(normdist) +
  geom_histogram(aes(x = value, after_stat(density)), fill = "white", color = "black", bins = 100) +
  stat_function(fun = dnorm, args = list(mean = 0, sd = 1), color = "blue", linewidth = 1)




