#  *************************************************************************************
#  *************************  Load and Condition Data  *********************************

# Assuming that the raw data file is in the working directory

dataset <- read.table("household_power_consumption.txt", header = T, sep = ";")

# Convert factor columns to character type

i <- sapply(dataset, is.factor)

dataset[i] <- lapply(dataset[i], as.character)

# Convert to dataframe

dataset <- as.data.frame(dataset)

# Fix the variable name masking issue

colnames(dataset)[2] <- "Sampletime"

# Covert dates to POSIX type
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Subset the data set
dataset <- subset(dataset,dataset$Date == "2007-1-2" | dataset$Date == "2007-2-2" )

# Set up multiple plot

png("plot4.png")

par(mfrow = c(2,2))


#Plot from 2 above

plot(seq(1:nrow(dataset)),as.numeric(Global_active_power), type = "l",xaxt='n', yaxt='n',xlab = "", ylab = "Global Active Power" )

axis(side=1, at <- c(1,1440,2880), labels = c("Thu", "Fri", "Sat") , ylim = c(0,6))

axis(side=2, ylim = c(0,6))

# First additional plot

plot(seq(1:nrow(dataset)),as.numeric(Voltage), type = "l",xaxt='n', yaxt='n',ylab = "Voltage", xlab = "datetime")

axis(side = 2, at <- c(234,238,242,246))
axis(side =2, at <- c(236,240,244), labels = FALSE)
axis(side=1, at <- c(1,1440,2880), labels = c("Thu", "Fri", "Sat"), ylim = c(0,30) ) 

#plot from 3 above

plot(seq(1:nrow(dataset)),as.numeric(Sub_metering_1), type = "l",xaxt='n', yaxt='n',xlab = "", ylab = "Energy sub metering" )
lines(seq(1:nrow(dataset)),as.numeric(Sub_metering_2), col = "red")
lines(seq(1:nrow(dataset)),as.numeric(Sub_metering_3), col = "blue")

axis(side=1, at <- c(1,1440,2880), labels = c("Thu", "Fri", "Sat"), ylim = c(0,30) ) 

axis(side=2, ylim = c(0,30) )

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), horiz=FALSE, lty = c(1, 1, 1), pch = c(NA, NA, NA), lwd = 1, seg.len = 2, cex = .75, bty = "n")


# Second additional plot

plot(seq(1:nrow(dataset)),as.numeric(Global_reactive_power), type = "l",xaxt='n', yaxt='n',ylab = "Global_reactive_power", xlab = "datetime")
axis(side=1, at <- c(1,1440,2880), labels = c("Thu", "Fri", "Sat"), ylim = c(0,30) ) 
axis(side=2, ylim = c(0,30) )

dev.off()