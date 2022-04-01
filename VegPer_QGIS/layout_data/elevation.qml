<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" maxScale="0" version="3.4.9-Madeira" hasScaleBasedVisibilityFlag="0" minScale="1e+08">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <customproperties>
    <property key="WMSBackgroundLayer" value="false"/>
    <property key="WMSPublishDataSourceUrl" value="false"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <rasterrenderer classificationMax="2283" type="singlebandpseudocolor" band="1" opacity="1" alphaBand="-1" classificationMin="-74">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>MinMax</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader classificationMode="3" colorRampType="INTERPOLATED" clip="0">
          <colorramp name="[source]" type="gradient">
            <prop k="color1" v="250,250,250,255"/>
            <prop k="color2" v="5,5,5,255"/>
            <prop k="discrete" v="0"/>
            <prop k="rampType" v="gradient"/>
            <prop k="stops" v="0.0697115;244,244,244,255:0.114183;240,240,240,255:0.170673;235,235,235,255:0.235577;229,229,229,255:0.305288;223,223,223,255:0.367788;217,217,217,255:0.490385;206,206,206,255:0.538462;201,201,201,255:0.620192;194,194,194,255:0.700721;187,187,187,255:0.763221;181,181,181,255:0.763221;181,181,181,255:0.829327;132,132,132,255:0.901442;78,78,78,255"/>
          </colorramp>
          <item alpha="255" color="#fafafa" label="-74" value="-74"/>
          <item alpha="255" color="#e4e4e4" label="65.06" value="65.063"/>
          <item alpha="255" color="#cdcdcd" label="133.4" value="133.416"/>
          <item alpha="255" color="#b6b6b6" label="190" value="189.984"/>
          <item alpha="255" color="#050505" label="2281" value="2280.643"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0"/>
    <huesaturation saturation="0" colorizeGreen="128" colorizeRed="255" grayscaleMode="0" colorizeOn="0" colorizeBlue="128" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
