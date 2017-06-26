##
## This script assumes that Household Power data is present in the working directory,
## and has been unzipped.
## First load packages necessary to run this script
##
library(dplyr)
library(lubridate)
library(ggplot2)
##
## Create a variable with the filepath of the data as its value
##
powerfile <- paste0(getwd(), "/", "household_power_consumption.txt")
##
## Read the file and save it to data frame power
power <- read.csv(powerfile, header = TRUE, sep = ";", stringsAsFactors = FALSE)
##
## Convert date and time column into Date and Period Class
##
power <- mutate(power, Date = dmy(Date))
## 
## Subset the data for the required dates : 2007-02-01 & 2007-02-02
##
power2 <- subset(power, Date > "2007-01-31" & Date < "2007-02-03")
##
## Now convert the class of columns of power2, other than Date and Time,
## into numeric class
##
power2 <- mutate(power2, Global_active_power = as.numeric(Global_active_power))
power2 <- mutate(power2, Sub_metering_1 = as.numeric(Sub_metering_1),
                 Sub_metering_2 = as.numeric(Sub_metering_2), 
                 Sub_metering_3 = as.numeric(Sub_metering_3))
power2 <- mutate(power2, Global_reactive_power = as.numeric(Global_reactive_power))
power2 <- mutate(power2, Voltage = as.numeric(Voltage))
##
## Retain the subset and remove original data to conserve memory
##
rm(power)
##
## Create a character vertor from date and time columns of power2
## and then convert to Date Time class using strptime()
##
powerperiod <- paste(power2$Date, power2$Time, sep = " ")
powerperiod <- strptime(powerperiod, format = "%Y-%m-%d %H:%M:%S")
##
## activate device to create a .png file
##
png(filename = "plot4.png", width = 480, height = 480)
##
## Use par() to set 4 graphs in a 2 by 2 position
##
par(mfrow = c(2,2))
##
## Plot powerperiod with the power 2 column Global_active_Power
##
plot(powerperiod, power2$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
##
## PLot powerperiod with the power2 Column Voltage
##
plot(powerperiod, power2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##
## plot againt powerperiod, the columns of Sub_metering
##
plot(powerperiod, power2$Sub_metering_1, type = "l", xlab="", 
     ylab = "Energy sub metering")
lines(powerperiod, power2$Sub_metering_2, col = "red")
lines(powerperiod, power2$Sub_metering_3, col = "blue")
##
## Introduce a legend to differnciate which line plot corresponds
## to which variable
##
legend("topright", lty = 1, col= c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##
## Plot powerperiod with power2 column Global_reactive_power
##
plot(powerperiod, power2$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
##
## Close device
##
dev.off()
##
## View plot4.png in working directory
##
## End of script
##

