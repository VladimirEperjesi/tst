<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:param name="masterModels" select="document('param:masterModels')/*"/>  <!--/logicalModel/masterModels -->
	<xsl:param name="settings" select="document('param:settings')/*"/>  <!--/settings -->
	<xsl:param name="modelName" select="document('param:modelName')/*"/>  <!-- /preview/guiPreview/model[@enabled=&#39;true&#39;] -->
	<xsl:param name="mnRelationship" select="document('param:mnRelationship')/*"/>  <!-- . -->
	<!--  <xsl:include href="incl_gui_templates.xsl"/> -->
	
	<!-- bound to preview/guiPreview/mnRelationships/mnRelationship -->
	<xsl:template match="mnRelationship">
		<xsl:variable name="model_name" select="$modelName/@name" />
		<xsl:variable name="table_name" select="$mnRelationship/@name" />
		<xsl:variable name="lable_name" select="$mnRelationship/label|$mnRelationship/@label" />

		<template>
			<mappings>
				<contextType>ROW</contextType>
				<slot>HIERARCHY_ROW</slot>
				<entity><xsl:value-of select="$table_name"/></entity>
			</mappings>
			<content>
				<relationRowLabel>
					<xsl:attribute name="dataFormat">
						<!--  color:blue -->
						<!--  todo <span style="color:red;">${id}</span>
							style=&quot;color:#67AD31;font-size:0.9em; -->
			      		<xsl:text>&lt;div style=&quot;color:#67AD31;&quot;&gt;</xsl:text> 
			      		<!-- ID: ${id}&lt;br/&gt;   -->
			      		<!-- <xsl:text>${</xsl:text><xsl:value-of select="$lable_name"/><xsl:text>}</xsl:text> -->
			      		<xsl:value-of select="$lable_name"/>
			      		<xsl:text>&lt;/div&gt;</xsl:text>
			      	</xsl:attribute>
				</relationRowLabel>
			</content>
		</template>
	</xsl:template>
</xsl:stylesheet>