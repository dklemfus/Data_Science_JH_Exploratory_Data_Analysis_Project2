# Plot2.R : Code that plots total emissions for Baltimore City, MD (FIPS=24510)
# from 1999 to 2008

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
## 2. Plot the total PM2.5 emission for Baltimore City, MD: 
##

plot.data <- as.data.frame(NEI) %>% filter(fips=="24510") %>% group_by(year) %>% 
  summarize(total_emissions = sum(Emissions))

# Use Base R to create plot:
plot(x=plot.data$year, y=plot.data$total_emissions, type="o", pch=20, col="red",
     ylab = "Total Emissions (tons)", xlab="Year", 
     main="Baltimore City, MD: Total PM2.5 Emissions by Year")

# Create a PNG copy and save in current directory:
dev.copy(png,'Plot2.png')
dev.off()