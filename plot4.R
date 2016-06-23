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
 
 ## For plot4 we define the graphics device to have 2 rows and two columns
 
 
 
 
 png(filename="Plot4.png", height=480, width=480, bg="white")
 
 par(mfrow= c(2,2))
 
 ## Gemerate first plot for Gobal Active Power
 
 with(mydf, plot(DayTime,Global_active_power, type="l", ylab= "Global Active Power",
                 xlab=""))
 
 ## Gemerate second plot for Voltage
 
 with(mydf, plot(DayTime,Voltage, type="l", ylab= "Voltager",
                 xlab="datetime"))
 
 ## Adding plot 3 to the canvas
 
 with(mydf, plot(DayTime,Sub_metering_1, type="l", ylab= "Energy Sub metering",
                 xlab=""))
 
 ## Add Sub_metering_2
 lines(mydf$DayTime,mydf$Sub_metering_2, type = "l", col="red")
 
 ## Add Sub_metering_3
 lines(mydf$DayTime,mydf$Sub_metering_3,col="blue")
 
 ## Add the legend
 legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("black","red","blue"),
        lty=1)
 
 ## Adding plot4.... 
 
 ## actually i didn't understand what kind of plot it was 
 
 
 ## Don't forget to close the graphics devie
 dev.off()
 
 
 
 



 
 