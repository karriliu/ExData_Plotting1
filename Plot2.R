##loading the subset data into R
hpcdata <-read.table (pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),sep = ";",
                      col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                    "Voltage","Global_intensity", "Sub_metering_1","Sub_metering_2",
                                    "Sub_metering_3"),stringsAsFactors = FALSE)
##combine Date and Time into 1 column as Date2
library(dplyr)
hpcdata2<-mutate(hpcdata,Date2= paste(hpcdata$Date,hpcdata$Time))

##format the Date2 into dates 
hpcdata2$Date2 <-strptime(hpcdata2$Date2, "%d/%m/%Y %H:%M:%S")
hpcdata2$Date2 <-format(hpcdata2$Date2,"%a-%d-%Y %H:%M:%S")

plot(hpcdata2$Date2,hpcdata2$Global_active_power,type = "l")
