library(data.table)
file <- "./data/household_power_consumption/household_power_consumption.txt"
## data <- readLines(file, n=2)  # some inspection
## data
## data <- readLines(file, n=6841)  # some inspection
## data[c(1, 6841)]
data <- fread(file, sep=";", na.strings="?", skip=66636+1, nrows=2880)
setnames(data, as.character(fread(file, sep=";", nrows=1, header=F)))
str(data)
data <- cbind(data[, 1:2, with=FALSE],
              data[, lapply(.SD[, c(-1, -2), with=FALSE], as.numeric)])
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- data[year(Date) == 2007 & month(Date) == 2 & mday(Date) %in% c(1, 2), ]
data$Datetime <- paste(data$Date, data$Time)
str(data)
head(data)

## plot 1
hist(data$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowats)")

## plot 2
plot(data$Global_active_power, type="l", xaxt="n", xlab="", 
     ylab="Global Active Power (kilowats)")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))

## plot 3 - consertar a legenda; o traço pode/deve ser maior
plot(data$Sub_metering_1, type="l", xaxt="n", xlab="",
     ylab="Energy sub metering")
lines(data$Sub_metering_2, type="l", col="red")
lines(data$Sub_metering_3, type="l", col="blue")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))
legend("topright", pch="_", col=c("black", "blue", "red"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## plot 4 - os da 1a coluna são os plot 2 e 3
par(mfcol=c(2, 2))

plot(data$Global_active_power, type="l", xaxt="n", xlab="", 
     ylab="Global Active Power (kilowats)")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))

plot(data$Sub_metering_1, type="l", xaxt="n", xlab="",
     ylab="Energy sub metering")
lines(data$Sub_metering_2, type="l", col="red")
lines(data$Sub_metering_3, type="l", col="blue")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))
legend("topright", pch="_", col=c("black", "blue", "red"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Voltage, type="l", xaxt="n", xlab="datetime", ylab="Voltage")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))

plot(data$Global_reactive_power, type="l", xaxt="n", xlab="datetime",
     ylab="Global_reactive_power")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))