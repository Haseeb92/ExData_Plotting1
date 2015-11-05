library(lubridate)
library(plyr)

fileUrl <- paste0('https://d396qusza40orc.cloudfront.net/', 
                  'exdata%2Fdata%2Fhousehold_power_consumption.zip')
download.file(fileUrl, destfile = './household_power_consumption.zip')
unzip('./household_power_consumption.zip')
dates <- read.csv2('./household_power_consumption.txt', 
                   colClasses = 'character')[,1]
dates <- dates %in% c('1/2/2007','2/2/2007')


power_df <<- read.csv2('./household_power_consumption.txt', dec = '.', 
                       na.strings = '?', stringsAsFactors = F)[dates,]
power_df <<- mutate(power_df, DateTime = ymd_hms(paste(dmy(power_df$Date),
                                                       power_df$Time)))

png('./plot3.png', width = 480, height = 480)
par(bg = 'transparent')
plot(power_df$DateTime, power_df$Sub_metering_1, col = 'black', type = 'l', xlab='')
lines(power_df$DateTime, power_df$Sub_metering_2, col = 'red')
lines(power_df$DateTime, power_df$Sub_metering_3, col = 'blue')
legend('topright', lty = 1, col = c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()