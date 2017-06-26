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
power <- read.csv(powerfile, header = TRUE, sep = ";")
##
## Convert date and time column into Date and Period Class
##
power <- mutate(power, Date = dmy(Date), Time = hms(Time))
## 
## Subset the data for the required dates : 2007-02-01 & 2007-02-02
power2 <- subset(power, Date > "2007-01-31" & Date < "2007-02-03")
##
## Retain the subset and remove original data to conserve memory
##
rm(power)
##
## Convert Global Active Power to Numeric Class and subset out the column
##
gpower <- as.numeric(as.character(power2$Global_active_power))
##
## Create a png file, activating device along with it
##
png(filename = "plot1.png", width = 480, height = 480)
##
## Plot histogram
##
hist(gpower, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
##
## Close device
##
dev.off()
##
## Now plot1.png is ready to view in working directory
##
## End of scipt
##
