# PaleolithicGreening

## **Where the grass is greener – large-scale phenological patterns and their explanatory potential for the distribution of Paleolithic hunter-gatherers in Europe**

Andreas Maier (1), Louise Tharandt (1), Florian Linsel (2), Vladislav Krakov (3), Patrick Ludwig (4)

(1): Institute for Prehistoric Archaeology, University of Cologne, Bernhard-Feilchenfeld-Str. 11, 50969 Köln

(2): Institute of Computer Science, Martin-Luther_Universität Halle-Wittenberg, Von-Seckendorff-Platz 1, 06120 Halle

(3): Department of Archaeology, Simon Fraser University, Education Building 9635, 8888 University Drive, Burnaby, British Columbia

(4): Karlsruhe Institute of Technology, Institute of Metereology and Climate Research, Department Troposphere Research (IMK-TRO), Hermann-von-Helmholtz-Platz 1, 76344 Eggenstein-Leopoldshafen

---

## Description

In this repository the data used in the publication can be found and used to recreate our results. Our study relies on the following work routine. This script is written in R and Python. One of our primary goals is to perform all functions provided. The documentation and the complete workflow are published. All consecutive analyses can follow the exemplary procedure.  This script contains the main functionality of our research, in which all parameters needed for conducting the functions used in scripts, libraries and packages are introduced. Our project is reproducible, which is easily done by running the following script.

---

## Notes

Please cite the use of this script as:

---

## Workflow

Place temperature data and period factor data for specific geographic area in the Base Data folder, give the selected periods a specific name and place them as the global parameter in the **main.R** script. Place the selected period in the **main.R** script behind the paremeter period. Provide the link to the temperature base data so the csv file can be read by R. The selected geographical area needs to be defined behind the parameter step_list for the **CalcStepsStandardised.R** script. The size of the distances between coordinates has to be 2.5 degrees in any direction.

To start the analysis, open the **main.R** script in the VegPer_R_Scripts folder, select all and run the script. From this main.R script all other scripts are invoked and run. To see the progress of the funcions and script, check the folder **VegPer_Results** (see section folder structure) and view the created csv files. Depending on the computer this code is run on and the number of data that is used, the results can appear after a while.

To see the vegetation period pull factors in a geographical context, the next step is to open the **PaleolithicGreeningQGIS.qgz** file with QGIS (3.10). Select the Python Console once your QGIS file has opened. Next click on the notepad with pen icon to show the Python editor. If the Python files are not visible, go to the folder symbol to open the Python scripts links.py, nodes.py and print.py (see folder structure below). Select the links layer in the layer browser to the left, then run the **links.py** script. Repeat with the **nodes.py** script (select the nodes layer and run the script). The last step in QGIS is to run the **print.py** script. Nothing has to be selected, just run the Python script and the resulting vegetation period pull factor images will be exported to the folder extdata/QGIS. The layout of the visualized data can be defined and changed depending on what is interesting to show.

To get a better overview and be able to compare the pull factors of spring and fall in each period, use the **plot_2x2.R** script after having exported all images from QGIS with the print.py script. This will combine the single plot images, that were exported from QGIS. Open the R script, select all and press run. The results can be fund in the folder extdata/2x2.

---

## Folder structure and contents

### this folder structure has been built to clearly organize the data input and the results that are generated through this script

* Base Data **(this folder contains the basic temperature and period factor data of the region that is chosen to be analyzed)**:
  * VegPer_Base_Data/LGM_Base_Data.csv
  * VegPer_Base_Data/Period_BlackSea.csv
  * VegPer_Base_Data/Period_NGRIP.csv
  * VegPer_Base_Data/Period_NGRIPv2.csv (name the file Period_chosenparametername.csv, see main.R script)
  * VegPer_Base_Data/QGIS_ID_File.csv
  * VegPer_Base_Data/QGIS_ID_File_v2.csv
  * VegPer_Base_Data/QGIS_ID_File.xlsx

* QGIS **(this folder contains all necessary QGIS rasterfiles as well as the python scripts to be used within QGIS)**:
  * pycache
  * exdata (Result Images from plotting the Vegetation Period in QGIS)
    * 2x2
    * QGIS
  * geographical_data (QGIS geographical layers)
  * layout_data (QGIS symbology and layout files)
  * link_node_data (QGIS node files)
  * links (QGIS link files for all parameters - LGM, BlackSea, NGRIP)
  * python_scripts
    * links.py
    * nodes.py
    * print.py
  * rasterfiles (Elevation map)
  * sites (archaeological sites)
  * PaleolithicGreeningQGIS.qgz

* Scripts **(this folder contains every necessary R script, it will use the data provided in the Base Data folder)**:
  * main.R
  * Calc21Day.R
  * CalcStepsStandardised.R
  * CalcFilter.R
  * plot_2x2.R

* Result Folder Structure **(this folder contains an empty folder structure, within these folder all results from the R scripts will be placed)**:
  * VegPer_Results/21Day_BlackSea_Results
  * VegPer_Results/21Day_LGM_Results
  * VegPer_Results/21Day_NGRIP_Results
  * VegPer_Results/Calc_Step_Results
    * VegPer_Results/Calc_Step_Results/Calc_Step_BlackSea
    * VegPer_Results/Calc_Step_Results/Calc_Step_LGM
    * VegPer_Results/Calc_Step_Results/Calc_Step_NGRIP
  * VegPer_Results/Filter_Results
    * VegPer_Results/Filter_Results/Filter_Results_BlackSea
      * VegPer_Results/Filter_Results/Filter_Results_BlackSea/nodes
    * VegPer_Results/Filter_Results/Filter_Results_LGM
      * VegPer_Results/Filter_Results/Filter_Results_LGM/nodes
    * VegPer_Results/Filter_Results/Filter_Results_NGRIP
      * VegPer_Results/Filter_Results/Filter_Results_NGRIP/nodes
  
---

## **troubleshooting and alternatives**

When running the main.R script it is possible to recieve an error regarding the working directory at some point. To fix this setting the working directory again can resolve this error.

Example:

```R
setwd("../")
setwd("VegPer_Results/") 
```

---
