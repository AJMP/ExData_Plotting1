#ANDRE JORGE MOURA PIRES
#COURSE PROJECT #4 - Plot4

# As the file is to large for reading it in R, one should read only the data from 01/02/2007 to 02/02/2007.
# Skip 66637 records
# Read only two days = 60 * 24 * 2 = 2880 rows

#Step 1 - Download the File
filename <- "household_power_consumption.txt"
tempfile <- tempfile() # in order to create a directory in any computer that might want to use my code
file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_URL, tempfile, method = "curl")

#Step 2 - Set variables types and names
colclasses <- c("character", "character", rep("numeric", 7))
colnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Step 3 - Unzip and Read the data & Close the tempfile
Mydata <- read.delim(unz(tempfile, filename), sep = ";", header = FALSE, colClasses = colclasses, col.names = colnames, na.strings = "?",skip = 66637, nrows = 2880)

unlink(tempfile)

# add a column with the time converted
Mydata$TimeC <- strptime(paste(Mydata$Date, Mydata$Time), "%d/%m/%Y %H:%M:%S")

#Step 4 - Create "plot4.png" - 4 plots in one image
par(mfrow = c(2, 2), mar = c(8, 6, 4, 2), cex = 0.6)
with(Mydata, { 
  plot(TimeC, Global_active_power, type = "l", ylab="Global Active Power", xlab="")
  plot(TimeC, Voltage, type = "l", ylab="Voltage", xlab="datetime")        
  plot(TimeC, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
  lines(TimeC, Sub_metering_2, col="red")
  lines(TimeC, Sub_metering_3, col="blue")
  legend("topright", lty=1, col = c("black", "blue", "red"), bty="n", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         cex = 0.9, inset = c(0.1, 0.000, 0.1, 0.1))
  plot(TimeC, Global_reactive_power, type = "l", xlab="datetime")})    
dev.copy(png, file = "plot4.png", width = 480, height = 480) 
dev.off()