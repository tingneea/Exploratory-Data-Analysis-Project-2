NEI <- readRDS("summarySCC_PM25.rds")

# Convert data frame to data table
library(data.table)
dt_nei <- as.data.table(NEI)
dt_Baltimore <- dt_nei[dt_nei$fips == 24510]

# Group the total emissions by year
dt_by_year <- dt_Baltimore[,sum(Emissions), by=year]
setnames(dt_by_year, c('Year','Total'))

# Plot the graph and generate in PNG file
png(filename="plot2.png", width=480, height=480) 
barplot(dt_by_year$Total, names.arg=dt_by_year$Year, col='red', main=expression('Total PM'[2.5]*' emission in Baltimore City, Maryland from 1999 to 2008'),xlab='Year', ylab=expression(paste('Total PM', ''[2.5], ' Emissions')))
dev.off()