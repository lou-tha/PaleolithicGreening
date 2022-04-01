import re

import gdal , ogr
import pandas as pd
import numpy as np
import os, sys
import qgis.utils

#from Froot_Loops_QGIS_print import *

def create_line_model (csvFile,name,export_path):
    
    # create an empty memory layer for polylines
    layer = QgsVectorLayer('LineString?crs=EPSG:4326', name, 'memory')
    #print(vlayer.isValid())

    prov = layer.dataProvider()
    prov.addAttributes([QgsField("total_number_days",QVariant.Double),QgsField("limit_of_days",QVariant.Double),QgsField("ID_source",QVariant.Double),QgsField("ID_target",QVariant.Double)]) 
    layer.updateFields()
    print (layer.fields().names())
    # add layer to the map
    QgsProject.instance().addMapLayer(layer)

    # open the csv-file for reading and skip the header row
    lineStrings = open(csvFile, "rU")

    next(lineStrings)

    # start editing
    layer.startEditing()

    # loop over the lines, split them into 4 coordinates, build points from pairs of
    # them, and connect the pair of points 
    feats = []



    for line in lineStrings:
        line = re.sub("['\"]",'',line)
        lineStringAsList = line.split(",")
        
        from_node = QgsPoint(float(lineStringAsList[0]),float(lineStringAsList[1]))
        to_node = QgsPoint(float(lineStringAsList[2]),float(lineStringAsList[3]))
        feat = QgsFeature()
        fields = QgsFields()
        feat.setFields(fields)

        feat.setAttributes([float(i) for i in lineStringAsList[4:8]])
        feat.setGeometry(QgsGeometry.fromPolyline([from_node, to_node]))
        #feat['point_id']="Start Point"
        #feat.setAttribute (float(lineStringAsList[4]))
        feats.append(feat)

    # finally add all created features and save edits
    prov.addFeatures(feats)
    layer.updateExtents()
    
    styling (layer)
    #export_layout()
    layer.commitChanges()
    QgsProject.instance().layerTreeRoot().findLayer(layer.id()).setItemVisibilityChecked(False)

    path = "C:/Users/SFB 806/Documents/GitHub/Vegetation_Period_Data/VegPer_QGIS/links/" + export_path +  name + ".shp"
    QgsVectorFileWriter.writeAsVectorFormat(layer, path, "UTF-8", layer.crs(), "ESRI Shapefile") 
    
    
    #QgsProject.instance().removeMapLayers( [vl.id()] )
    
def styling (layer):
    #layer = iface.activeLayer()
    #layer.geometryType() == QGis.Point:
    dir = 'layout_data/'
    #renderer = layer.renderer().QgsGraduatedSymbolRenderer
    
    layer.loadNamedStyle(dir + 'standardised_style_4.qml')
    layer.triggerRepaint()
    #renderer = layer.renderer()
    #print("Type:", renderer.type())
    
    
    #renderer.updateClasses(layer,renderer.Quantile,9)
    #renderer.updateRangeLabels() 
    iface.layerTreeView().refreshLayerSymbology(layer.id()) # Refresh legend on the interface
    layer.reload() 
    

def plotting_export_png ():
    export_layout()


def reduce_resolution (name, x):
    #try:
    os.chdir('rasterfiles/')
    print(name)
    in_ds = gdal.Open(name)
    out_ds = 'reduced/' + x + name 
    
    in_band = in_ds.GetRasterBand(1)
    myarray = np.array(in_band.ReadAsArray())
    
    limit = 8
    
    x = in_band.XSize - (in_band.XSize % limit) 
    y = in_band.YSize - (in_band.YSize % limit)  

    '''if x < 100 or y < 100:
        resolution = x,y
    else:'''
    if in_band.XSize % limit > 0 and in_band.YSize % limit > 0:
            resolution = (x /limit +1, y/limit+1)
    elif in_band.YSize % limit > 0:
        resolution =  in_band.XSize/limit, y/limit +1
    elif in_band.XSize % limit > 0:
        resolution = x/limit +1, in_band.YSize / limit
    else:
        resolution = (in_band.XSize / limit), (in_band.YSize / limit)
        

    gtiff_driver = gdal.GetDriverByName('GTIFF')
    dst_ds = gtiff_driver.Create(out_ds,
                           int(resolution[0]),
                           int(resolution[1]),
                           1,
                           gdal.GDT_Float64)


    dst_ds.GetRasterBand(1).SetNoDataValue(0)

    dst_ds.SetProjection(in_ds.GetProjection())
    geotransform = list(in_ds.GetGeoTransform())
    geotransform [1] *= limit
    geotransform [5] *= limit
    dst_ds.SetGeoTransform(geotransform)
    myarray = in_band.ReadAsArray(buf_xsize=int(resolution[0]), buf_ysize= int(resolution[1]))
    
    myarray [myarray < 0] = 0
    out_band = dst_ds.GetRasterBand(1)
    out_band.WriteArray(myarray)

    #except:
    print('ohoh')
    in_ds = None
    dst_ds = None
    
    
  
    
for i in ['LGM','BlackSea','NGRIP']:#,
    for j in ['min','max']:
        if i == 'LGM':
            k = '21Day'
            name = i + '_' + k + '_' + j #"GS-3_min_QGIS_second"
            csvFile = "../VegPer_Results/Calc_Step_Results/Calc_Step_" + i + "/" + name + ".csv"
            export_path = i + "/" + name
            create_line_model (csvFile,name,export_path)
        else:
            for k in ["GS-3","GI-3", "GS-4", "GI-4", "GS-5.1", "GI-5.1", "GS-5.2", "GI-5.2", 
                "GS-6", "GI-6", "GS-7", "GI-7", "GS-8", "GI-8", "GS-9", "GI-9"]:
                
                # specify your csv-file
                name = i + '_' + k + '_' + j #"GS-3_min_QGIS_second"
                csvFile = "../VegPer_Results/Calc_Step_Results/Calc_Step_" + i + "/" + name + ".csv"
                export_path = i + "/" + name
                create_line_model (csvFile,name,export_path)
    
#printpdfmulti("Froot_Loops")    

'''
import os

directory_in_str = 'F:/Aster' # + ASTGTMV003_N58E018_dem

directory = os.fsencode(directory_in_str)
    
for file in os.listdir(directory):
     filename = os.fsdecode(file)
     print(filename)
     
     if filename.endswith(".tif"): 
         # print(os.path.join(directory, filename))
         reduce_resolution(filename, 'reduced_')
         #break
         continue
     else:
         continue
    
'''