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

png("plot2.png")

# Break the plot for problem 2 into three steps
plot(seq(1:nrow(dataset)),as.numeric(Global_active_power), type = "l",xaxt='n', yaxt='n',xlab = "", ylab = "Global Active Power (kilowatts)" )

axis(side=1, at <- c(1,1440,2880), labels = c("Thu", "Fri", "Sat") , ylim = c(0,6))

axis(side=2, ylim = c(0,6))

dev.off()