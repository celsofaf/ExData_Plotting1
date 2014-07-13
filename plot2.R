library(data.table)
file <- "./data/household_power_consumption.txt"
data <- fread(file, sep=";", na.strings="?", skip=66636+1, nrows=2880)
setnames(data, as.character(fread(file, sep=";", nrows=1, header=F)))
data <- cbind(data[, 1:2, with=FALSE],
              data[, lapply(.SD[, c(-1, -2), with=FALSE], as.numeric)])

## plotting
png("plot2.png")
plot(data$Global_active_power, type="l", xaxt="n", xlab="", 
     ylab="Global Active Power (kilowats)")
axis(1, at=c(1, 1441, 2881), labels=c("Thu", "Fri", "Sat"))
dev.off()