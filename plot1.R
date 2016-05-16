projdir <- '/mnt/sdcard/project/eda-wk4'
summaryfile <- 'summarySCC_PM25.rds'
codefile <- 'Source_Classification_Code.rds'
setwd(projdir)
if( !summaryfile %in% dir() || !codefile %in% dir())
{  print('data files missing')
  stop()
} else{  print('data files found')}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

p1_1 <- aggregate(Emissions ~ year, NEI, sum)
p1_2 <-aggregate(Emissions ~ year, NEI, NROW)
p1_2$Emissions <- p1_1$Emissions/p1_2$Emissions

png("plot1.png")
plot(p1_1$year,p1_1$Emissions,type="n",xlab="year",ylab="total PM2.5 Emission")
lines(p1_1$year,p1_1$Emissions)
title(main="PM2.5 emissions over time")
dev.off()
