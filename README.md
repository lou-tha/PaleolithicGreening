# PaleolithicGreening

## **Where the grass is greener – large-scale phenological patterns and their explanatory potential for the distribution of Paleolithic hunter-gatherers in Europe**

Andreas Maier (1), Louise Tharandt (1), Florian Linsel (2), Vladislav Krakov (3), Patrick Ludwig (4)

(1): Institute for Prehistoric Archaeology, University of Cologne, Bernhard-Feilchenfeld-Str. 11, 50969 Köln

(2): Institute of Computer Science, Martin-Luther_Universität Halle-Wittenberg, Von-Seckendorff-Platz 1, 06120 Halle

(3): Department of Archaeology, Simon Fraser University, Education Building 9635, 8888 University Drive, Burnaby, British Columbia

(4): Karlsruhe Institute of Technology, Institute of Metereology and Climate Research, Department Troposphere Research (IMK-TRO), Hermann-von-Helmholtz-Platz 1, 76344 Eggenstein-Leopoldshafen

---

## Description

In this repository the data used in the publication "Where the grass is greener – large-scale phenological patterns and their explanatory potential for the distribution of Paleolithic hunter-gatherers in Europe" can be looked at and used to recreate our results. Our study relies on the following work routine. The scripts are written in R and Python. One of our primary goals is to perform all functions provided. The documentation and the complete workflow are published. All consecutive analyses can follow the exemplary procedure.  The **main.R** script contains the main functionality of our research, in which all parameters needed for conducting the functions used in scripts, libraries and packages are introduced. Our project is reproducible, which is easily done by running the following scripts in the **VegPer_R_Scripts** folder (see folder structure below).

---

## Notes

Please cite the use of this script as:

---

## Folder structure and contents

### this folder structure has been built to clearly organize the data input and the results that are generated through this script

* VegPer_Base_Data **(this folder contains the basic temperature and period factor data of the region that is chosen to be analyzed)**:
  * VegPer_Base_Data/LGM_Base_Data.csv
  * VegPer_Base_Data/Period_BlackSea.csv
  * VegPer_Base_Data/Period_NGRIP.csv
  * VegPer_Base_Data/Period_NGRIPv2.csv
  * VegPer_Base_Data/QGIS_ID_File.csv
  * VegPer_Base_Data/QGIS_ID_File_v2.csv
  * VegPer_Base_Data/QGIS_ID_File.xlsx

* VegPer_QGIS **(this folder contains all necessary QGIS rasterfiles as well as the python scripts to be used within QGIS)**:
  * pycache
  * 37-5_Aur_all
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

* VegPer_R_Scripts **(this folder contains every necessary R script, it will use the data provided in the Base Data folder)**:
  * main.R
  * Calc21Day.R
  * CalcStepsStandardised.R
  * CalcFilter.R
  * plot_2x2.R

* VegPer_Results **(this folder contains an empty folder structure, within these folder all results from the R scripts will be placed)**:
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

## Workflow

To calculate your own data, place the new temperature data and period factor data for a specific geographic area in the Base Data folder, give the selected periods a specific name and place them as the global parameter in the **main.R** script. Place the selected period in the **main.R** script behind the paremeter period, make sure to use the same name for the data file as for the period variable. Provide the link to the temperature base data, so the csv file can be read by R. The selected geographical area needs to be defined as the variable *step_list* used in the **CalcStepsStandardised.R** script. The size of the distances between coordinates has to be 2.5 degrees in any direction.

To start or recreate the analysis, open the **main.R** script in the *VegPer_R_Scripts* folder with R or R Studio, select all and run the script. From this main.R script all other scripts are invoked and run. To see the progress of the functions and scripts, check the folder **VegPer_Results** (see folder structure) and view the created csv files. Depending on the computer this code is run on and the number of data that is used, the results can appear after a while.

To see the vegetation period pull factors in a geographical context, the next step is to open the **PaleolithicGreeningQGIS.qgz** file with QGIS (3.10). Select the Python Console once your QGIS file has opened. Next click on the notepad with pen icon to show the Python editor. If the Python files are not visible, go to the folder symbol to open the Python scripts links.py, nodes.py and print.py (see folder structure). Select the links layer in the layer browser to the left, then run the **links.py** script. Repeat with the **nodes.py** script (select the nodes layer and run the script). The last step in QGIS is to run the **print.py** script. Nothing has to be selected, just run the Python script and the resulting vegetation period pull factor images will be exported to the folder extdata/QGIS. The layout of new visualized data needs be defined and changed depending on where the geographical area is located and the start and ending dates of the vegetation period.

