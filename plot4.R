## Reading raw data from "household_power_consumption.txt" file.
raw.data <- read.table(file = "./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Converting Time and Date string variables using dplyr "mutate" function, and "dmy" and "hms" functions from lubridate package.
## A new column, "Date_Time", is also added to show Date and Time combined.
library(dplyr)
library(lubridate)
tidy.data <- raw.data %>% tbl_df() %>% mutate(Date = dmy(Date), Time = hms(Time), Date_Time = dmy_hms(paste(raw.data$Date, raw.data$Time)))

## Filtering data to obtain a dataset for dates 2007-02-01 and 2007-02-02
filtered.data <- filter(tidy.data, Date >= "2007-02-01", Date <= "2007-02-02")

## Opening a png file
png(filename = "plot4.png", width = 480, height = 480)
## Determining number of rows and columns in a plot
par(mfcol = c(2,2))
## Adding plot 1
plot(x = filtered.data$Date_Time, y = filtered.data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
## Adding plot 2
plot(x = filtered.data$Date_Time, y = filtered.data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = filtered.data$Date_Time, y =  filtered.data$Sub_metering_2, type = "l", col = "red")
lines(x = filtered.data$Date_Time, y =  filtered.data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), cex = 0.75)
## Adding plot 3
plot(x = filtered.data$Date_Time, y = filtered.data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## Adding plot 4
plot(x = filtered.data$Date_Time, y = filtered.data$Global_reactive_power, type = "l", xlab = "datetime")
## Closing the file
dev.off()