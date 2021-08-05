


#Plot 3 : Total emissions in Baltimore by type of emission

	#opening the file "summarySCC_PM25.rds"
	PM25_1 <- readRDS("summarySCC_PM25.rds")

	#Creation a new dataset of total emission and type by calculating total emission per year using aggregate() function.

	BLTYT <- aggregate(PM_BLT$Emissions,by=list(PM_BLT$type,PM_BLT$year),FUN=sum)

	#Loading ggplot2
	library("ggplot2")
	#Changing the column names

	colnames(BLTYT) <- c("Type","Year","Emissions")

	#Ploting the total PM2.5 in Baltimore per year and per type
	
	png(filename = "plot3.png")

	qplot(Year,Emissions,data=BLTYT,col=Type,geom="line")+ggtitle("Total PM 2.5 Emissions in Baltimore")+xlab("Year")+ylab("Emissions PM 2.5")

	dev.off()