#Plot6
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library("ggplot2")

# set paths
projdir <- '/mnt/sdcard/project/exploratorydata'
summaryfile <- 'summarySCC_PM25.rds'
codefile <- 'Source_Classification_Code.rds'
setwd(projdir)
# do source data files exist?
if( !summaryfile %in% dir() || !codefile %in% dir())
{  print('data files missing')
  stop()
} else{  print('data files found')}

# Load data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter data
data <- NEI %>% filter(fips == "06037" | fips =='24510')
data$location <- factor(data$fips, labels = c("Los Angeles County", "Baltimore"))
#summary(data$location)
filteredClass <- SCC %>% filter(grepl("Vehicle",SCC.Level.Two,ignore.case = TRUE))

## Merge
combined <- merge(filteredClass,data, by="SCC")

## Sum
summed <- ddply(combined,.(year,location), summarize,sum=sum(Emissions))
#head(summed)

## plot chart
png('plot6.png')
ggplot(summed,aes(year,sum)) + 

  facet_grid(. ~ location) + 
  geom_point() + 
  labs(title="PM2.5 Emissions from motor vehicle sources in Baltimore and LA", y="PM2.5 emissions (total)") + 
  geom_line()
dev.off()

## Saved file plot6.png