


#plot05 : Total motor vehicle "ON-ROAD" emissions in Baltimore:

	#opening the file "summarySCC_PM25.rds"
	PM25_1 <- readRDS("summarySCC_PM25.rds")
	
	# specifying the required type "ON-ROAD"
	
	pm_mv <- subset(PM25_1, type=="ON-ROAD" & fips=="24510") 
		# this formula includes also "NON-ROAD" type values. If not needed, we should introduce this logical operator in arguments (& type != "NON-ROAD")
	
	#Aggregate the total emission quantities per year for vehicle pollution in Baltimore city
	
	pm_mvy <- aggregate(pm_mv$Emissions, by=list(pm_mv$year),FUN=sum)
	
		#Optional : changing column names :
	
		colnames(pm_mvy) <- c("Year","Emissions")
	
	#ploting results :
	
	plot5 <- with(pm_mvy,plot(Year, Emissions, main="Total Emission from motor vehicle pollution sources", lwd=2, type="l", lty=2))
	
	# Creating the *.png file :
	
	dev.copy(png,file="plot5.png")
	
	dev.off()