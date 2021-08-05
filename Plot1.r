

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

