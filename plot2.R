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
png(filename = "plot2.png", width = 480, height = 480)
## Creating a plot
plot(x = filtered.data$Date_Time, y = filtered.data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
## Closing the file
dev.off()