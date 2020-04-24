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

png(filename = "Plot4.png")

par(mfrow = c(2,2))

with(workData, {
        plot(DateTime, Global_active_power, 
             xlab = "", 
             ylab = "Global active power (kilowatts)", 
             type = "l")
        
        plot(DateTime, Voltage, 
             type = "l")
        
        plot(DateTime, Sub_metering_1, 
             xlab = "", 
             ylab = "Energy sub metering", 
             type = "l")
        lines(workData$DateTime, workData$Sub_metering_2, col = "red", type = "l")
        lines(workData$DateTime, workData$Sub_metering_3, col = "blue", type = "l")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), lty = 1:1)
        
        plot(DateTime, Global_reactive_power, 
             type = "l")
})

dev.off()


