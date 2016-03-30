#! /usr/bin/Rscript --vanilla
library(dataRetrieval)
library(plyr)
sites = c('01184000', '01193050') # put these in numerical order
discharges = readNWISuv(sites, '00060', Sys.Date())
#print(discharges)
max.dates = ddply(discharges, ~site_no, summarize, max.date = max(dateTime))
values = numeric(length(sites))
attach(discharges)
for(i in 1:length(sites)){
	values[i] = discharges[site_no == sites[i] & dateTime == max.dates[i,]$max.date,]$X_00060_00011
}
detach(discharges)
#print(values)
write.csv(values, 'discharge.csv')
write(values, 'file.out', sep=',')
