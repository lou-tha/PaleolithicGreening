#!/usr/bin/env python3
import os
from qgis.core import (QgsProject, QgsLayoutExporter, QgsApplication)
import qgis.utils

def export_layout():
    QgsApplication.setPrefixPath("extdata/QGIS", True)

    gui_flag = False
    app = QgsApplication([], gui_flag)

    app.initQgis()

    project_path = os.getcwd() + '/Froot_Loops_QGIS_3.qgz'

    project_instance = QgsProject.instance()
    project_instance.setFileName(project_path)
    project_instance.read()

    manager = QgsProject.instance().layoutManager()
    layout = manager.layoutByName("Froot_Loops") # name of the layout
    # or layout = manager.layouts()[0] # first layout

    exporter = QgsLayoutExporter(layout)
    exporter.exportToPdf(project_instance.absolutePath() + "/extdata/QGIS/layout.png",
                         QgsLayoutExporter.PdfExportSettings())

    app.exitQgis()
    
    
    
    

def printpdfmulti(layoutname,link,node):
    for i in range(1):
        #selected_layers = qgis.utils.iface.layerTreeView().selectedLayers()
        projectInstance = QgsProject.instance()
        #projectInstance_2 = QgsProject.instance()
        layoutmanager = projectInstance.layoutManager()
        layout = layoutmanager.layoutByName(layoutname)
         #Layout nameprojectInstance = QgsProject.instance()
        
        

        #QgsProject.instance().layerTreeRoot().findLayer(layer.name('cut_n30e030_reduced')).setItemVisibilityChecked(True)
        #QgsProject.instance().layerTreeRoot().findLayer(layer.name('cut_n30e060_reduced')).setItemVisibilityChecked(True)
        #QgsProject.instance().layerTreeRoot().findLayer(layer.name('cut_n30e000_reduced')).setItemVisibilityChecked(True)
        #QgsProject.instance().layerTreeRoot().findLayer(layer.name('aster_reduced')).setItemVisibilityChecked(True)
        
        link_node (layout,link,node,projectInstance)

        print(1)
        del projectInstance, layout

def link_node (layout,link,node,projectInstance):
    print (link)
    print (node)
    node_layer = projectInstance.mapLayersByName(str(node))[0]
    link_layer = projectInstance.mapLayersByName(str(link))[0]

    QgsProject.instance().layerTreeRoot().findLayer(node_layer.id()).setItemVisibilityChecked(True)
    QgsProject.instance().layerTreeRoot().findLayer(link_layer.id()).setItemVisibilityChecked(True)
    #iface.layerTreeView().refreshLayerSymbology(node_layer.id())
    #iface.layerTreeView().refreshLayerSymbology(link_layer.id())
    #iface.layerTreeView().layerTreeRoot().findLayer(link_layer.id()).refreshItems()
    #iface.layerTreeView().layerTreeModel().refreshLayerLegend(link_layer.id())
    '''
    layout_temp = layout
    #legend = layout.selectedLayoutItems()
    legend = QgsLayoutItemLegend(layout_temp)
    layerTree = QgsLayerTree()
    layerTree.addLayer(node_layer)
    layerTree.addLayer(link_layer)
    legend.model().setRootGroup(layerTree)
    legend.refresh()
    layout.addLayoutItem(legend)
    layout.refresh()
    
    newFont = QFont("MS Shell Dlg 2", 8) 
    legend.setStyleFont(QgsLegendStyle.SymbolLabel, newFont)
    '''
    
    exporter = QgsLayoutExporter(layout)
    exporter.exportToImage(path + '/' + link + ".png", QgsLayoutExporter.ImageExportSettings() )
    QgsProject.instance().layerTreeRoot().findLayer(link_layer.id()).setItemVisibilityChecked(False)
    QgsProject.instance().layerTreeRoot().findLayer(node_layer.id()).setItemVisibilityChecked(False)
    
    


#for i in list(['cut_n30e030_reduced','cut_n30e060_reduced','cut_n30e000_reduced','aster_reduced','ice_sheet_interstadial','ice_sheet_LGM','world_rivers_dSe']):
for i in list(['Elevation (m)','Ice sheet (interstadial)','Ice sheet (LGM)','Rivers']):
        projectInstance = QgsProject.instance()
        layer = projectInstance.mapLayersByName(i)[0]
        QgsProject.instance().layerTreeRoot().findLayer(layer.id()).setItemVisibilityChecked(True)

path = "extdata/QGIS"



for i in ['LGM','BlackSea','NGRIP']:#,:
    for j in ['min','max']:
        if j == 'min':
            layoutname = 'Froot_Loops min'
        elif j == 'max':
            layoutname = 'Froot_Loops max'
        
        if i == 'LGM':
            k = '21Day_LGM'
           
            node = "nodes_" + i + "_" + k + '_' + j
            link =  i + "_" + k + '_' + j
            printpdfmulti(layoutname,link,node)
        else:
            #for k in ["GS-4"]:#
            for k in ["GS-3","GI-3", "GS-4", "GI-4", "GS-5.1", "GI-5.1", "GS-5.2", "GI-5.2", 
                "GS-6", "GI-6", "GS-7", "GI-7", "GS-8", "GI-8", "GS-9", "GI-9"]:
            #for k in ["GI-3", "GS-4"]:
                node = "nodes_" + i + "_" + k + '_' + j
                link =  i + "_" + k + '_' + j
                printpdfmulti(layoutname,link,node)
                
'''
for i in list(['Elevation (m)','Ice sheet (interstadial)','Ice sheet (LGM)','Rivers']):
    projectInstance = QgsProject.instance()
    layer = projectInstance.mapLayersByName(i)[0]
    QgsProject.instance().layerTreeRoot().findLayer(layer.id()).setItemVisibilityChecked(False)
    '''
