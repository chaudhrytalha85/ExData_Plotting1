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
## Subset the data for the required dates : 2007-02-01 & 2007-02-02 and
## convert column Global_active_power to numeric
##
power2 <- subset(power, Date > "2007-01-31" & Date < "2007-02-03")
power2 <- mutate(power2, Global_active_power = as.numeric(Global_active_power))
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
## Plot a line graph of Global Active Power to powerperiod to
## a .png file
##
png(filename = "plot2.png", width = 480, height = 480)

plot(powerperiod, power2$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
##
## Close the device
##
dev.off()
##
## Look at plot2.png in working directory
##
## End of script
##




