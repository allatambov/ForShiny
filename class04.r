# load data
cpi <- read.csv("https://raw.githubusercontent.com/allatambov/ForShiny/main/CPI2019.csv",
                sep = ";")

# install and load package
install.packages("tidyverse")
library(tidyverse)

# pipe operator %>% and chaining operations 
cpi %>% View
cpi %>% head(10)
cpi %>% head(10) %>% View

# selecting columns
cpi %>% select(country) %>% head
cpi %>% dplyr::select(country) %>% head
cpi %>% select(country, cpi_rank) %>% head
cpi %>% select(country: cpi_rank) %>% head
small <- cpi %>% select(-iso3)
small2 <- cpi %>% select(-c(iso3, region))

# filtering rows
cpi2 <- cpi %>% filter(cpi_score > 80)
cpi2

cpi %>% filter(cpi_score > 80 & region == "WE/EU")
cpi %>% filter(cpi_score > 80, region == "WE/EU")
cpi %>% filter(region == "ECA" | region == "WE/EU")
cpi %>% filter(region %in% c("ECA", "WE/EU"))
cpi %>% filter(str_detect(country, "Guinea"))
cpi %>% select(starts_with("cpi")) %>% View
cpi %>% select(ends_with("score")) %>% View
cpi %>% select(contains("n_"))

# adding columns
cpi <- cpi %>% mutate(cpi_perc = cpi_score / 100)
cpi %>% mutate(cpi_perc = cpi_score / 100) -> cpi

cpi <- cpi %>% mutate(cpi_perc = cpi_score / 100, 
               eu = ifelse(region == "WE/EU", 1, 0))
cpi <- cpi %>% 
  add_column(asia = ifelse(cpi$region %in% c("AP", "ECA"), 1, 0),
             .before = "eu")

# adding rows
cpi <- cpi %>% add_row(country = "Luxembourg", iso3 = "LUX", 
                region = "WE/EU", cpi_score = 80, cpi_rank = 9,
                n_sources = NA, eu = 1, asia = 0, .after = 3)

# sorting rows
cpi <- cpi %>% arrange(country)
cpi %>% arrange(desc(cpi_rank)) %>% View
cpi %>% arrange(cpi_score, country) %>% View
cpi %>% top_n(10, cpi_score)

# grouping and aggregating
cpi %>% group_by(region) %>% tally
cpi %>% group_by(region) %>% summarise(N = n(),
                                       `Mean CPI` = mean(cpi_score),
                                       `St Dev CPI` = sd(cpi_score)) %>%
  mutate(CV = `St Dev CPI` / `Mean CPI`)

# export files by groups
cpi %>% group_by(region) %>%
  group_walk(~write_csv(.x, 
                        paste0(str_replace(.y$region, "/", "_"), 
                               ".csv")))

# export tables with stargazer
install.packages("stargazer")
library(stargazer)

stargazer(cpi, type = "html", out = "summary.htm")
?stargazer

stargazer(cpi, type = "html", 
          out = "summary.htm", 
          title = "CPI Score 2019",
          notes = "Index by Transparency International",
          median = TRUE)

desc <- cpi %>% group_by(region) %>% summarise(N = n(),
                                       `Mean CPI` = round(mean(cpi_score), 2),
                                       `St Dev CPI` = round(sd(cpi_score), 2))

stargazer(desc, type = "html", out = "group.htm", 
          summary = FALSE)


