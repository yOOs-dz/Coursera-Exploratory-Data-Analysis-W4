#Plot1 : Plot of total emissions per year
	#opening the file "summarySCC_PM25.rds"
PM25_1 <- readRDS("summarySCC_PM25.rds")
	#aggregate function per year
Peryear <- aggregate(PM25_1$Emissions,by=list(PM25_1$year),FUN=sum)
	#Creating the first plot
Plot1 <- plot(Peryear$Group.1,Peryear$x, main ="Total PM 2.5 emissions per Year", xlab="Year", ylab="Total Emissions",type="b") # The type"b" is used instead of "l" to obtain lines and points. 
#Printing *.png
dev.cur()
dev.copy(png,file="Plot1.png")
dev.off()



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

#Plot4 : Total "coal" emissions evolution per year in USA

	#opening the file "summarySCC_PM25.rds"
	PM25_1 <- readRDS("summarySCC_PM25.rds")
	
	#opening the file "Source_Classification_Code.rds"
	src <- readRDS("Source_Classification_Code.rds")
	
	#Aggregating pollution coal sources codes. This requires two steps.
		#First, using grepl() function, we have to produce a data set containing only SCC codes related to coal sources from the file "Source_Classification_Code.rds" (variable (src)
		
		src_coal <- src[grepl("coal",src$Short.Name), ]
		
		#Second, finding matching SCC codes (by using match() or %in% functions) between "src_coal" table and "PM25_1" (the main dataset) Results are stored in the table "pm_coal". 

		pm_coal <- PM25_1[PM25_1$SCC %in% src_coal$SCC, ]
		
	#Aggregating resulted total PM 2.5 emissions from coal sources using the tabe "pm_coal". Results stored in the variable "pm_coal_y"
	
	pm_coal_y <- aggregate(pm_coal$Emissions, by=list(pm_coal$year), FUN=sum)
	
		#Optional : changing column names :
	
		colnames(pm_coal_y) <- c("Year","Emissions")
		
	#Creating plot4 using Base plotting
	
	plot4 <- with(pm_coal_y, plot(Year,Emissions,main="Coal emissions per year",type="b"))
	
	# Creating the *.png file :
	
	dev.copy(png,file="plot4.png")
	
	dev.off()


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
	

