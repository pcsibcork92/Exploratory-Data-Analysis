library(lubridate)
library(dplyr)
setwd("C:/JHU/EDA")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempf, mode="wb")
unzip(tempf, "household_power_consumption.txt")
hpc1 <- as.data.frame(read.csv(file="household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE, na.strings = "?"))
unlink(tempf)
##Select only the first 3columns for Plot 2
hpc2 <- select(hpc1, 1:2, 7:9)

## Replace ? with NA as empty data place holder then remove all NA
hpc3 <- hpc2
hpc2 <- na.omit(hpc2)

## Create a new column that combines the date and time columns then convert it to date format  
hpc2[,6] <- NA
hpc2[,6] <- as.character(hpc2[,6])
names(hpc2)[6] <- "Timestamp"
hpc2[,6] <- paste(hpc2$Date, " ", hpc2$Time)





##Convert text into date format
hpc2[,6] <- lubridate::dmy_hms(hpc2[,6])
hpc2[,1] <- lubridate::dmy(hpc2[,1])
hpc3 <- hpc2

##subset datasetfor proper date range
hpc2 <- subset(hpc2, Date >= "2007-02-01" & Date <= "2007-02-02")

## Reset the par() environment
dev.off()

## Create plot
png('plot3.png')
with(hpc2, plot(Timestamp, Sub_metering_1, type ="l", xlab = "", ylab = "Energy Sub Metering"))
with(hpc2, lines(Timestamp, Sub_metering_2, type = "l", col = "green"))
with(hpc2, lines(Timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","green","blue"), horiz=FALSE)
dev.off()




