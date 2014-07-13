library(data.table)
file <- "./data/household_power_consumption.txt"
data <- fread(file, sep=";", na.strings="?", skip=66636+1, nrows=2880)
setnames(data, as.character(fread(file, sep=";", nrows=1, header=F)))
data <- cbind(data[, 1:2, with=FALSE],
              data[, lapply(.SD[, c(-1, -2), with=FALSE], as.numeric)])

## plotting
png("plot3.png")
plot(data$Sub_metering_1, type="l", xaxt="n", xlab="",
     ylab="Energy sub metering")
lines(data$Sub_metering_2, type="l", col="red")
lines(data$Sub_metering_3, type="l", col="blue")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))
legend("topright", pch="_", col=c("black", "blue", "red"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()