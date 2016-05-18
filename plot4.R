# Plot4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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
#balt <- NEI  %>% filter(fips=='24510')
filtered <- SCC %>% filter(grepl("combustion",SCC.Level.One,ignore.case = TRUE) & grepl("coal",SCC.Level.Three,ignore.case = TRUE) )
combined <- merge(filtered,NEI, by="SCC")
summed <- ddply(combined,.(year), summarize,sum=sum(Emissions))



## plot chart
png('plot4.png')
gplot <- ggplot(summed,aes(year,sum))
gplot + 
  geom_point() + 
  labs(title="PM2.5 Emissions from coal sources across the US", y="PM2.5 emissions (total)") + 
  geom_line()
dev.off()

## Saved file plot4.png