To get a better overview and be able to compare the pull factors of spring and fall in each period, use the **plot_2x2.R** script after having exported all images from QGIS with the print.py script. This will combine the single plot images, that were exported from QGIS. Open the R script, select all of the code and press run. The results can be fund in the folder VegPer_QGIS/extdata/2x2.

---

## **troubleshooting and alternatives**

When running the main.R script it is possible to recieve an error regarding the working directory at some point. To fix this, setting the working directory again can resolve this error.

Example:

```R
setwd("../")
setwd("VegPer_Results/") 
```

---

> These troubleshooting summaries refer to the roadblocks and solutions encountered during the second half of this study (the Aurignacian/Western European component). Nonetheless, individuals seeking to replicate either halves of this study may benefit from some of the information found herein.

The process of preparing the Aurignacian/Western European datasets for EEP study’s **R script**, and simultaneously of tailoring the original EEP R script to accommodate the datasets, proved to be much more time-consuming than initially expected, taking up the better part of five weeks. The difficulties involved included: 

* Trying to get the source data to be properly formatted; and navigating Microsoft Excel’s tendencies to sprinkle random, blank cells in the middle of the dataset whenever a  formula was adjusted (however, reading the .csv file via R Studio actually proved quite helpful  for this issue; since the ID values and the row numbers would become mismatched, you could  scroll around to approximately where you noticed the mismatch begin – hard to pinpoint with a  288,086-entry spreadsheet – and then using the filter function, based on ID value that R studio has for datasets; and then keep halving your filtered selection, based on whether, after some perusing, the mismatch appears to begin in the first or the second half of the filtered section, and continuously doing that until you find it, and then edit it on a spreadsheet software); 

* Creating smaller datasets with only positive coordinate values (longitudinal values  west were encoded as negative values) to see if any of the error messages arising were due to the negative values; however, this turned out to not be the issue; 

* Trying to get Microsoft Excel to stop automatically reformatting dates and what it  registered as fractions (which were actually a set of coordinates separated by a hyphen);  however frustrating, these also ended up not being real issues with running the script, at least  not in our case; 

* Not realizing for a long time that the 0.5 x 2.5 degree spaced LGM node-temperature dataset was incompatible with the script, which was written to accommodate 2.5 x 2.5 degree  spacing; this was further exacerbated by the sheer size of the dataset, and I only realized later  the value of creating small, sample datasets to test-run through the script in order to save time; 

* Trying to rewrite the latter parts of the script so that it ran through the proper latitudes  and longitudes; and ensuring that the variable names were consistent between the different function definition files. 
	* Also, for a long period of time, the fact that R Studio cannot overwrite an output data file if that file is open in another program, such as Microsoft Excel, was simply not known to us. Thus, oftentimes an error message saying “cannot open the connection” would appear, without any clear reason for why. Troubleshooting online indicated only that this sometimes appears for working directory issues, i.e. for when the file is in the  wrong folder. As this was never really the case, for a long time it was quite unclear what the cause was whenever this error message would appear.

* Similarly, it was only grasped later that, within R Studio, a warning message is quite distinct from an error message. Unlike an error message, a warning message does not mean that no output was produced; only that it suspects that you might not be satisfied with the output data for one reason or another, which might not necessarily be the case.  
Additionally, the usefulness of the “Traceback” button that appears when an error message is produced was only discovered later; this pinpoints the exact part of the script from  which the error arose. 
Finally, error messages arising from loading a library into R Studio can oftentimes be  ignored, as not all aspects of a necessary library are themselves necessary. Only if additional error messages appear further down the line can it pose an issue. 

---

The **Python** component of the code from the eastern European study also consisted of  three subcomponents or scripts, which were run through the PyQGIS console within the QGIS software. 

* The first was the nodes.py script, which converted the vegetation start and end output  datasets from R script into colour- and shape-coded layers, for each phase and season. The second was the links.py script, which converted the green wave output datasets into green  arrow layers for each phase and season. The third was the print.py script, which exported these  images, along with the base geographic and Core Area layers, as .png files based on pre defined style parameters, with scales, legends, and titles. 
* Additionally, for this stage, an accurate and detailed digital elevation model (DEM) of  peninsular Europe was needed. For this, we decided to look into obtaining a Shuttle Radar  Topography Mission-based (SRTM-based) DEM, due to their extensive range and consistent  high resolution.  
We encountered some complications during both these components as well. Due to their  high resolution, many SRTM DEMs files end up being impossibly large for a study area as big  as peninsular Europe. One that I downloaded from the website of the European Union’s  Copernicus programme was 80 gigabytes, and another from NASA’s services ended up being  over 220 gigabytes. These were functionally impractical as they consistently caused QGIS to  crash on a regular computer.  
* A third option was to download such a DEM from the United States Geological Survey’s  website (USGS), which proved to be a success, as they offer the option of downloading lower resolution models (3 arc-second resolution). The file size for our study area from this source sat  at 5.66 gigabytes. However, the process of selecting, downloading, and then merging the  necessary DEMs was not so straightforward. What follows is a brief guide for how to do this, for  future reference. 

