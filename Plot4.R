# Plot4.R : Determine how emissions from coal-combustion-related sources changed
# from 1999-2008

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

# After exploring the data, the 'Short.Name' field seems to contain the union of 
# all other fields that contain 'Coal'. Subset the data to only include 'Coal'
# prior to merging: 
coal.data <- SCC[grepl("coal",SCC$Short.Name,ignore.case=T),]

# Subset the NEI data frame with only values of SCC that are related to Coal: 
s1 <- NEI[NEI$SCC %in% coal.data$SCC,]

##
## 3. Plot the results of exploratory analysis:
##

plot.data <- s1 %>% dplyr::group_by(year) %>% dplyr::summarize(Coal_Emissions = dplyr::n())

plot4 <- ggplot2::ggplot(data=plot.data, aes(x=year, y=Coal_Emissions)) +
  geom_line() +
  ggtitle("U.S. Emissions from Coal Cobustion-Related Sources") +
  ylab("PM2.5 Emissions (tons)") +
  xlab("Year")

plot4 # Render Plot

# Create a PNG copy and save in current directory:
dev.copy(png,'Plot4.png')
dev.off()
