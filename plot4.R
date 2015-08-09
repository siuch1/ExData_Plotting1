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

## Plot 4
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(d0$DateTime, d0$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(d0$DateTime,d0$Sub_metering_1,type="l",col="black", xlab="", ylab="Energy submetering")
lines(d0$DateTime,d0$Sub_metering_2,type="l",col="red")
lines(d0$DateTime,d0$Sub_metering_3,type="l",col="blue")
legend("topright", pch=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

d0$Voltage <- as.numeric(d0$Voltage)
plot(d0$DateTime, d0$Voltage, type='l', col="black", xlab="datetime", ylab = "Voltage")

d0$Global_reactive_power <- as.numeric(d0$Global_reactive_power)
plot(d0$DateTime, d0$Global_reactive_power, type='l', col="black", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png")
dev.off()
