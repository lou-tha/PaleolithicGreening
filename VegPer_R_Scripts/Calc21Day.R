# File:    Calc21Day.R
# Author:  Florian Linsel, Louise Tharandt


#############################################

# generate new temperature data

calc_21 <- function (LGM_temp) {
	i = 1 
	while (i < nrow(LGM_temp)){ # all rows will be calculated (1-49640)
		
		if(LGM_temp[i,]$Temp_mean >= 5){    # if the number of the row in the column Temp_mean is >= 5
			LGM_temp[i,]$Veg = 1              # the row in the column Veg will be 1
		}else {                             # if the number of the row in the column Temp_mean is not >= 5
			LGM_temp[i,]$Veg = 0             # the row in the column Veg will be 0
		}
		
		test1 <- subset(LGM_temp, ID >= i & ID < i+21)
		test2 <- subset(LGM_temp, ID <= i & ID > i-21)
		
		
		if(sum(test1$Veg == 1) == 21 || sum(test2$Veg == 1) == 21){   # if the sum of rows in the column Temp_mean is == 5
			LGM_temp[i,]$Veg.21Day = 1                                  # the row in the column Veg.21Day will be 1
		}else {                                                       # if the number of the row in the column Temp_mean is not == 5
			LGM_temp[i,]$Veg.21Day = 0                                 # the row in the column Veg.21Day will be 0
		}
		
		i=i + 1
	}
	return (LGM_temp)
	
}


period_correction <- function (x,p,month) { 
		LGM_temp <- LGM # the existing LGM data is assigned to a new object, so the original data won't be manipulated
		LGM_temp$Period = x # the period list is assigned
		period_corr <- read.csv(paste("VegPer_Base_Data/Period_", p, ".csv", sep=""), header =T,  check.names = F)
		# the list of periods is the same as in the table depicting the season factors
		# this helps to only select those factors, the will be used to calculate the new data for a specific period
		a <- period_corr[period_corr[,"Time"]==x,]
		
		# the second for loop, which is nested in the first loop, selects the month, so the monthly factors can be added to the existing data 
		# in this loop the temperatur mean is also calculated
		for(y in month) {
			# b assignes the right factor, because each month in a period has a different factor, that is added to the existing LGM data
			b <- a[,paste(y)]
			LGM_temp[LGM_temp[,"Month"]==y,]$Temp = LGM_temp[LGM_temp[,"Month"]==y,]$Temp +b # factor is added to temperatures
			LGM_temp[LGM_temp[,"Month"]==y,]$Temp_mean = LGM_temp[LGM_temp[,"Month"]==y,]$Temp_mean +b # factor is added to temperature means
			
		}
		
		# filter the temperature data that was calculated to display the start and end of the vegetation period
		# the vegetation period start and end is defined as the mean of 3 temperatures >= 5 degrees Celsius
		i = 1
		while (i < nrow(LGM_temp)){ 
			if(LGM_temp[i,]$Temp_mean >= 5){ 
				LGM_temp[i,]$Veg = 1 
			}else { 
				LGM_temp[i,]$Veg = 0 
			}
			i=i + 1
		}
		
		
		#calc21-function for the data sets (not LGM)
		
		i = 1
		while (i < nrow(LGM_temp)){ 
			
			test1 <- subset(LGM_temp, ID >= i & ID < i+21)
			test2 <- subset(LGM_temp, ID <= i & ID > i-21)
			
			
			if(sum(test1$Veg == 1) == 21 || sum(test2$Veg == 1) == 21){ 
				LGM_temp[i,]$Veg.21Day = 1 
			}else { 
				LGM_temp[i,]$Veg.21Day = 0 
			}
			
			i=i + 1
		}
		# export path
		path <- paste("VegPer_Results/21Day_", p, "_Results/",sep="")
		
		# export the data in the for loop as new .csv file with the same period name as the period factor that was used 
		write.csv(LGM_temp, paste(path, x,".csv",sep=""))
	
}

DAY_21 <- function(p,period,month){
	LGM <- read.csv("VegPer_Base_Data/LGM_base_data.csv", header = T,  fileEncoding="UTF-8-BOM")
	# LGM <- read.csv("VegPer_Base_Data/LGM_base_data_simplified.csv", header = T,  fileEncoding="UTF-8-BOM")

	if (p == "LGM") {
		# export path
		path <- paste("VegPer_Results/21Day_", p, "_Results/",sep="")
		LGM_temp <- LGM
		LGM_temp <- calc_21(LGM_temp)
		write.csv(LGM_temp, paste(path,'21Day_',p, ".csv",sep=""))
	}else{

		# the for loop starts with the set up of the stadial or interstadial that is calculated
		lapply(period,period_correction,p,month)
	}
}


