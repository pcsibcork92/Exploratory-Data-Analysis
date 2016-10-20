library(lubridate)
setwd("C:/JHU/EDA")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempf, mode="wb")
unzip(tempf, "household_power_consumption.txt")
hpc1 <- read.csv(file="household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE)
unlink(tempf)
##Convert text into date format
hpc1[,1] <-lubridate::dmy(hpc1[,1])

##subset datasetfor proper date range
hpc2 <- subset(hpc1, Date >= "2007-02-01" & Date <= "2007-02-02")

## Convert columns 3 through 9 from text into numeric
for (i in 3:9){
  hpc2[,i] <- as.numeric(hpc2[,i])
}
##Reset the par() environment
 dev.off() 
 
## Create the plot and output it to a file 
  png('plot1.png')
  hist(hpc2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")
  dev.off()