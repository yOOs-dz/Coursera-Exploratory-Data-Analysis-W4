


# Plot2 : Plot of total emissions in Baltimore city


	#opening the file "summarySCC_PM25.rds"
	PM25_1 <- readRDS("summarySCC_PM25.rds")

	#Defining a subset data related to Baltimore (fips=="24510")
	PM_BLT <- subset(PM25_1,PM25_1$fips=="24510")

	#Creation a new dataset by calculating total emission per year using aggregate() function.
	BLTY <- aggregate(PM_BLT$Emissions,by=list(PM_BLT$year),FUN=sum)
	
	head(BLTY)
	Plot2 <- plot(BLTY$Group.1,BLTY$x,main="Total PM 2.5 emissions in Baltimore",xlab="Year",ylab="Total Emissions in Baltimore",type="b")
	
	dev.copy(png,file="Plot2.png")
	
	dev.off()