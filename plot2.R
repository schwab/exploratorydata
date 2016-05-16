#Plot2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#  (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

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

# calculate totals
baltimore <- aggregate(Emissions ~ year, NEI[NEI$fips=='24510',], sum)


png("plot2.png")
plot(baltimore$year,baltimore$Emissions,type="n",xlab="year",ylab="total PM2.5 Emission (Baltimore)")
lines(baltimore$year,baltimore$Emissions)
title(main="Baltimore PM2.5 emissions over time")
dev.off()
## Saved file plot2.png