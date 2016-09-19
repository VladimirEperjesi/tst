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
			<!-- <tmp-model><xsl:value-of select="$model_name"/></tmp-model> -->
			<mappings>
				<contextType>ROW</contextType>
				<slot>DATA_ROW_DETAIL_TAB</slot>
				<entity><xsl:value-of select="$table_name"/></entity>
			</mappings>
			<!-- label -->
			<slotOptions>
				<!-- breadcrumb view template -->
				<option name="removeHeaderBar" />
				<!-- <option name="contentDataLabel" value="${cmo_first_name} ${cmo_last_name} ${cmo_company_name}" /> -->
				<option name="contentDataLabel">
					<xsl:attribute name="value">
			      		<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/breadcrumbView/columns/column">
			      			<xsl:text>${</xsl:text><xsl:value-of select="@name" /><xsl:text>} </xsl:text>
			      		</xsl:for-each>
			      	</xsl:attribute>
				</option>
			</slotOptions>
			<setup>
	       		<parts>            
		            <definitions>		                
		            	<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/*">		                
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
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='left']"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='left']" />
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='left']"/>
								</div>
								<!-- </xsl:if> -->
								<!-- right panel -->
								<div classes="mda-halfWidthPanel">
									<!-- detail view template -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='right']"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='right']" />
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='right']" />
								</div>
							</div>
								<!-- bottom panel / left to right panel -->
								<div id="bottom" style="display:inline-block; width:100%;">
									<!-- detail view template -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledGroup[@templatePosition='bottom']"/>
									<!-- 1:N entities -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedList[@templatePosition='bottom']" />
									<!-- MN relation -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/labeledRelatedMNList[@templatePosition='bottom']" />
									<!-- instances -->
									<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiTab/views/detailView/groups/listGrid">
										 <xsl:with-param name="masterModels" select="$masterModels"/>
										 <xsl:with-param name="model_name" select="$model_name"/>
										 <xsl:with-param name="table_name" select="$table_name"/>
									</xsl:apply-templates>
								</div>
						</div>
					</div>
				</div>
			</content>
		</template>
	</xsl:template>
</xsl:stylesheet>