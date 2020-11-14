# Plot3.R : Code that plots total emissions for Baltimore City, MD (FIPS=24510)
# from 1999 to 2008 that shows sources by 'type'

library(dplyr)
library(ggplot2)


################################################################################
##
## 1. Load NEI and SCC Data: 
##

# Read in National Emissions Inventory (NEI) Data:
NEI <- readRDS("./data/summarySCC_PM25.rds") # Note: This may take several seconds

# Read in Source Classification Code (SCC) Table Data:
SCC <- readRDS("./data/Source_Classification_Code.rds")


##
## 2. Plot the total PM2.5 emission for Baltimore City, MD by type: 
##

plot.data <- as.data.frame(NEI) %>% filter(fips=="24510") %>% 
  group_by(year,type) %>% 
  summarize(total_emissions = sum(Emissions))

# Use ggplot2 to create plot:
plot3 <- ggplot2::ggplot(data=plot.data, aes(x=year, y=total_emissions,color=type)) +
  geom_line() +
  ggtitle("Baltimore City, MD: Total PM2.5 Emissions by Year/Type") +
  ylab("Total Emissions (tons)") +
  xlab("Year")

plot3 # Render Plot

# Create a PNG copy and save in current directory:
dev.copy(png,'Plot3.png')
dev.off()