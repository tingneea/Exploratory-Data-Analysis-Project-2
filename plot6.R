# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California ( fips == 06037 ). Which city has seen greater changes over time in motor vehicle emissions?

library(data.table)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
dt_nei <- as.data.table(NEI)

# Subset by motor vehicle (type = ON-ROAD)
dt_motor <- dt_nei[dt_nei$type == "ON-ROAD"]

# Subset by Baltimore city (fips=24510) & Los Angeles (fips=06037)
dt_Baltimore <- dt_motor[dt_motor$fips == 24510]
dt_LA <- dt_motor[dt_motor$fips == "06037"]

# Combine 2 data table and group by 
dt_by_city <- rbind(dt_Baltimore,dt_LA)
dt_by_year <- dt_by_city[,sum(Emissions), by="year,fips"]
setnames(dt_by_year, c('Year','Fips','Total'))

# Plot the graph and generate in PNG file
png(filename="plot6.png", width=640, height=480)  
g <- ggplot(dt_by_year, aes(x=factor(Year), y=Total, fill=Fips)) + geom_bar(stat="identity",position="dodge") +
labs(title="Comparison of Baltimore City and Los Angeles from motor vehicle sources", x="Year",y=expression(paste('Total PM', ''[2.5], ' Emissions')), fill="State") + scale_fill_discrete(name="City",breaks=c("06037","24510"),labels=c("Los Angeles","Baltimore City"))
print(g)
dev.off()

