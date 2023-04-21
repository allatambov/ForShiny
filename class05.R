### INSTALLING PACKAGES ###

install.packages("tidyverse")
install.packages("readxl")

### LOADING PACKAGES ###

library(tidyverse)
library(readxl)

### LOADING DATA FROM EXCEL ### 

dat <- read_excel("data.xls")

### PLOTTING HISTOGRAMS ###

# simple histogram for X10
ggplot(data = dat, aes(x = X10)) + geom_histogram()

# look at the obvious outlier
dat %>% filter(X10 > 10000) %>% select(REG)

# set binwidth to 500
# change fill color and border color
# set black-white theme
# set labels for axes and title (\n: line break)

ggplot(data = dat, aes(x = X10)) + 
  geom_histogram(binwidth = 500, 
                 fill = "darkblue", 
                 color = "white") + 
  theme_bw() +
  labs(x = "стоимость в октябре 2020",
       y = "количество регионов",
       title = "Стоимость минимального набора \nпродуктов питания")

# add vertical lines for the mean and the median
ggplot(data = dat, aes(x = X10)) + 
  geom_histogram(binwidth = 500, fill = "darkblue", 
                 color = "white") + theme_bw() +
  labs(x = "стоимость в октябре 2020",
       y = "количество регионов",
       title = "Стоимость минимального набора \nпродуктов питания") +
  geom_vline(xintercept = mean(dat$X10), lty = 2, color = "red") + 
  geom_vline(xintercept = median(dat$X10), lty = 2, color = "darkorange")


### PLOTTING DENSITY PLOTS ###

# options: to avoid e-notation in small numbers
options(scipen = 999)
ggplot(data = dat, aes(x = X10)) + geom_density(fill = "orangered")

### GRAPHS BY GROUPS ###

unique(dat$OKR)

# choosing three okrugs
regions <- c("Центральный федеральный округ", 
             "Приволжский федеральный округ", 
             "Сибирский федеральный округ")

three <- dat %>% filter(OKR %in% regions)

# three histograms in the same graph
# group: for grouping
# fill: for coloring groups
# alpha: 50% transparent

ggplot(data = three, 
       aes(x = X10, 
           group = OKR, 
           fill = OKR)) + 
  geom_histogram(binwidth = 500, alpha = 0.5) +
  theme_bw()

# better: density plots instead of histograms
# set new colors and labels + title for the legend
ggplot(data = three, 
       aes(x = X10, 
           group = OKR, 
           fill = OKR)) + 
  geom_density(alpha = 0.7) +
  theme_bw() + 
  scale_fill_manual(name = "Округ", 
                    values = c("violet", "yellow", "lightblue"),
                    labels = c("Приволжский ФО",
                               "Сибирский ФО",
                               "Центральный ФО"))

# one more variant: graphs in different facets (windows)
ggplot(data = three, aes(x = X10, fill = OKR)) +
  geom_histogram(binwidth = 500) + 
  facet_wrap(~OKR)

# new labels (old are too long)
# as a named vector with pairs old name-new name
labels <- c("Приволжский федеральный округ" = "Приволжский", 
            "Сибирский федеральный округ" = "Сибирский", 
            "Центральный федеральный округ" = "Центральный")

# put new labels into labeller
ggplot(data = three, aes(x = X10, fill = OKR)) +
  geom_histogram(binwidth = 500) + 
  facet_wrap(~OKR, labeller = as_labeller(labels))

### PLOTTING LINE GRAPH ###

# read data within okrugs, the 2nd sheet
okrs <- read_excel("data.xls", sheet = 2)

# again choose three okrugs
o_three <- okrs %>% filter(OKR %in% regions)

# line plot for dynamics: months vs prices
ggplot(data = o_three, aes(x = mon, 
                           y = price, 
                           group = OKR,
                           color = OKR)) + 
  geom_line(aes(linetype = OKR)) + 
  theme_bw()

