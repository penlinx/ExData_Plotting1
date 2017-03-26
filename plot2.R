fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "power.zip")
unzip("~/power.zip", list = TRUE)
unzip("~/power.zip")
power <- read.table("~/household_power_consumption.txt", sep = ";", header = TRUE)

powerc <- subset(power, power$Date %in% c("1/2/2007", "2/2/2007"))

powerc[[3]] <- as.numeric(as.character(powerc$Global_active_power))

datetime <- strptime(paste(powerc$Date, powerc$Time), "%d/%m/%Y %H:%M:%S")

powercn <- cbind(powerc, datetime)

png(file = "~/ExData_Plotting1/plot2.png")

with(powercn, plot(datetime, Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()