library(data.table)
file <- "./data/household_power_consumption.txt"
data <- fread(file, sep=";", na.strings="?", skip=66636+1, nrows=2880)
setnames(data, as.character(fread(file, sep=";", nrows=1, header=F)))
data <- cbind(data[, 1:2, with=FALSE],
              data[, lapply(.SD[, c(-1, -2), with=FALSE], as.numeric)])

## plotting
png("plot1.png")
hist(data$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowats)")
dev.off()