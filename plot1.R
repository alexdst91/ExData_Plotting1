#the function 

plot1 <- function(){
    library(dplyr)
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
    #exporting the histogram in "plot1.png"
    png("plot1.png")
    hist(power07$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",col="red")
    dev.off()
}