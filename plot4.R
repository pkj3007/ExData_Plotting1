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


## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(timed, {
        plot(Global_active_power~daTi, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~daTi, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~daTi, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~daTi,col='Red')
        lines(Sub_metering_3~daTi,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~daTi, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})


## Saving and closing device
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
