NEI <- readRDS("summarySCC_PM25.rds")

# Convert data frame to data table
library(data.table)
library(ggplot2)
dt_nei <- as.data.table(NEI)
dt_Baltimore <- dt_nei[dt_nei$fips == 24510]

# Group the total emissions by year and type
dt_by_type <- dt_Baltimore[,sum(Emissions),by="year,type"] 
setnames(dt_by_type, c('Year','Type','Total'))

# Plot the graph and generate in PNG file
png(filename="plot3.png", width=640, height=480)  
g <- ggplot(dt_by_type, aes(Year, Total, color=Type)) + geom_line(size=1) + xlab("Year") +  ylab(expression(paste('Total PM', ''[2.5], ' Emissions'))) + ggtitle('Comparison in sources of type in Baltimore City, Maryland')
print(g)
dev.off()
