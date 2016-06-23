## Plot1.R
## This script reads and pre-process the data to generate
## plot 1 in the Course Projecto for week 1 of the 
## Exploratory Data Analysis course
##
## Author: Víctor Hugo Zaldívar-Carrillo
## Date: june 2016
##

## Part 1: getting and unziping the file

fileurl= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Setting the directory to store the downloaded file

setwd("~")
if (!file.exists("./powerData")) {
  dir.create("./powerData")
}

setwd("./powerData")

## downloading the file in the correct directory

download.file(fileurl, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip",exdir=".")

## Read the file into a data table 
  
 mydata= read.table("household_power_consumption.txt", 
                    sep=";", 
                    na.strings='?',
                    
                    header=TRUE,
                    fill=FALSE, 
                    strip.white=TRUE)
 
 
 ## Part 2: Pre-processing the data
 
 ## subset the data table to extract only the two days we are interested in
 
 mydf <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007")
 ## remove the big data table to save memory
 rm(mydata)

 ## load the packages we will use to manipulate the data table
 ## we will use mutate() from the dplyr package to change the columns in the
 ## data set
 ## then we will use lubridate to convert the content to POSIX date format
 
  
 library(lubridate)
 library(dplyr)
 ## we create a new column "DayTime" to store the day and the hour of the sample taken
 ## we need to use "as.character()" because these two columns were read as factor variables
 
 mydf <- mutate(mydf, DayTime = paste(as.character(mydf$Date), as.character(mydf$Time)))
 
 ## we use lubridate functions to convert the string into a date
 mydf <- mutate(mydf, DayTime=dmy_hms(DayTime))
 
## defining the plot
 
 ## we create the graphics device in a png file with the
 ## specified height and width
 
 png(filename="Plot1.png", height=480, width=480, bg="white")
 
 hist(mydf$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
      main = "Global Active Power")
 
 
 ## Don't forget to close the graphics devie
 dev.off()
 
 
 
 



 
 