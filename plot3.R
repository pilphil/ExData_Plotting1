getwd()

# Get the data
if (!file.exists("./household_power_consumption.txt")) {
  #get the zip file
  filename <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(filename, "./datafile.zip", method="curl", mode="wb")
  #unzip it
  unzip("./datafile.zip")
}

# Load the required data into a dataframe
library(data.table)
# Read the rows corresponding to 01/02/2007 and 02/02/2007 into a dataframe
datafile <- "./household_power_consumption.txt"
data <- fread("grep ^[12]/2/2007 ./household_power_consumption.txt",na.strings=c("?", ""))
setnames(data, colnames(fread(datafile, nrows=0)))

#Combining the date and time columns to create a datetime column
x <- paste(data$Date, data$Time)
newx <- strptime(x, "%d/%m/%Y %H:%M:%S")
newdata <- cbind(data, newx)

# Create the plot
g_range <- range(0, newdata$Sub_metering_1, newdata$Sub_metering_2, newdata$Sub_metering_3)
png(filename="plot3.png", width=480, height = 480, units = "px")
plot(newdata$newx, newdata$Sub_metering_1, type="l", xlab="", ylim=g_range, col="black", ylab="Energy sub metering")
lines(newdata$newx, newdata$Sub_metering_2, type="l", xlab="", ylim=g_range, col="red")
lines(newdata$newx, newdata$Sub_metering_3, type="l", xlab="", ylim=g_range, col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), pch="", lwd= 1)
dev.off()






