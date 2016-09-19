<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:param name="masterModels" select="document('param:masterModels')/*"/>  <!--/logicalModel/masterModels -->
	<xsl:param name="settings" select="document('param:settings')/*"/>  <!--/settings -->
	<xsl:param name="modelName" select="document('param:modelName')/*"/>  <!-- /preview/guiPreview/model[@enabled=&#39;true&#39;] -->
	<xsl:include href="incl_gui_templates.xsl"/>

	<!-- bound to preview/guiPreview/masterModels/model/masterTables/masterTable -->
	<xsl:template match="/masterTable">
		<xsl:variable name="model_name" select="$modelName/@name" />
		<xsl:variable name="table_name" select="@name" />
		<template>
			<mappings>
				<contextType>ROW</contextType>
				<slot>HIERARCHY_ROW</slot>
				<entity><xsl:value-of select="$table_name"/></entity>
			</mappings>

			<content>
				<!-- <relationRowLabel dataFormat="&lt;div style=&quot;color:blue;&quot;&gt;${id} ${cmo_company_name}&lt;/div&gt;" /> -->
				<relationRowLabel>
					<xsl:attribute name="dataFormat">
						<!--  todo &lt;span style="&quot;color:#67AD31;font-size:0.9em;"&gt;ID: ${id}&lt;br/&gt;&lt;d/span&gt; 	-->
							
			      		<xsl:text>&lt;div style=&quot;color:#67AD31;&quot;&gt;ID: ${id}&lt;br/&gt;</xsl:text>
			      		<!-- uses breadcrumb view to define the label -->
			      		<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/breadcrumbView/columns/column">
			      			<xsl:text>${</xsl:text><xsl:value-of select="@name" /><xsl:text>} </xsl:text>
			      		</xsl:for-each>
			      		<xsl:text>&lt;/div&gt;</xsl:text>
			      	</xsl:attribute>
				</relationRowLabel>
			</content>
		</template>
	</xsl:template>
</xsl:stylesheet>