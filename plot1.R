## Reading raw data from "household_power_consumption.txt" file.
raw.data <- read.table(file = "./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Converting Time and Date string variables using dplyr "mutate" function, and "dmy" and "hms" functions from lubridate package.
library(dplyr)
library(lubridate)
tidy.data <- raw.data %>% tbl_df() %>% mutate(Date = dmy(Date), Time = hms(Time))

## Filtering data to obtain a dataset for dates 2007-02-01 and 2007-02-02
filtered.data <- filter(tidy.data, Date >= "2007-02-01", Date <= "2007-02-02")
