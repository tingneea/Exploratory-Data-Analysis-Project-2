NEI <- readRDS("summarySCC_PM25.rds")

# Convert data frame to data table
library(data.table)
dt_nei <- as.data.table(NEI)

# Group the total emissions by year
dt_by_year <- dt_nei[,sum(Emissions), by=year]
setnames(dt_by_year, c('Year','Total'))


# Plot the graph and generate in PNG file
png(filename="plot1.png", width=480, height=480) 
barplot(dt_by_year$Total/1000, names.arg=dt_by_year$Year, col='blue', main=expression('Total PM'[2.5]*' emission in United States from 1999 to 2008'),xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()

