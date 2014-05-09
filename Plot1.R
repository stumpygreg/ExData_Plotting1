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

png("plot1.png")

# Plot the basic histogram with no axis
hist(as.numeric(dataset$Global_active_power), col = "red",xlab = "Global Active Power (kilowatts)", xlim = c(0,6), xaxt='n', yaxt='n')

# Add the specific axis we want
axis(side=1, at = seq(0,6,2))
axis(side=2, at = seq(0,1200,200))

dev.off()s