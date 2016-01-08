#ANDRE JORGE MOURA PIRES
#COURSE PROJECT #1 - Plot1

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

#Step 4 - Create "plot2.png"
par(cex = 0.8)
plot(Mydata$TimeC, Mydata$Global_active_power, type = "l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off()
