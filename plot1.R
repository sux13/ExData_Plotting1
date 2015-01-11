##  Produce a histogram of Global Active Power for the given dates Feb 1st, 2007 and Feb 2nd, 2007

##  check if file exists; if not, download the file again
if(!file.exists("household_power_consumption.txt")){
    message("Downloading data")
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = "./household_power_consumption.zip", method = "curl")
    unzip("household_power_consumption.zip")
}

##  read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")

##  subset the data to only dates Feb 1st, 2007 and Feb 2nd, 2007
dataNeeded <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

##  convert the Date and Time columns to the correct format
dataNeeded <- transform(dataNeeded, Date = as.Date(dataNeeded$Date, format = "%d/%m/%Y"), 
                        Time = strptime(paste(dataNeeded$Date, dataNeeded$Time), 
                                        format = "%d/%m/%Y %H:%M:%S"))

##  initiates the PNG graphics device to save to plot1.png
png("plot1.png",  width = 480, height = 480, units = "px", bg = "transparent")

##  produce histogram
hist(dataNeeded$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", xlim = range(dataNeeded$Global_active_power), ylim = c(0, 1200))

##  closes the PNG graphics device
dev.off()
