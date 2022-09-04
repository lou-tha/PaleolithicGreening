# File:    CalcStepsStandardised.R
# Author:  Florian Linsel, Louise Tharandt

#############################################

# calculating the vegetation period pull

stepping <- function  (csv_file, long_west, long_east, lati_bottom, lati_top, step, step_day_size, p){
# stepping <- function  (csv_file, step_list_3, step_list_4, step_list_1, step_list_2, step_list_5,step_day_size,p){ for the second case study
  
  tbl <-
    list.files(pattern = paste (csv_file,".csv", sep= '')) %>% 
    map_df(~read_csv(.)) 
  
  
  # starts with the set up of the stadial or interstadial that are calculated
  
  temp_data <- tbl 
  
  #long_west = 20, long_east = 60, lati_bottom = 47.5, lati_top = 65, step = 2.5 
  
  VegPeriod_complete <- tbl[tbl$Veg.21Day == 1,]
  df_result <- data.frame(c("a","b","c","d","e","f","g","h"))
  df_result_max <- data.frame(c("a","b","c","d","e","f","g","h"))
  
  text =''
  
  # calculation of the min, max, sum and mean of DOY and sum of temperatures
  for (long in seq(from = long_west, to = long_east, step)){ # runs through every longitude
    
    #calculation of the vegetation change and the route of transmission of the fauna
    
    #migration in the spring
    for (lat in seq(from = lati_bottom, to = lati_top, step)){ # runs through every latitude
      result <- VegPeriod_complete[VegPeriod_complete$Long == long & VegPeriod_complete$Lat == lat,] #filtering point
      data <- min(result$DOY, na.rm=T) 
      for (xlong in seq(from = -step, to = step, step)){ 
        for (ylati in seq(from = 0, to = step, step)){
          for (a in step_day_size){
            
            test <- VegPeriod_complete[VegPeriod_complete$Long == long + xlong & VegPeriod_complete$Lat == lat + ylati,]
            data_test <- min(test$DOY, na.rm=T)
            if (data_test == Inf){break 
            } else if (data == -Inf){break
            } else if (data == 0){break
            } else if (data == data_test+1){break
            } else if (data == data_test){break
            } else if (data <= data_test-a){stats <- c(long,lat,long+xlong,lat+ylati,data_test-data,a,QGIS_ID (lat,long),QGIS_ID (lat+ ylati,long + xlong)) 
            
            } else {
              break 
            }
            df_result <- cbind (df_result, stats)
            
          }
        }
      }
      
      #migration in the autumn
      data_max <- max(result$DOY, na.rm=T) 
      for (xlong in seq(from = -step, to = step, step)){ 
        for (ylati in seq(from = -step, to = 0, step)){
          for (a in step_day_size){
            
            test <- VegPeriod_complete[VegPeriod_complete$Long == long + xlong & VegPeriod_complete$Lat == lat + ylati,]
            data_test_max <- max(test$DOY, na.rm=T)
            if (data_max == -Inf){ break 
            } else if (data_max == Inf){break
            } else if (data_max == 0){break
            } else if (data_max == data_test_max){break
            } else if (data_max == data_test_max-1){break
            } else if (data_max <= data_test_max-a){stats_max <- c(long,lat,long+xlong,lat+ylati,data_test_max-data_max,a,QGIS_ID (lat,long),QGIS_ID (lat+ ylati,long + xlong)) 
            
            } else {
              break
            }
            
            df_result_max <- cbind (df_result_max, stats_max)
            
          }
        }
      }
    }
    if (p == "NGRIP" && csv_file == "GS-6" && lat == 65 && long == 20) {stats_max <- ''}
    df_result <- cbind (df_result, stats)
    df_result_max <- cbind (df_result_max, stats_max)
  }
  
  df_result_min <- df_result %>% t(.) %>% data.frame(.) %>% .[-c(0,1),] 
  df_result_max <- df_result_max %>% t(.) %>% data.frame(.) %>% .[-c(0,1),] 
  rownames(df_result_min) <- NULL
  rownames(df_result_max) <- NULL
  
  
  df_result_min [0,1] <- paste('"', df_result_min [0,1], sep ="")
  df_result_max [0,1] <- paste('"', df_result_min [0,1], sep ="")

  
  path <- paste("../Calc_Step_Results/Calc_Step_",p,"/",sep="")
  print(path)
  print(getwd())
  x = "export"
  
  write.csv(df_result_min, paste(path,p,'_',csv_file,"_min.csv",sep=""), row.names = F, col.names=F)
  write.csv(df_result_max, paste(path,p,'_',csv_file,"_max.csv",sep=""), row.names = F, col.names=F)
}



QGIS_ID <- function (lat,long) {
  QGIS_ID <- read_csv('../../VegPer_Base_Data/QGIS_ID_File.csv')
  # QGIS_ID <- read_csv('../../VegPer_Base_Data/QGIS_ID_File_v2.csv') second case study
  val <- paste(long,'/',lat,sep='')
  QGIS_ID$Target == val
  out <- QGIS_ID[QGIS_ID$Target == val,]$ID
  return (out)
}


stepfunction <- function(p,period,step_day_size,step_list){
  
  if (p == "LGM") {
    period = "21Day_LGM"

    adress <- paste0("21Day_",p,"_Results",sep="")
    setwd(adress)
    stepping (period, step_list [1], step_list [2], step_list [3], step_list [4], step_list [5],step_day_size,p)
    
  }else {
    
    adress <- paste0("21Day_",p,"_Results",sep="")
    setwd(adress)
    
    lapply(period, stepping, step_list [1], step_list [2], step_list [3], step_list [4], step_list [5],step_day_size,p)
    setwd("../")
  }
}



