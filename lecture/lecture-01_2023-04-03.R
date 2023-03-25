
##########################################################################-
# 0. set up ---------------------------------------------------------------
##########################################################################-

# cleaning
library(tidyverse)

# visualization
library(showtext)
font_add_google("Lato", "Lato")

##########################################################################-
# 1. anemone regression example -------------------------------------------
##########################################################################-

# number of anemones in a clump
clump <- seq(from = 1, to = 60, by = 1)

# circumference: anemones can be up to 8 cm long
set.seed(10)
circ <- rnorm(length(clump), mean = seq(from = 1, to = 5, length = length(clump)), sd = 1) 

# create a data frame
df <- cbind(circ, clump) %>% 
  as.data.frame() 

# linear model
lm(circ ~ clump, data = df) %>% summary()

showtext_auto()
ggplot(df, aes(x = clump, y = circ)) +
  geom_point(size = 2) +
  # just using geom smooth for the purposes of visualization
  geom_smooth(method = "lm", se = FALSE, linewidth = 2) +
  labs(x = "Number of anemones in a colony", y = "Circumference (cm)") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 18),
        text = element_text(family = "Lato"))

##########################################################################-
# 2. histogram example ----------------------------------------------------
##########################################################################-

ggplot(df, aes(x = circ)) +
  scale_x_continuous(breaks = seq(from = 0, to = 7, by = 1)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 19), breaks = seq(from = 0, to = 18, by = 3)) +
  geom_histogram(breaks = seq(from = 0, to = 7, by = 1), color = "#000000", fill = "lightblue") +
  labs(x = "Anemone circumference (cm)", y = "Count") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 18),
        text = element_text(family = "Lato")) 

##########################################################################-
# 3. probability mass example ---------------------------------------------
##########################################################################-

ggplot(data.frame(x = 1:55), aes(x)) +
  stat_function(geom = "bar", n = 55, fun = dpois, args = list(lambda = 10), fill = "coral") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.13)) +
  coord_cartesian(xlim = c(0, 22)) +
  labs(x = "Mussel clump size (count)", y = "Probability mass") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 18),
        text = element_text(family = "Lato")) 

##########################################################################-
# 4. probability density example ------------------------------------------
##########################################################################-

ggplot(data.frame(x = 1:20), aes(x)) +
  stat_function(geom = "line", n = 100, fun = dnorm, args = list(mean = 10, sd = 2), linewidth = 1) +
  stat_function(geom = "area", fun = dnorm, args = list(mean = 10, sd = 2), xlim = c(12, 14), fill = "turquoise3") +
  geom_vline(xintercept = 12, lty = 2, color = "grey", linewidth = 1) +
  geom_vline(xintercept = 14, lty = 2, color = "grey", linewidth = 1) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.22)) +
  # coord_cartesian(xlim = c(0, 22)) +
  labs(x = "Individual mussel weight (g)", y = "Probability density") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 18),
        text = element_text(family = "Lato")) 
  
showtext_auto(FALSE)
  
  
  
  
