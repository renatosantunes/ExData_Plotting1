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

png(filename = "plot2.png", width = 480, height = 480)

plot(household_power_consumption$datetime,
     household_power_consumption$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()