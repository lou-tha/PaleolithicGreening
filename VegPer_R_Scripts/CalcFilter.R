# File:    CalcFilter.R
# Author:  Florian Linsel, Louise Tharandt

#############################################


publication <- function (path,tbl,inter) { 
	
	temp_data <- tbl 
	
	VegPeriod_complete <- tbl[tbl$Veg.21Day == 1,]

	df_result <- data.frame()
	text = p
	for (i in seq(from = 47.5, to = 65, 2.5)){ text = paste (c(text,'', i, 'Start veg. day', 'End veg. day', 'Veg. sum days','Sum of temperature'))}
	# for (i in seq(from = 35, to = 55, 2.5)) second case study
	df_result <- cbind(text)
	
	#creation of nodes:
	text = paste (c('','ID','DOY','LAT','LONG','MIN','QGIS_ID'))	
	df_node_min <- cbind(text)
	text = paste (c('','ID','DOY','LAT','LONG','MAX','QGIS_ID'))	
	df_node_max <- cbind(text)
	
	
	
	# calculation of the min, max, sum and mean of DOY and sum of temperature
	for (long in seq(from = 20, to = 60, 2.5)){ # runs through every longitude
	# for (long in seq(from = -10, to = 30, 2.5)) second case study

		node_min = ''
		node_max = ''
		stats=''
		
		for (lat in seq(from = 47.5, to = 65, 2.5)){ # runs through every latitude
		# for (lat in seq(from = 35, to = 55, 2.5)) second case study
			result <- VegPeriod_complete[VegPeriod_complete$Long == long & VegPeriod_complete$Lat == lat,] # filtering according to coordinates
			stats <- c(stats,'',long,min(result$DOY, na.rm=T),max(result$DOY,na.rm=T),max(result$DOY,na.rm=T)-min(result$DOY, na.rm=T),sum(result$Temp_mean,na.rm=T)) 
			
			#creating and merging the data with the node files
			node_min = c('',paste(long,'/',lat, sep=''),min(result$DOY, na.rm=T),lat,long,'Min',QGIS_ID (lat,long))
			node_max = c('',paste(long,'/',lat, sep=''),max(result$DOY, na.rm=T),lat,long,'Max',QGIS_ID (lat,long))
			
			df_node_min = cbind(df_node_min, node_min) 
			df_node_max = cbind(df_node_max, node_max)
		}
		#preparation of the csv export (publication)
		assign(paste(long), stats) 
		name <- paste(long)

		df_result <- cbind (df_result, stats)
		
	}
	
	if (inter == "GI-3"){df_result_result <- data.frame(df_result)} else {df_result_result <- rbind(df_result_result[,],df_result[,])}
	

	print(paste(path,inter,".csv",sep=""))
	print(path)
	
	write.table(df_result, paste(path,inter,".csv",sep=""), sep=',', row.names = FALSE, col.names = FALSE)
	write.table(df_node_min %>% t(.) %>% data.frame(.) %>% .[,-1] %>% .[.[,2] != 'Inf',] %>% .[.[,2] != '-Inf',], paste(path,'nodes/nodes_min_',inter,".csv", sep=""), sep=',', row.names = FALSE, col.names = FALSE)
	write.table(df_node_max %>% t(.) %>% data.frame(.) %>% .[,-1] %>% .[.[,2] != 'Inf',] %>% .[.[,2] != '-Inf',], paste(path,'nodes/nodes_max_',inter,".csv", sep=""), sep=',', row.names = FALSE, col.names = FALSE)
	
}


interstadial <- function(inter,p) {
	
	# export path
	path <- paste("../Filter_Results/Filter_Results_",p,"/",sep="")
	
	tbl <-
		list.files(pattern = paste0(inter,".csv",sep="")) %>% 
		map_df(~read_csv(.))
	print(paste0(inter,".csv"))

	publication(path,tbl,inter)
	
}



VegPer_Results <- function (p,period,df_result_result){ 
  
  adress <- paste0("21Day_",p,"_Results",sep="")
  
  
  setwd(adress)
  
  
  if (p == "LGM"){
    period <- list("21Day_LGM")
  } 
  print(p)
  lapply(period,interstadial,p)
  
  
  setwd("../")
}

