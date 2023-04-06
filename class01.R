######################################
############## VECTORS ###############
######################################

v1 <- c(3, 6, 8, 9)
v1

v1 = c(3, 6, 8, 9)
v1

v2 <- c(3, 6.6, 8, 9)
v2

v3 <- c("2,5", "3", 8, 9)
v3

# class vs type
class(v1); typeof(v1)
class(v2); typeof(v2)
class(v3); typeof(v3)

# converting types
v4 <- as.integer(v1)
v4
class(v4); typeof(v4)

v5 <- as.character(v1)
v5

# choosing elements
long <- c(1, 9, 8, 4, 1, 9, 8, 5)
long[1]
long[0]
length(long)
long[length(long)]

long[2:4]
long[2:]
long[2:length(long)]
long[2:9]
long[2:10]
long[c(2, 5, 8)]
long[c(2, 5:8)]
long[c(2, 5, 1:6)]

long[-1]
long[-2]
long[-2:length(long)]
long[-2:0]
long[-2:-4]

# merging vectors
c(3, 7, 8) + c(1, 2, 0)
c(3, 7, 8) + c(1, 2)
c(3, 7, 8, 10) + c(1, 2)
c(c(3, 7, 8), c(1, 2))

# sequences
1:10
25:40
seq(1, 20, 2)
seq(10, 15, 0.5)
seq(1, 20, length.out = 10)
rep("A", 3)
rep(NA, 10)
rep(c("red", "blue"), 4)
rep(c("red", "blue"), each = 4)

# built-in vectors
letters
LETTERS
month.name
month.abb
colors()
colors()[1:20]

# working with dates
dates <- ISOdate(2023, 1:12, 1)
dates
class(dates)
ISOdate(2023, 1:12, 2)
ISOdate(2023, 1:12, 31)
ISOdate(2023, 1:12, c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))

dates
format(dates, "%D")
format(dates, "Date is %D")
format(dates, "%d %B %Y")
format(dates, "%d %B %y")
format(dates, "%d %b %y")
format(dates, "%d %B %Y (%A)")
format(dates, "%d %B %Y (%a)")
format(dates, "%d %B %Y %H:%M:%S")

# merging texts and character vectors
paste("A", "B", "C")
paste("A", "B", "C", sep = "-")
paste("группа", 221:224)
paste("группа", 221:224, sep = "_")
parts <- c("01", "03", "2023")
paste(parts, collapse = "/")

######################################
############## MATRICES ##############
######################################

M <- matrix(10:21, nrow = 4)
M

matrix(10:21, nrow = 4, byrow = TRUE)

# adding rownames and colnames
rownames(M) <- month.abb[1:4]
M

colnames(M) <- c("Nif-Nif", "Naf-Naf", "Nuf-Nuf")
M

# choosing elements
M[1, 3]
M[3, 1]
M[c(2, 4), 3]
M[1, 2:3]

# operations with columns and rows
colSums(M)
rowSums(M)

colMeans(M)
rowMeans(M)

apply(M, 1, sum)
apply(M, 2, sum)
apply(M, 2, min)
apply(M, 2, var)
apply(M, 2, sd)

apply(M, 1, function(x){x / sum(x) * 100})
apply(M, 2, function(x){x / sum(x) * 100})

######################################
############## LISTS #################
######################################

pairs <- list("Да" = "yes", "Нет" = "no", "Нет ответа" = NA)
pairs

L <- list(data = "students", 
          names = c("Elaine", "Cassandra", "Harry"), 
          marks = c(6, 8, 9))
L

# choosing elements
pairs$Да
pairs$`Нет ответа`

pairs[1]
pairs[[1]]

class(pairs[1])
class(pairs[[1]])

L$names[1]
L[[2]][1]
