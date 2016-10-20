## Create plot
library(lubridate)
library(dplyr)
setwd("C:/JHU/EDA")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempf, mode="wb")
unzip(tempf, "household_power_consumption.txt")
hpc1 <- as.data.frame(read.csv(file="household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE, na.strings = "?"))
unlink(tempf)

##Select columns to work with to preserve as much data as possible
hpc2 <- select(hpc1, -Global_intensity)

## Replace ? with NA as empty data place holder then remove all NA
hpc2 <- na.omit(hpc2)

## Create a new column that combines the date and time columns then convert it to date format  
hpc2[,9] <- NA
hpc2[,9] <- as.character(hpc2[,9])
names(hpc2)[9] <- "Timestamp"
hpc2[,9] <- paste(hpc2$Date, " ", hpc2$Time)





##Convert text into date format
hpc2[,9] <- lubridate::dmy_hms(hpc2[,9])
hpc2[,1] <- lubridate::dmy(hpc2[,1])
hpc3 <- hpc2

##subset datasetfor proper date range
hpc2 <- subset(hpc2, Date >= "2007-02-01" & Date <= "2007-02-02")

## Reset the par() environment
dev.off()

## Set the plot characteristics
par(mfrow=c(2, 2), mar=c(5,4,2,1))
## png('plot4.png')

## 1,1 - Global Active Power
with(hpc2, plot(Timestamp, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power") )

## 1,2 - Voltage plot
with(hpc2, plot(Timestamp, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

## 2,1 - submetering plot
with(hpc2, plot(Timestamp, Sub_metering_1, type ="l", xlab = "", ylab = "Energy Sub Metering"))
with(hpc2, lines(Timestamp, Sub_metering_2, type = "l", col = "green"))
with(hpc2, lines(Timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), bty="n", col=c("black","green","blue"), horiz=FALSE, cex = 0.5)

## 2,2 - Global Reactive Power
with(hpc2, plot(Timestamp, Global_reactive_power, type ="l", xlab = "datetime"))
dev.copy(png,'plot4.png')

dev.off()


