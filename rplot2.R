library(lubridate)
library(dplyr)
setwd("C:/JHU/EDA")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempf, mode="wb")
unzip(tempf, "household_power_consumption.txt")
hpc1 <- as.data.frame(read.csv(file="household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE))
unlink(tempf)
##Select only the first 3columns for Plot 2
hpc2 <- select(hpc1, 1:3)

## Replace ? with NA as empty data place holder then remove all NA
hpc3 <- hpc2
is.na(hpc2[,3]) <- which(hpc2[,3] == "?")
hpc2 <- na.omit(hpc2)

## Create a new column that combines the date and time columns then convert it to date format  
hpc2[,4] <- NA
hpc2[,4] <- as.character(hpc2[,4])
names(hpc2)[4] <- "Timestamp"
hpc2[,4] <- paste(hpc2$Date, " ", hpc2$Time)





##Convert text into date format
hpc2[,4] <- lubridate::dmy_hms(hpc2[,4])
hpc2[,1] <- lubridate::dmy(hpc2[,1])
hpc3 <- hpc2

##subset datasetfor proper date range
hpc2 <- subset(hpc2, Date >= "2007-02-01" & Date <= "2007-02-02")

## Reset the par() environment
dev.off()

## Create plot
png('plot2.png')
with(hpc2, plot(Timestamp, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowats)"))
dev.off()
