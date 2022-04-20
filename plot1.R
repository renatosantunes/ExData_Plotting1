library(tidyverse)

rm(list=ls())

household_power_consumption <- read.csv(
  "household_power_consumption.txt",
  encoding="UTF-8",
  sep=";",
  na.strings=c("NA", "?"))

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
household_power_consumption$Time <- hms::parse_hms(household_power_consumption$Time)
# household_power_consumption$Time <- strptime(household_power_consumption$Time, "%H:%M:%S")

household_power_consumption <- filter(household_power_consumption,
                                      Date == "2007-02-01" | Date == "2007-02-02")

png(filename = "plot1.png", width = 480, height = 480)

hist(household_power_consumption$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()