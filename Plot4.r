


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
	
	