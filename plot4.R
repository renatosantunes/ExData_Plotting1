library(tidyverse)

rm(list=ls())

household_power_consumption <- read.csv(
  "household_power_consumption.txt",
  encoding="UTF-8",
  sep=";",
  na.strings=c("NA", "?"))

household_power_consumption$datetime <- paste(household_power_consumption$Date,
                                              household_power_consumption$Time,
                                              sep = "-")
household_power_consumption$datetime <- as.POSIXct(household_power_consumption$datetime,
                                                   format = "%d/%m/%Y-%H:%M:%S")

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
household_power_consumption$Time <- hms::parse_hms(household_power_consumption$Time)

household_power_consumption <- filter(household_power_consumption,
                                      Date == "2007-02-01" | Date == "2007-02-02")

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

plot(household_power_consumption$datetime,
     household_power_consumption$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

plot(household_power_consumption$datetime,
     household_power_consumption$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

#####
plot(household_power_consumption$datetime,
     household_power_consumption$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(household_power_consumption$datetime,
      household_power_consumption$Sub_metering_2,
      col = "red",
      ylab = "Energy sub metering",
      xlab = "")

lines(household_power_consumption$datetime,
      household_power_consumption$Sub_metering_3,
      col = "blue",
      ylab = "Energy sub metering",
      xlab = "")

legend("topright", pch = c(95,95,95), col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#####

plot(household_power_consumption$datetime,
     household_power_consumption$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.off()