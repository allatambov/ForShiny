#############################################
### WORKING WITH DATAFRAMES: VERY BASICS ###
#############################################

# load data: by link or local file

link <- "https://raw.githubusercontent.com/allatambov/ForShiny/main/coffee_and_code.csv"
df <- read.csv(link)
df <- read.csv(file.choose())

# view data
View(df)

# structure and descriptives
str(df)
summary(df)

# reload data: factors instead of characters
# look at updated structure and summary
df <- read.csv(link, stringsAsFactors = TRUE)
str(df)
summary(df)

# describe one column
summary(df$CoffeeCupsPerDay)
table(df$CoffeeCupsPerDay)

# choosing columns
df$CodingWithoutCoffee

# change the order of levels (factor variable)
df$CodingWithoutCoffee <- factor(df$CodingWithoutCoffee, 
       levels = c("Yes", "Sometimes", "No"))

# choosing rows and columns by index
df[1, 10]
df[1, 8]
small <- df[, c(2, 4, 6)]
View(small)

# choosing columns by names
df[, "CodingHours"]

# filtering rows
df1 <- df[df$CodingHours > 4,]
View(df1)

df2 <- df[df$CodingHours > 4 & df$CoffeeType == "Nescafe",]
View(df2)

df3 <- df[df$CoffeeType == "Turkish" | 
            df$CoffeeType == "Nescafe",]
View(df3)

#############################################
################## FUNCTIONS ################
#############################################

my_power <- function(a, b){
  return(a ** b)
}

my_power(6, 2)

my_powers <- function(a, b){
  return(c(a ** b, b ** a))
}

my_powers(4, 5)

# prepare the function for comparing two groups
# (compare number of coffee cups) 
# filter rows for females and males
# check whether distribution in every group is normal
# if yes -> run Student t-test to compare
# if not -> run Wilcoxon test to compare

dat <- df
female <- dat[dat$Gender == "Female", ]
male <- dat[dat$Gender == "Male", ]

# run Shapiro-Wilk normality test
# extract p-values for every group
pvalue01 <- shapiro.test(female$CoffeeCupsPerDay)$p.value
pvalue02 <- shapiro.test(male$CoffeeCupsPerDay)$p.value

# if at least one p-value < 0.05 -> no normality -> Wilcoxon
# otherwise -> t-test

if (pvalue01 < 0.05 | pvalue02 < 0.05){
  p <- wilcox.test(dat$CoffeeCupsPerDay ~ dat$Gender)$p.value
} else{
  p <- t.test(dat$CoffeeCupsPerDay ~ dat$Gender)$p.value
}

# now we write a function
# takes filename (csv-file)
# returns p-value for the correct test 
# prints whether the result is sig. at 5% level

compare.groups <- function(filename){
  dat <- read.csv(filename)
  female <- dat[dat$Gender == "Female", ]
  male <- dat[dat$Gender == "Male", ]
  pvalue01 <- shapiro.test(female$CoffeeCupsPerDay)$p.value
  pvalue02 <- shapiro.test(male$CoffeeCupsPerDay)$p.value
  
  if (pvalue01 < 0.05 | pvalue02 < 0.05){
    p <- wilcox.test(dat$CoffeeCupsPerDay ~ dat$Gender)$p.value
  } else{
    p <- t.test(dat$CoffeeCupsPerDay ~ dat$Gender)$p.value
  }
  if (p < 0.05){
    print("Groups are different")
  } else{
    print("Groups are not different")
  }
  return(p)
}

# test this function
link <- "https://raw.githubusercontent.com/allatambov/ForShiny/main/coffee_and_code.csv"
compare.groups(link)
compare.groups("C:/Users/student/Desktop/coffee_and_code.csv")
