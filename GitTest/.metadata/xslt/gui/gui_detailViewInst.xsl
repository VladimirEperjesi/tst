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

	<!-- bound to preview/guiPreview/masterModels/model/instanceTables/instanceTable -->
	<xsl:template match="/instanceTable">
	<xsl:variable name="model_name" select="$modelName/@name"/>
	<xsl:variable name="table_name" select="@name"/>
		<template>
			<!-- <tmp-model><xsl:value-of select="$model_name"/></tmp-model> -->
			<mappings>
				<contextType>ROW</contextType>
				<slot>DATA_ROW_DETAIL_TAB</slot>
				<entity><xsl:value-of select="$table_name"/></entity>
			</mappings>
			<setup>
		      	<parts>            
		            <definitions>		                
		            	<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/*">		                
		                	<xsl:if test="viewCondition!=''">
		                		<part name="{@name}" condition="{viewCondition}"/>
		                	</xsl:if>
		                </xsl:for-each>
		            </definitions>
		            <providers></providers>
		        </parts>
		    </setup>
			<content>
	    		<div style="height:100%; width:100%;">
					<div classes="scrollContent">
						<div classes="mda-limitWidthContentContainer">
							<div classes="mda-columnsPanel">
								<!-- left panel -->
								<!-- <xsl:if test="templates/template/detailTemplates/detailTemplate[@templatePosition='left']"> -->
								<div classes="mda-halfWidthColumn">
									<!-- detail view template -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='left']" mode="readOnly"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='left']" /> <!-- mode="readOnly" -->
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='left']" /> <!-- mode="readOnly" -->
								</div>
								<!-- </xsl:if> -->
								<!-- right panel -->
								<div classes="mda-halfWidthPanel">
									<!-- detail view template -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='right']" mode="readOnly"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='right']" /> <!-- mode="readOnly" -->
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='right']" /> <!-- mode="readOnly" --> 								
								</div>							
							</div>
							<!-- bottom panel / left to right panel -->							
								<div id="bottom" style="display:inline-block; width:100%;">
									<!-- detail view template -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='bottom']" mode="readOnly"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='bottom']"  /> <!-- mode="readOnly" --> 
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='bottom']"  /> <!-- mode="readOnly" -->
									<!--  instances -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/listGrid"  mode="readOnly" />
								</div>
						</div>
					</div>
				</div>
	  		</content>
		</template>  
	</xsl:template>
</xsl:stylesheet>