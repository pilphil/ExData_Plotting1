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
datafile <- "household_power_consumption.txt"
data <- fread("grep ^[12]/2/2007 household_power_consumption.txt",na.strings=c("?", ""))
setnames(data, colnames(fread(datafile, nrows=0)))

#Combining the date and time columns to create a datetime column
x <- paste(data$Date, data$Time)
newx <- strptime(x, "%d/%m/%Y %H:%M:%S")
newdata <- cbind(data, newx)

# Create a histogram
png(filename="plot1.png", width=480, height = 480, units = "px")
hist(newdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()






