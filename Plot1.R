library(dplyr)
library(lubridate)

# Assumption: Load data that was downloaded to data dir and unzipped

allData <- data.table::fread("../data/household_power_consumption.txt", header = TRUE)

# Convert Date and Time variables and select rows with dates from 01/02/2007 and 02/02/2007

allData$Date <- as.Date(allData$Date, "%d/%m/%Y")

workData <- filter(allData, Date == "2007-02-01" | Date == "2007-02-02")

# Generating the plot and saving it

png(filename = "Plot1.png")
hist(as.numeric(workData$Global_active_power), col = "red", main = "Global Active Power",
xlab = "Global active Power (kilowatts)",
ylab = "Frequency")
dev.off()


