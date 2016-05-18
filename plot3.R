#Plot3
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
library("plyr")
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
baltimore <- NEI[NEI$fips=='24510',]
summed <- ddply(baltimore,.(year,type), summarize,sum=sum(Emissions))

## plot chart
png('plot3.png')
gplot<-ggplot(summed,aes(year,sum))
gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emissions in Baltimore by type",
                                           y="PM2.5 emissions (total)")
dev.off()

## Saved file plot3.png