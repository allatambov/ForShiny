#######################################
############### IF-ELSE ###############
#######################################

# standard if-else
# and else if (like elif)

mark <- 7
if (mark < 10){
  print("Malo")
} else {
  print("OK")
}

mark <- 12
if (mark < 10){
  print("Malo")
} else if (mark > 10){
  print("Stranno")
} else {
  print("OK")
}

if (mark >= 8 & mark <= 10){
  print("Отлично")
} 
if (mark >= 6 & mark < 8){
  print("Хорошо")
}
if (mark >= 4 & mark < 6){
  print("Удовлетворительно")
}
if (mark < 4 & mark >= 0){
  print("Плохо")
}
if (mark > 10){
  print("Странно...")
}

# if-else for vectors
answers <- c("yes", "no", "no", "yes")
ifelse(answers == "yes", 1, 0)

v <- c(-0.6, 0.1, 0.5, 0.8, 2, 3)
ifelse(v > 1 | v < 0, "invalid", "valid")

#######################################
############### FOR-LOOP ##############
#######################################

# vectorized operations
# no need for a for-loop in simple cases

v ** 2
x <- c(0, 3, 6)
p <- c(0.2, 0.5, 0.3)
sum(x * p)

# for-loop
# working with file names

files <- c("France.csv", 
           "Spain.csv", 
           "Slovenia.csv", 
           "Brazil.csv")

for (f in files){
  print(f)
}

# delete .csv and make country names uppercase
f <- files[1]
name <- toupper(strsplit(f, "\\.")[[1]][1])
name

# \\: from regular expressions
# something@mail.ru
# [a-z]+@[a-z]\\.[a-z]

# apply this operation for every country
for (f in files){
  name <- toupper(strsplit(f, "\\.")[[1]][1])
  print(name)
}
