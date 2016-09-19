<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:param name="masterModels" select="document('param:masterModels')/*"/>  <!--/logicalModel/masterModels -->
	<xsl:param name="settings" select="document('param:settings')/*"/>  <!--/settings -->
	<xsl:param name="modelName" select="document('param:modelName')/*"/>  <!-- /preview/guiPreview/model[@enabled=&#39;true&#39;] -->
	<xsl:param name="tableName" select="document('param:tableName')/*"/>  <!-- ../../../../. -->
	<xsl:include href="incl_gui_templates.xsl"/>
	
	<!-- bound to preview/guiPreview/masterModels/model/masterTables/masterTable/templates/template/detailTemplates/detailTemplate -->
	<xsl:template match="detailTemplate">
		<xsl:variable name="model_name" select="$modelName/@name" />
		<xsl:variable name="table_name" select="$tableName/@name" />
		<xsl:variable name="dest_table_name" select="$masterModels/masterModel[@name=$model_name]/*/*[@name=$table_name]/guiTab/views/detailView/groups/labeledRelatedMNList[@relationship=current()/@relationship]/@entity_out" />
		
		
		
		<template>
			<mappings>
				<contextType>ROW</contextType>
				<slot>HIERARCHY_RELATION_ROW</slot>
				<!-- <entity><xsl:value-of select="$table_name"/></entity> -->
				<entity><xsl:value-of select="$dest_table_name"/></entity>
				<refRelation>rev_<xsl:value-of select="@relationship"/></refRelation>
			</mappings>

			<content>
				<!-- <relationRowLabel dataFormat="&lt;div style=&quot;color:blue;&quot;&gt;${id} ${cmo_company_name}&lt;/div&gt;" /> -->
				<relationRowLabel>
					<xsl:attribute name="dataFormat">
			      		<xsl:text>&lt;div style=&quot;color:blue;&quot;&gt;${id}</xsl:text>
			      		<!-- uses breadcrumb view to define the label -->
			      		<!--  /masterTables/masterTable -->
			      		<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/*/*[lower-case(@name)=lower-case($dest_table_name)]/guiTab/views/breadcrumbView/columns/column">
			      			<xsl:text>${</xsl:text><xsl:value-of select="@name" /><xsl:text>} </xsl:text>
			      		</xsl:for-each>
			      		<xsl:text>${rev_</xsl:text><xsl:value-of select="@relationship"/><xsl:text>.</xsl:text><xsl:value-of select="$masterModels/masterModel[@name=$model_name]/*/*[@name=$table_name]/guiTab/views/detailView/groups/labeledRelatedMNList[@relationship=current()/@relationship]/hierarchyParams/@relationshipType"/><xsl:text>}</xsl:text>
			      		<xsl:text>&lt;/div&gt;</xsl:text>
			      	</xsl:attribute>
				</relationRowLabel>
			</content>
		</template>
	</xsl:template>
</xsl:stylesheet>