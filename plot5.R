# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
dt_nei <- as.data.table(NEI)

# Subset by Baltimore city, fips=24510
dt_Baltimore <- dt_nei[dt_nei$fips == 24510]

# Subset by motor vehicle (type = ON-ROAD)
dt_Baltimore_motor <- dt_Baltimore[dt_Baltimore$type == "ON-ROAD"]

# Group the total emissions by year
dt_by_year <- dt_Baltimore_motor[,sum(Emissions), by=year]
setnames(dt_by_year, c('Year','Total'))

# Plot the graph and generate in PNG file
png(filename="plot5.png", width=640, height=480) 
barplot(dt_by_year$Total, names.arg=dt_by_year$Year, col='yellow', 
        main=expression('Total PM'[2.5]*' emission from Motor Vehicle in Baltimore City, Maryland from 1999 to 2008'),xlab='Year', ylab=expression(paste('Total PM', ''[2.5], ' Emissions')))
dev.off()

