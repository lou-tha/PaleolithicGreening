# File:    nodes.py
# Author:  Florian Linsel

#############################################


#import geopandas as gpd
from qgis.core import QgsVectorFileWriter
import gdal , ogr
import inspect

def create_point_shape (csvFile, name, min_max):
    #source_ds = ogr.Open(csvFile)
    #layer = source_ds.GetLayer()
    
    layer = QgsVectorLayer(csvFile, name, "ogr")#, 'memory') 
    
    #prov = layer.dataProvider()

    #prov.addAttributes([QgsField("ID",QVariant.Double),QgsField("DOY",QVariant.Double),QgsField("LAT",QVariant.Double),QgsField("LONG",QVariant.Double),QgsField("MAX",QVariant.Double),QgsField("QGIS_ID",QVariant.Double)]) 
    #layer.updateFields()
    #print (layer.fields().names())
    #print(csvFile)
    # add layer to the map
    QgsProject.instance().addMapLayer(layer)
    '''
    # open the csv-file for reading and skip the header row
    lineStrings = open(csvFile, encoding="utf-8")
    print(q.decode())
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
    '''
    styling_nodes (layer, min_max)
    
    #export_layout()
    layer.commitChanges()
    QgsProject.instance().layerTreeRoot().findLayer(layer.id()).setItemVisibilityChecked(False)


def styling_nodes (layer, min_max):
    dir = 'layout_data/'
    #renderer = layer.renderer().QgsGraduatedSymbolRenderer

    
    if min_max == 'min':
        print(1)
        layer.loadNamedStyle(dir + 'standardised_style_nodes_min.qml')
        layer.triggerRepaint()
        
    else:
        print(1)
        layer.loadNamedStyle(dir + 'standardised_style_nodes_max.qml')
        layer.triggerRepaint()
    
    layer.reload()
    renderer = layer.renderer()
    
    #renderer.setMode(QgsGraduatedSymbolRendererV2.Quantile)
   #renderer.updateClasses(layer,renderer.Quantile,5)
    #renderer.updateRangeLabels() 
    #iface.layerTreeView().refreshLayerSymbology(layer.id()) # Refresh legend on the interface
    layer.reload() 
    #renderer.updateClasses(layer,renderer.Quantile,9)
    iface.layerTreeView().refreshLayerSymbology(layer.id()) # Refresh legend on the interface
    
filename = inspect.getframeinfo(inspect.currentframe()).filename
rel_path = os.path.dirname(os.path.dirname(os.path.abspath(filename)))


for i in ['BlackSea','NGRIP','LGM']:
    for j in ['min','max']:
        if i == 'LGM':
            k = '21Day_LGM'
            
            
            
            path = "file:///" + rel_path + "/VegPer_Results/Filter_Results/Filter_Results_" + i + "/nodes/nodes_" + j + "_" + k + ".csv"
            uri = path + "?encoding=%s&delimiter=%s&xField=%s&yField=%s&crs=%s&useHeader=%s" % ("UTF-8",",", "LONG", "LAT","epsg:4326","yes")
            
            name = "nodes_" + i + "_" + k + '_' + j 
            vlayer = QgsVectorLayer(uri, name, 'delimitedtext')
            #print(vlayer.isValid())
            print (name) 
            #iface.addVectorLayer(uri, name,'delimitedtext')
            path = "../VegPer_Results/Filter_Results/Filter_Results_" + i + "/nodes/nodes_" + j + "_" + k + ".shp"
            QgsVectorFileWriter.writeAsVectorFormat(vlayer, path, "UTF-8", vlayer.crs(), "ESRI Shapefile") 
            
            create_point_shape (path, name, j)
            
        else:
            for k in ["GS-3","GI-3", "GS-4", "GI-4", "GS-5.1", "GI-5.1", "GS-5.2", "GI-5.2", 
                "GS-6", "GI-6", "GS-7", "GI-7", "GS-8", "GI-8", "GS-9", "GI-9"]:
            
                path = "file:///" + rel_path + "/VegPer_Results/Filter_Results/Filter_Results_" + i + "/nodes/nodes_" + j + "_" + k + ".csv"
                uri = path + "?encoding=%s&delimiter=%s&xField=%s&yField=%s&crs=%s&useHeader=%s" % ("UTF-8",",", "LONG", "LAT","epsg:4326","yes")
                
                name = "nodes_" + i + "_" + k + '_' + j 
                vlayer = QgsVectorLayer(uri, name, 'delimitedtext')
                #print(vlayer.isValid())

                #iface.addVectorLayer(uri, name,'delimitedtext')
                path = "../VegPer_Results/Filter_Results/Filter_Results_" + i + "/nodes/nodes_" + j + "_" + k + ".shp"
                QgsVectorFileWriter.writeAsVectorFormat(vlayer, path, "UTF-8", vlayer.crs(), "ESRI Shapefile") 
                
                create_point_shape (path, name, j)
                
                