> Selecting, downloading, and merging SRTM DEMs from USGS’ EarthExplorer service:
1. On the USGS Earth Explorer interface 
* https://earthexplorer.usgs.gov/ ; create an account 
* input necessary coordinates to create an encompassing polygon 
* ensure the coverage looks right on the map 
* go to Data Sets -> Digital Elevation -> SRTM -> SRTM Void Filled 
* Then, just to be safe, go to Additional Criteria -> Resolution -> 3 Arc Second (Global) 
* press the footprint button on some of the tiles that are now visible, and browse through  them a little bit, if any are only marginally within your scope or even only adjacent to your  polygon, consider shrinking your polygon by just one minute (i.e. from 33'00 to 33'01 or from  57'00 to 56'59) 
2. Next, download the USGS Bulk Downloader App 
* https://dds.cr.usgs.gov/bulk ; make sure you are downloading for the right operating system 
* make sure you have a version of Java that is 10 or higher, and for the right OS 
* ensure that the BDA is downloaded to (D:) not (C:), if your computer makes such a  distinction 
* use same login credentials for BDA as for USGS EarthExplorer 
* back on the EarthExplorer site with all of your tiles, use the Show Results Control; add all results from current page to bulk download function; repeat as necessary; then go to bulk download 
* Press Go Item Basket; then Start Order; then open the SRTM Void Filled directory;  press Options in the top right corner; then Product Selection -> GeoTIFF; then Submit Product  Selection 
* go to the Bulk Downloader and login; your download should be automatically ready to  start there 
3. Open the QGIS project file; import the SRTM files; merge them: 
* upload all the TIFFs to QGIS (be patient, might take a while) then go to Raster ->  Miscellaneous -> Merge, then select all present layers, then make sure that it is saving the file  (i.e. not a temporary file) and then hit Run 

---

The **Python** scripts were also not without their own difficulties, which took a couple of  weeks to resolve. 

* Aside from renaming the variables within the script to accommodate the new  dataset and (after they had run successfully) adjusting the style properties of the layers in such  a way that all values were represented, were stylistically legible, and were consistent between  one another, there were also other, less obvious adjustments that had to be made. 
As it turns out, both QGIS 3.10 and QGIS 3.22 (the two versions we were working with)  already contained all of Python libraries necessary for our Python scripts. But, since they are for some reason located in different directories between the two versions, there was much  confusion about whether they were actually there, and much effort was spent on trying to locate  them online, download them, and place them in the proper file directory so that they could be  effectively called in the script, all of which turned out to be unnecessary. 

* For future reference, and specifically for cases of trying to run these scripts wherein all  the libraries are available in QGIS version 3.10 and up, if there is a library-loading error, try searching for the module in these folders – either C:\Program Files\QGIS  3.22.5\apps\Python39\Lib or C:\Program Files\QGIS 3.22.5\apps\Python39\Lib\site-packages  directories – and including the name of the folder in which the library file is contained, in the  format “from folder name import library name”. Conversely, if it is already in this format and  producing errors, try it in the format “import library name”. 

* Additionally, there were also the issues of certain nodes and arrows not being produced  by the Python scripts, identifiable by the obvious gaps on the maps. The missing nodes turned  out to be justifiably so; these were nodes where there was estimated to be no growing season  for that particular phase and location. The arrows however, posed a more difficult problem, as  they were clearly supposed to be there. What it turned out to be was that the original script did  not accommodate for green arrows that ran counter to the predominant direction (south,  southwest, and southeast in the springs of the phases, and north, northwest, and northeast in  the autumns). In the Eastern European Plain study, there was apparently no need to accommodate for this, as, on a far more homogenous landscape, the trajectories of the green waves in turn were also far more homogenous. These were excluded from the eastern  European study because they made up only a very small minority of the green arrows, and the  researchers believed that including them would only cause confusion and a cluttered-looking  map. 
Once this issue was identified and the problematic portion of the script identified, the  adjustment needed turned out only to be a small one. 

* Finally, there were additional errors with the print.py script, but in lieu of addressing  these (which seemed like extensive work, considering that the parameters were fine-tuned for  the demands of the eastern European datasets and study area), it was found that designing and exporting the figures manually through the QGIS Layout Manager interface to be quite effective and rewarding. 

---