rm(list=ls())

## Download and unzip file to data0
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
data0 <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, stringsAsFactors=FALSE)
unlink(temp)

## Processing data0
d0 <- subset(data0, Date=="1/2/2007" | Date=="2/2/2007")
d0$Global_active_power <- as.numeric(d0$Global_active_power)
d0$Date <- as.Date(as.character(d0$Date),"%d/%m/%Y")
d0$sDateTime <- paste(d0$Date, d0$Time, sep= " ")
d0$DateTime <- strptime(d0$sDateTime, "%Y-%m-%d %H:%M:%S")
d0$Sub_metering_1 <- as.numeric(d0$Sub_metering_1)
d0$Sub_metering_2 <- as.numeric(d0$Sub_metering_2)
d0$Sub_metering_3 <- as.numeric(d0$Sub_metering_3)

## Plot 1
par(mfcol=c(1,1))
hist(d0$Global_active_power, main = "Global Active Power", col = "red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
