
	
#Plot 06 : Comparison between total emissions in Baltimore and Los Angeles county :

	#opening the file "summarySCC_PM25.rds"
	PM25_1 <- readRDS("summarySCC_PM25.rds")
	
	#Extracing values of Baltimore ("24510") and LA county ("06037") related to "ON-ROAD" type (motor vehicle) :
	pm_bc <- subset(PM25_1, fips=="24510"|fips=="06037" & type=="ON-ROAD")
	
	#Aggregating values of total emissions per year from pm_bc data set.
	
	pm_bc_ag <- aggregate(pm_bc$Emissions,by=list(pm_bc$fips,pm_bc$year),FUN=sum)
		#Optional : changing column names :
		
		colnames(pm_bc_ag) <- c("Fips","Year","Emissions")
	
	#Creating a plot using ggplot2 to compare values of Baltimore and LA county :
	
	png(filename="plot6.png")
	
	qplot(Year, Emissions, data=pm_bc_ag, col=Fips, geom="line")+ggtitle("Total PM2.5 Emissions from motor vehicles in Baltimore and California")
	
	dev.off()
	

