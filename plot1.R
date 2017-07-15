timed <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
timed$Date <- as.Date(timed$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
timed <- subset(timed,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
timed <- timed[complete.cases(timed),]

## Combine Date and Time column
daTi <- paste(timed$Date, timed$Time)

## Name the vector
daTi <- setNames(daTi, "Date-Time")

## Remove Date and Time column
timed <- timed[ ,!(names(timed) %in% c("Date","Time"))]

## Add Date-Time column
timed <- cbind(daTi, timed)

## Format daTi Column
timed$daTi <- as.POSIXct(daTi)

## Create the histogram
hist(timed$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()





