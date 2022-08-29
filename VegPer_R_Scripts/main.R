# File:    main.R
# Author:  Florian Linsel, Louise Tharandt


#############################################
#libraries

library(tidyverse)
library(dplyr)
library(purrr)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source("../VegPer_R_Scripts/Calc21Day.R")
source("../VegPer_R_Scripts/CalcStepsStandardised.R")
source("../VegPer_R_Scripts/CalcFilter.R")
source("../VegPer_R_Scripts/plot_2x2.R")


#############################################
# set working directory
setwd("../") #reference inside of the github / working directory folder



# global parameter: 
parameter <- c("BlackSea" ,"NGRIP", "LGM") #name of the period data sets  
# parameter <- c("NGRIPv2") second case study data


# create new directories and folders for the results
for (p in parameter){
  dir.create(file.path(paste0('VegPer_Results/')), showWarnings = FALSE)
  dir.create(file.path(paste0('VegPer_Results/Calc_Step_Results/Calc_Step_',p)), showWarnings = FALSE)
  dir.create(file.path(paste0('VegPer_Results/21Day_',p,'_Results')), showWarnings = FALSE)
  dir.create(file.path(paste0('VegPer_Results/Filter_Results')), showWarnings = FALSE)
  dir.create(file.path(paste0('VegPer_Results/Filter_Results/Filter_Results_',p)), showWarnings = FALSE)
  dir.create(file.path(paste0('VegPer_Results/Filter_Results/Filter_Results_',p,'/nodes')), showWarnings = FALSE)
}


# input files
# LGM base data that will be used to add factors to get the temperature data of stadial and interstadial periods
LGM <- read.csv("VegPer_Base_Data/LGM_base_data.csv", header = T,  fileEncoding="UTF-8-BOM")
# LGM <- read.csv("VegPer_Base_Data/LGM_base_data_simplified.csv", header = T,  fileEncoding="UTF-8-BOM") second case study data


# list of stadial and interstadial climatic periods of interest
period <- c("GS-3", "GI-3", "GS-4", "GI-4", "GS-5.1", "GI-5.1", "GS-5.2", "GI-5.2", 
            "GS-6", "GI-6", "GS-7", "GI-7", "GS-8", "GI-8", "GS-9", "GI-9")
# period <- c("GS-8", "GI-8", "GS-11", "GI-11") second case study data




##############################################
# Calc21Day.R

# list of months
month <- c(1:12)

lapply(parameter,DAY_21,period,month) # function to calculate the 21 day average of all periods and data sets
# this line is not used in the second case study, as no other data needs to be calculated and factors have to be added
# a simple hashtag in front of this line will stop the line from being read by the program R



##############################################
# CalcStepsStandardised.R

#list of coordinates
step_list <- c(20, 60, 47.5, 65, 2.5)
# step_list <- c(-10, 30, 35, 55, 2.5) second case study data
# step_list_1 <- step_list [1]
# step_list_2 <- step_list [2]
# step_list_3 <- step_list [3]
# step_list_4 <- step_list [4]
# step_list_5 <- step_list [5]
# segmented for the second case study and used in the script CalcStepsStandardised.R

#list of parameters needed for step-function
step_day_size <- c(2,7,14,21,28) 


# set workspace and folders for results
setwd("VegPer_Results/")


lapply (parameter,stepfunction,period,step_day_size,step_list) # function to calculate the steps between each coordinate node of all periods and data sets


##############################################
# CalcFilter.R

setwd("../") # can be commented out, leave in if the working directiory cannot be found
setwd("VegPer_Results/") # can be commented out, leave in if the working directiory cannot be found

df_result_result <- data.frame()


lapply (parameter,VegPer_Results,period,df_result_result) # function to filter the calculated results of all periods and data sets

############################################################################################
############################################################################################
############################################################################################
# create the plots with Python and QGIS





