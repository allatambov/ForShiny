#######################################
##### PRACTICE: VISUALIZE DYNAMICS ####
#######################################

# set folder with files as a working directory
# write your path

path <- "D:/Downloads/archive/archive" # Windows (example)
path <- "/Users/allat/Desktop/archive" # Mac (example)
setwd(path)

# vector with file names in this folder
files <- list.files()
files

# take one - for example
f <- files[1]

# read csv-file
dat <- read.csv(f)
View(dat)

# filter rows and columns
# not 999.9 (missing values)
# only 1st and 4th column

march <- dat[dat$MAR != 999.9, c(1, 4)]

# save columns as vectors
years <- dat$YEAR
temp <- dat$MAR

# save number of years
nyears <- length(years)

# plot for dynamics
# YEAR vs TEMPERATURE

# p - points
# l - lines
# b - both
# o - both overlay
# pch - point type

plot(x = march$YEAR, 
     y = march$MAR, 
     "o", pch = 20,
     xlab = "Year",
     ylab = "Temperature (C)")

# add grid 
# number of vertical lines — number of years
# number of horizontal lines — 10

plot(x = march$YEAR, 
     y = march$MAR, 
     "o", pch = 20,
     xlab = "Year",
     ylab = "Temperature (C)")
grid(nx = nyears, ny = 10)

# get name for the graph from file name
name <- toupper(gsub("_" ," ", 
                     strsplit(f, "\\.")[[1]][1]))
name

# create name for png-file with graph
graph <- paste(name, ".png", sep = "")
graph

# create a plot and save as png-file,
# we want a grid to be under the graph

# step 1: open png-file
# plot an empty graph (cex = 0, points of size 0)
# and add grid
png(graph, width = 8, height = 4.5, res = 300, 
    units = "in")
plot(march$YEAR, march$MAR, 
     cex = 0,
     ann = FALSE,
     xaxt = "n")
grid(nx = nyears, ny = 10)

# step 2: plot a new graph on the grid above
# xaxt = "n" to switch-off x-axis,
# we create a new x-axis with axis()

par(new = TRUE)
plot(march$YEAR, march$MAR, 
     "o", pch = 20,
     xlab = "Year",
     ylab = "Temperature (C)", 
     main = name,
     xaxt = "n")
axis(1, at = min(years):max(years),
     las = 2)

# step 3: save and close png-file
dev.off()

#######################################
####### PRACTICE: MULTIPLE FILES ######
#######################################

# set path to the folder with csv-files
# MOVE/DELETE png-files if created

path <- "/Users/allat/Desktop/archive"
setwd(path)

# names of files
files <- list.files()
files

# for-loop: open every csv-file and create a graph
for (f in files){
    
    # read data and prepare
    
    dat <- read.csv(f)
    march <- dat[dat$MAR != 999.9, c(1, 4)]
    years <- dat$YEAR
    temp <- dat$MAR
    nyears <- length(years)
    name <- toupper(gsub("_" ," ", 
                         strsplit(f, "\\.")[[1]][1]))
    
    # graph: name of file like STATION RIO.png
    # path_graph: save graph to the different folder
    # merge this path with the file name
    
    graph <- paste(name, ".png", sep = "")
    path_graph <- paste("/Users/allat/Downloads", 
                        graph, sep = "/")
    
    # code we have written before
    
    png(path_graph, width = 8, height = 4.5, res = 300, 
        units = "in")
    plot(march$YEAR, march$MAR, 
         cex = 0, ann = FALSE,
         xaxt = "n")
    grid(nx = nyears, ny = 10)
    
    par(new = TRUE)
    plot(march$YEAR, march$MAR, 
         "o", pch = 20,
         xlab = "Year",
         ylab = "Temperature (C)", 
         main = name,
         xaxt = "n")
    axis(1, at = min(years):max(years),
         las = 2)
    dev.off()
} 


