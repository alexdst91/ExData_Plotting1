#

plot4 <- function(){
    library(dplyr)
    library(lubridate)
    #if not present, create data folder
    if(!file.exists("./data")){dir.create("./data")}
    #dowload zip data 
    URLfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    if(!file.exists("./data/powerConsumption.zip")){
        download.file(URLfile, "./data/powerConsumption.zip", method = "curl")
    }
    #if not already done, unzip file
    if(!file.exists("./data/household_power_consumption.txt")){
        unzip("./data/powerConsumption.zip", exdir = "./data")
    }
    #import the table in R
    power<-tbl_df(read.table("./data/household_power_consumption.txt",header= TRUE,sep = ";", na.strings = "?"))
    #filter only correct date data
    power07<-filter(power, Date=="1/2/2007"| Date=="2/2/2007")
    
    #create variable time with both date and time
    power07 <- mutate(power07, DateTime=dmy_hms(paste(power07$Date,power07$Time)))
    
    #exporting the plot in "plot2.png"
    png("plot4.png")
    par(mfrow=c(2,2))
    #first plot
    plot(power07$DateTime, power07$Global_active_power, type="n", xlab = "", ylab = "Global Active Power") 
    lines(power07$DateTime, power07$Global_active_power, type="l")
    #second plot
    plot(power07$DateTime, power07$Voltage, type="n", xlab = "datatime", ylab = "Voltage")
    lines(power07$DateTime, power07$Voltage, type="l", col="black")
    #third plot
    plot(power07$DateTime,power07$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering") 
    lines(power07$DateTime, power07$Sub_metering_1, type="l", col="black")
    lines(power07$DateTime, power07$Sub_metering_2, type="l", col="red")
    lines(power07$DateTime, power07$Sub_metering_3, type="l", col="blue")
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)
    #fourth plot
    plot(power07$DateTime, power07$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power") 
    lines(power07$DateTime, power07$Global_reactive_power, type="l")
    dev.off()
    
}