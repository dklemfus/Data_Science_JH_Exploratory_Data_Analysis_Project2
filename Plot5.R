# Plot5.R : Determine how emissions from vehicle sources changed from 1999-2008 
# in Baltimore City (FIPS==24510)

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
## 2. Explore the data to determine which are coal-related: 
##

# After exploring the data, the EI.Sector contains groupings of on-road vehicles
vehicle.data <- SCC[grepl("on-road",SCC$EI.Sector,ignore.case=T),]

# Subset the NEI data frame with only values of SCC that are related to Vehicles: 
s1 <- NEI[NEI$SCC %in% vehicle.data$SCC,]

##
## 3. Plot the results of exploratory analysis:
##

plot.data <- s1 %>% filter(fips=="24510") %>%dplyr::group_by(year) %>% 
  dplyr::summarize(Vehicle_Emissions = dplyr::n())

plot5 <- ggplot2::ggplot(data=plot.data, aes(x=year, y=Vehicle_Emissions)) +
  geom_line() +
  ggtitle("Baltimore City Emissions from Motor Vehicle-Related Sources") +
  ylab("PM2.5 Emissions (tons)") +
  xlab("Year")

plot5 # Render Plot

# Create a PNG copy and save in current directory:
dev.copy(png,'Plot5.png')
dev.off()
