##loading the subset data into R
hpcdata <-read.table (pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),sep = ";",
                      col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                    "Voltage","Global_intensity", "Sub_metering_1","Sub_metering_2",
                                    "Sub_metering_3"),stringsAsFactors = FALSE)
##combine Date and Time into 1 column as Date2
library(dplyr)
hpcdata2<-mutate(hpcdata,Date2= paste(hpcdata$Date,hpcdata$Time))

##format the Date2 into POSIXlt class
hpcdata2$Date2 <-strptime(hpcdata2$Date2, "%d/%m/%Y %H:%M:%S")

##open the graphic device
png(file = "plot4.png")

##set the 2x2 graphic format
par(mfrow = c(2, 2))

##make 4 plots
with(hpcdata2, {
 
  ##plot1
  plot(hpcdata2$Date2,hpcdata2$Global_active_power,
       type = "l", xlab = "",ylab = "Global Active Power")
  
  ##plot2
  plot(hpcdata2$Date2,hpcdata2$Voltage,
       type = "l", xlab = "datetime",ylab = "Voltage")
  ##plot3
  with(hpcdata2, plot(Date2, Sub_metering_1,type = "l", xlab = " ",ylab = "Energy sub metering",col="black"))
  with(hpcdata2,lines(Date2, Sub_metering_2,type = "line",col="red"))
  with(hpcdata2,lines(Date2, Sub_metering_3,type = "line",col="blue"))
  legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ##plot4
  plot(hpcdata2$Date2,hpcdata2$Global_reactive_power,
       type = "l", xlab = "datetime",ylab = "Global_reactive_power")
})

##turn off the graphic device
dev.off()