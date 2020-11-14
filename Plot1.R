# Plot1.R : Code that plots the total PM2.5 emissions from all sources for each
# of the years 1999, 2002, 2005, and 2008

library(dplyr)


################################################################################
##
## 1. Load NEI and SCC Data: 
##

# Read in National Emissions Inventory (NEI) Data:
NEI <- readRDS("./data/summarySCC_PM25.rds") # Note: This may take several seconds

# Read in Source Classification Code (SCC) Table Data:
SCC <- readRDS("./data/Source_Classification_Code.rds")


##
## 2. Plot the total PM2.5 emission from all sources: 
##

plot.data <- as.data.frame(NEI) %>% group_by(year) %>% 
  summarize(total_emissions = sum(Emissions))
 
# Use Base R to create plot:
plot(x=plot.data$year, y=plot.data$total_emissions, type="o", pch=20, col="red",
     ylab = "Total Emissions (tons)", xlab="Year", main="Total U.S. PM2.5 Emissions by Year")

# Create a PNG copy and save in current directory:
dev.copy(png,'Plot1.png')
dev.off()