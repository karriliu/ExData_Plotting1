##loading the subset data into R
hpcdata <-read.table (pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),sep = ";",
                   col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                 "Voltage","Global_intensity", "Sub_metering_1","Sub_metering_2",
                                 "Sub_metering_3"))

##plot1 
hist(hpcdata$Global_active_power,col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

##copy the plot to PNG
dev.copy(png,file = "plot1.png")
dev.off()

