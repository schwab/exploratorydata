#Plot5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
balt <- NEI %>% filter(fips=='24510')
filted <- SCC %>% filter(grepl("Vehicle",SCC.Level.Two,ignore.case = TRUE))
combined <- merge(filtered,balt, by="SCC")
summed <- ddply(combined,.(year), summarize,sum=sum(Emissions))

summed

## plot chart
png('plot5.png')
gplot<-ggplot(summed,aes(year,sum))
gplot + 
  geom_point() + 
  labs(title="PM2.5 Emissions from motor vehicle sources in Baltimore", y="PM2.5 emissions (total)") + 
  geom_line()
dev.off()

## Saved file plot4.png