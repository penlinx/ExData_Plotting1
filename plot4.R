fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "power.zip")
unzip("~/power.zip", list = TRUE)
unzip("~/power.zip")
power <- read.table("~/household_power_consumption.txt", sep = ";", 
                    header = TRUE)

powerc <- subset(power, power$Date %in% c("1/2/2007", "2/2/2007"))

powerc[[3]] <- as.numeric(as.character(powerc$Global_active_power))

for (i in 7:9){
    powerc[[i]] <- as.numeric(as.character(powerc[[i]]))
}

datetime <- strptime(paste(powerc$Date, powerc$Time), "%d/%m/%Y %H:%M:%S")

powercn <- cbind(powerc, datetime)

png(file = "~/ExData_Plotting1/plot4.png")

par(mfrow = c(2, 2))
with(powercn, plot(datetime, Global_active_power, type = "l", 
                   ylab = "Global Active Power (kilowatts)", xlab = ""))

with(powercn, plot(datetime, Voltage, type = "l"))

with(powercn, plot(datetime, Sub_metering_1, 
                   ylab = "Energy sub metering", xlab = "", type = "n"))
with(powercn, points(days, Sub_metering_1, col = "black", type = "l"))
with(powercn, points(days, Sub_metering_2, col = "red", type = "l"))
with(powercn, points(days, Sub_metering_3, col = "blue", type = "l"))
legend("topright",pch = NA, lwd = 1, col = c("black", "red", "blue"), 
       legend = names(powercn)[7:9])

with(powercn, plot(datetime, Global_reactive_power, type = "l"))

dev.off()