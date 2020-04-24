# Plot2.R 
#
# JHU Data Science Course on Coursera - Exploratory Data Analysis
# Week 1 Assignment
#
# Dataset used for this assignment was downloaded from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzipped in a directory named ./data
#

library(dplyr)
library(lubridate)

# Assumption: Load data that was downloaded to data dir and unzipped

allData <- data.table::fread("../data/household_power_consumption.txt", header = TRUE)

# Convert Date variable, select rows with dates from 01/02/2007 and 02/02/2007, and combine Date and Time to
# a new variable DateTime. Convert DateTime to POSIXlt, POSIXt

allData$Date <- as.Date(allData$Date, "%d/%m/%Y")

workData <- filter(allData, Date == "2007-02-01" | Date == "2007-02-02")
workData <- mutate(workData, DateTime = paste(workData$Date, workData$Time))
workData$DateTime <- strptime(workData$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Generating the plot and saving it

png(filename = "Plot2.png")
with(workData, {
        plot(DateTime, Global_active_power, 
             xlab = "", 
             ylab = "Global active power (kilowatts)", 
             type = "l")
})

dev.off()


