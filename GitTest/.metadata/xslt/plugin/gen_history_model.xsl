<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="databaseModel" select="document('param:databaseModel')/*"/>
	
	<xsl:template match="/">
		<config>
			<model>
				<entities>
					<xsl:apply-templates select="historyPlugin[@enable='true']"/>
				</entities>
			</model>			
		</config>	
	</xsl:template>
	
	<xsl:template match="historyPlugin">
		<xsl:apply-templates select="instanceTables"/>
		<xsl:apply-templates select="masterTables"/>
		<xsl:apply-templates select="referenceDataTables"/>
	</xsl:template>
	
	<xsl:template match="instanceTables/instanceTable">
		<xsl:variable name="entityName" select="@entityName" />
		<entity name="{@entityName}" layer="instance">
			<xsl:if test="@allColumns='false'">	
				<xsl:call-template name="instanceColumns"/>
			</xsl:if>	
			<xsl:if test="@allColumns='true'">
				<xsl:call-template name="allInstanceColumns"/>                
			</xsl:if>
		</entity>		
	</xsl:template>
	<xsl:template name="instanceColumns">	
		<columns>
			<xsl:for-each select="instanceColumns/instanceColumn">
				<column name="{@name}" traced="{@trace}" searchable="{@searchable}"/>
			</xsl:for-each>
		</columns>
	</xsl:template>	
	<xsl:template name="allInstanceColumns">
		<xsl:variable name="entityName" select="@entityName" />			
		<columns>
			<xsl:for-each select="$databaseModel/instanceTables/*[@name=$entityName]/columns/column[not((substring(@name,1,4))='eng_')]">
				<column name="{@name}" traced="true" searchable="false"/>
			</xsl:for-each>
		</columns>
	</xsl:template>		
	
	<xsl:template match="masterTables/masterTable">
		<xsl:variable name="entityName" select="@entityName" />					
		<xsl:variable name="layerName">
				<xsl:value-of select="fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$2')"/>
		</xsl:variable>
		<entity name="{fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$1')}" layer="master">
			<xsl:attribute name="masterView">
				<xsl:value-of select="$layerName"/>
			</xsl:attribute>
			<xsl:if test="@allColumns='false'">	
				<xsl:call-template name="masterColumns"/>
			</xsl:if>	
			<xsl:if test="@allColumns='true'">
				<xsl:call-template name="allMasterColumns"/>                
			</xsl:if>
		</entity>	
	</xsl:template>
	
	<xsl:template name="masterColumns">	
		<columns>
			<xsl:for-each select="masterColumns/masterColumn">
				<column name="{@name}" traced="{@trace}" searchable="{@searchable}"/>
			</xsl:for-each>
		</columns>
	</xsl:template>	
	<xsl:template name="allMasterColumns">
		<xsl:variable name="entityName" select="fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$1')" />
		<xsl:variable name="layerName" select="fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$2')" />
		<columns>
			<xsl:for-each select="$databaseModel/masterTables/*[(@name=$entityName) and (@layerName=$layerName)]/columns/column[not((substring(@name,1,4))='eng_')]">
				<column name="{@name}" traced="true" searchable="false"/>
			</xsl:for-each>
		</columns>
	</xsl:template>		

	<xsl:template match="referenceDataTables/referenceDataTable">
		<xsl:variable name="entityName" select="@entityName" />
		<entity name="{@entityName}" layer="instance">
			<xsl:if test="@allColumns='false'">	
				<xsl:call-template name="referenceDataColumns"/>
			</xsl:if>	
			<xsl:if test="@allColumns='true'">
				<xsl:call-template name="allReferenceDataColumns"/>                
			</xsl:if>
		</entity>	
	</xsl:template>	
	<xsl:template name="referenceDataColumns">	
		<columns>
			<xsl:for-each select="referenceDataColumns/referenceDataColumn">
				<column name="{@name}" traced="{@trace}" searchable="{@searchable}"/>
			</xsl:for-each>
		</columns>
	</xsl:template>	
	<xsl:template name="allReferenceDataColumns">
		<xsl:variable name="entityName" select="@entityName" />	
		<columns>
			<xsl:for-each select="$databaseModel/refData/*[@name=$entityName]/columns/column[not((substring(@name,1,4))='eng_')]">
				<column name="{@name}" traced="true" searchable="false"/>
			</xsl:for-each>
		</columns>
	</xsl:template>			
	
</xsl:stylesheet>