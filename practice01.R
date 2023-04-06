##############################################
################ PREPARE DATA ################
##############################################

sample(1:10, 3)
sample(1:5, 10, replace = TRUE)
answer01 <- sample(c("Да", "Нет", "Нет ответа"), 200, 
                   replace = TRUE, prob = c(0.4, 0.5, 0.1))
answer01

answer02 <- sample(c("Да", "Нет", "Нет ответа"), 200, 
                   replace = TRUE, prob = c(0.68, 0.22, 0.1))
answer03 <- sample(c("Да", "Нет", "Нет ответа"), 200, 
                   replace = TRUE, prob = c(0.5, 0.35, 0.15))
answer04 <- sample(c("Да", "Нет", "Нет ответа"), 200, 
                   replace = TRUE, prob = c(0.5, 0.4, 0.1))

dat <- cbind.data.frame(answer01, answer02, answer03, answer04)
head(dat)

colnames(dat) <- c("январь 2020", "январь 2021", 
                   "январь 2022", "январь 2023")
View(dat)

##############################################
################ CREATE BARPLOT ##############
##############################################

# create table with frequencies
table(dat$`январь 2020`)
counts <- cbind(table(dat$`январь 2020`), 
                table(dat$`январь 2021`),
                table(dat$`январь 2022`), 
                table(dat$`январь 2023`))
counts

colnames(counts) <- colnames(dat)
counts

# create barplot
barplot(counts, 
        beside=TRUE, 
        col=c(), 
        border="white",
        xlab="R хороший?", 
        ylab = "Число ответов", 
        font.lab = 1,
        font.axis = 2,
        legend = rownames(counts))

# save barplot
png("Bar.png", width = 9, height = 4, units = 'in', res = 300)
barplot(counts, 
        beside=TRUE, 
        col=c(), 
        border="white",
        xlab="R хороший?", 
        ylab = "Число ответов", 
        font.lab=1,
        font.axis=2,
        legend = rownames(counts),
        args.legend = list(x = 15, 
                           y = 178,
                           cex = 0.6, 
                           horiz = TRUE))
dev.off()

# find png-file
getwd()
utils::browseURL(getwd())

##############################################
################ DESIGN BARPLOT ##############
##############################################

# add labels to every column
bar <- barplot(counts, 
               beside=TRUE, 
               col=c(), 
               border="white",
               xlab="R хороший?", 
               ylab = "Число ответов", 
               font.lab=1,
               font.axis=2,
               legend = rownames(counts),
               args.legend = list(x = 15, 
                                  y = 178,
                                  cex = 0.6, 
                                  horiz = TRUE))
bar

xpos <- as.vector(bar)
xpos

ypos <- as.vector(counts)
ypos

labels <- LETTERS[1:12]
labels

barplot(counts, 
        beside=TRUE, 
        col=c(), 
        border="white",
        xlab="R хороший?", 
        ylab = "Число ответов", 
        font.lab = 1,
        font.axis = 2,
        legend = rownames(counts),
        args.legend = list(x = 15, 
                           y = 178,
                           cex = 0.6, 
                           horiz = TRUE))
text(labels, x = xpos, y = ypos, cex = 0.6)

# change labels to percentages
count_perc <- apply(counts, 2, function(x){x /sum(x) * 100})
count_perc

perc <- round(as.vector(round(count_perc)))
perc

labels <- paste(perc, "%", sep = "")
labels

png("Bar02.png", width = 9, height = 4, units = 'in', res = 300)
bar <- barplot(counts, 
               beside=TRUE, 
               col=c(), 
               border="white",
               xlab="R хороший?", 
               ylab = "Число ответов", 
               font.lab=1,
               font.axis=2,
               legend = rownames(counts),
               args.legend = list(x = 15, 
                                  y = 178,
                                  cex = 0.6, 
                                  horiz = TRUE))

text(labels, x = xpos, y = ypos - 5, cex = 0.6, font = 2)
dev.off()

# change colors of labels
png("Bar03.png", width = 9, height = 4, units = 'in', res = 300)
bar <- barplot(counts, 
               beside=TRUE, 
               col=c(), 
               border="white",
               xlab="R хороший?", 
               ylab = "Число ответов", 
               font.lab=1,
               font.axis=2,
               legend = rownames(counts),
               args.legend = list(x = 15, 
                                  y = 178,
                                  cex = 0.6, 
                                  horiz = TRUE))

my.colors <- rep(c("gray90", "gray20", "black"), 4)
text(labels, x = xpos, y = ypos - 5, cex = 0.6, font = 2, 
     col = my.colors)
dev.off()

