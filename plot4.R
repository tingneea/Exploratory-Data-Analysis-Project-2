# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC")

coal_match  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subset_by_coal <- NEISCC[coal_match, ]
total_by_year <- aggregate(Emissions ~ year, subset_by_coal, sum)

png("plot4.png", width=640, height=480)
g <- ggplot(total_by_year/1000, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity",fill="orange") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions in Kilotons")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008') + 
  theme(plot.title = element_text(size = 18,  colour = "blue"), axis.title.y = element_text(size=15, colour = "blue"), axis.title.x = element_text(size=15, colour = "blue"))
print(g)
dev.off()


