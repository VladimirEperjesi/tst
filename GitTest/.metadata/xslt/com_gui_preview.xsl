<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<xsl:param name="databaseModel" select="document('param:databaseModel')/*"/> <!-- /preview/databaseModel -->

<!-- Bound to /logicalModel -->
<xsl:template match="/logicalModel">
	<guiPreview>
		<masterModels>
			<!-- <xsl:apply-templates select="masterModels/masterModel[@enableGui='true']"> -->
			<xsl:apply-templates select="masterModels/masterModel">
				<xsl:with-param name="instanceTables" select="/logicalModel/instanceModel/tables"/>
				<xsl:with-param name="dicTables" select="/logicalModel/dictionary/tables"/>
			</xsl:apply-templates>
		</masterModels>
  </guiPreview>
</xsl:template>

<xsl:template match="masterModel">
<xsl:param name="instanceTables"/>
<xsl:param name="dicTables"/>
	<model name="{lower-case(@name)}" enabled="{guiConfig/@enableGui}">
		<xsl:variable name="modelName" select="@name"/> 
		<masterTables>
			<xsl:apply-templates select="masterTables/masterTable" />
		</masterTables>
		<instanceTables>
			<xsl:apply-templates select="instanceTables/instanceTable" >	
				<xsl:with-param name="instanceTables" select="$instanceTables"/></xsl:apply-templates>
		</instanceTables>
		<!-- add rd_ tables into GUI preview-->
		<dictionaryTables>
			<!-- rewrite into apply template -->
			<xsl:variable name="refData" select="masterTables/masterTable/columns/column/@refData"/>	
			<xsl:for-each select="$dicTables/table[@loadMas='true' and @name=$refData]">
				<xsl:variable name="dicTableName" select="concat('rd_',@name)"/>
				<dictionaryTable name="rd_{lower-case(@name)}" label="{@name}" topLevel="false">
					<columns>
						<xsl:for-each select="$databaseModel/refData/physicalTable[@name=lower-case($dicTableName)]/columns/column[@load='true']">
							<xsl:variable name="columnPrefix" select="fn:replace(@name,'^(eng|src|std|cio|exp|sco|dic)_(.+)$','$1')"/>
							<xsl:if test="$columnPrefix != 'eng'">
								<column name="{lower-case(@name)}" type="{if(@type='long_int') then 'long' else @type}" label="{@name}"/>
							</xsl:if>
						</xsl:for-each> 
					</columns>
				</dictionaryTable>
			</xsl:for-each> 
		</dictionaryTables>
		
		<relationships>
			<xsl:apply-templates select="relationships/relationship"> 
				<xsl:with-param name="instance" select="instanceTables"/>
				<xsl:with-param name="master" select="masterTables"/>
			</xsl:apply-templates>
			<!-- add relationships for rd_ tables into GUI preview-->
			<xsl:variable name="masterTable" select="masterTables/masterTable"/>
			<xsl:for-each select="$databaseModel/masterTables/physicalTable[@layerName=$modelName]">
			<xsl:variable name="child" select="@name"/> 
			<xsl:for-each select="relationships/relationship[substring(@parentTable,1,3)='rd_']"> <!-- [substring(@parentTable,1,3)='rd_']-->
				<xsl:variable name="childLabel" select="$masterTable[@name=$child]/@label"/>
				<xsl:variable name="parentLabel" select="substring(@parentTable,4)"/>
				<relationship name="{lower-case(@name)}" label="{$parentLabel} is used on {$childLabel}/{@childColumn}" parentRole="master_code" childRole="master_details" parentTable="{@parentTable}" childTable="{@childTable}" parentFk="{@parentColumn}" childFk="{@childColumn}" parentLabel="{$parentLabel}" childLabel="{$childLabel}" />
			</xsl:for-each>
			</xsl:for-each> 
		</relationships>	
		<mnRelationships>
			<xsl:for-each-group select="guiConfig/hierarchies/hierarchyMN" group-by="@tableMN">
				<mnRelationship name="{@tableMN}" label="{hierarchyDisplaySettings/relationshipLabel}" />	
			</xsl:for-each-group> 	
		</mnRelationships>
	</model>
</xsl:template>

<xsl:template match="masterTable">
	<masterTable name="{lower-case(@name)}" label="{sf:nvl(@label,@name)}" topLevel="{@topLevel}">
		<xsl:variable name="instTableName" select="@instanceTable"/>
		<columns>
			<column name="eng_active" type="boolean" label="Active" indexType="NOT_ANALYZED"/>
			<xsl:if test="guiTab/reduceES/@allColumns='true'">		
				<!--<column name="eng_origin" type="string" label="Origin" indexType="NOT_ANALYZED"/>
				<column name="eng_source_system" type="string" label="Source System" indexType="NOT_ANALYZED"/>-->
				<column name="eng_last_update_date" type="datetime" label="Last Update Date" indexType="NOT_ANALYZED"/>	
				<xsl:apply-templates select="columns/column" mode="master">
					<xsl:with-param name="instTableName" select="$instTableName"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="guiTab/computedColumns/column" mode="computed_m"/>
				<xsl:apply-templates select="advanced/specialColumns/column" mode="special">
					<xsl:with-param name="rc" select="guiTab/reduceES/reduceColumns/reduceColumn"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="guiTab/reduceES/@allColumns='false'">
				<xsl:variable name="rc" select="guiTab/reduceES/reduceColumns/reduceColumn"/>
				<xsl:for-each select="$rc[substring(@name,1,4)='eng_']">
					<column name="eng_last_update_date" type="datetime" label="Last Update Date" indexType="{if(@indexType!='') then @indexType else 'NOT_ANALYZED'}"/>	
				</xsl:for-each>									
				<xsl:for-each select="columns/column[concat('cmo_',@name)=../../guiTab/reduceES/reduceColumns/reduceColumn/@name or @name=../../guiTab/reduceES/reduceColumns/reduceColumn/@name]">
					<xsl:variable name="cmoCurrentColumn" select="concat('cmo_',@name)"/>
					<xsl:variable name="currentColumn" select="@name"/>
					<xsl:variable name="instLabel" select="/logicalModel/instanceModel/tables/table[@name=$instTableName]/columns/column[@name=$currentColumn]/@label"/>
					<xsl:variable name="indexType">
						<xsl:choose>
							<xsl:when test="$rc[@name=$currentColumn or @name=$cmoCurrentColumn]/@indexType!=''">
								<xsl:value-of select="$rc[@name=$currentColumn or @name=$cmoCurrentColumn]/@indexType"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="@isCmo='true'">
							<column name="cmo_{fn:lower-case(@name)}" type="{if(@type='long_int') then 'long' else @type}" label="{sf:nvl(@label,$instLabel,@name)}" indexType="{$indexType}"/>
						</xsl:when>
						<xsl:otherwise>
							<column name="{fn:lower-case(@name)}" type="{if(@type='long_int') then 'long' else @type}" label="{sf:nvl(@label,$instLabel,@name)}" indexType="{$indexType}"/>
						</xsl:otherwise>
					</xsl:choose>		
				</xsl:for-each>				
				<xsl:apply-templates select="guiTab/computedColumns/column" mode="computed_m"/>				
				<xsl:apply-templates select="advanced/specialColumns/column[@name=$rc/@name]" mode="special">
					<xsl:with-param name="rc" select="$rc"/>
				</xsl:apply-templates>					
			</xsl:if>
		</columns>
		<templates>
			<xsl:for-each select="guiTab/views/*">
				<template>
					<xsl:attribute name="templateType">
			      		<xsl:value-of select="name(.)"/>
			      	</xsl:attribute> 
					<detailTemplates>
						<xsl:for-each select="groups/*">
							<detailTemplate name="{@name}" relationship="{@relationship}" templatePosition="{@templatePosition}">
								<xsl:attribute name="templateType">
			      					<xsl:value-of select="name(.)"/>
			      				</xsl:attribute>
							</detailTemplate>
						</xsl:for-each>
					</detailTemplates>
				</template>
			</xsl:for-each>
		</templates>
	</masterTable>
</xsl:template>

<xsl:template match="instanceTable">
<xsl:param name="instanceTables"/>
	<instanceTable name="{lower-case(@name)}" label="{sf:nvl(@label,@name)}" topLevel="{@topLevel}">
		<xsl:variable name="instanceTableName" select="lower-case(@instanceTable)"/>
		<xsl:variable name="customLabel" select="labelDefinition/columns/column[@name=current()/@name]/@customLabel"/>
		<columns>
			<column name="eng_active" type="boolean" finalLabel="Active" indexType="NOT_ANALYZED"/>
			<xsl:if test="guiTab/reduceES/@allColumns='true'">
				<column name="eng_origin" type="string" finalLabel="Origin" indexType="NOT_ANALYZED"/>
				<column name="eng_source_system" type="string" finalLabel="Source System" indexType="NOT_ANALYZED"/>
				<column name="eng_last_update_date" type="datetime" finalLabel="Last Update Date" indexType="NOT_ANALYZED"/>
				<column name="eng_source_timestamp" type="datetime" finalLabel="Source Timestamp" indexType="NOT_ANALYZED"/>
				<xsl:variable name="empty" select="''"/>
				<xsl:apply-templates select="$databaseModel/instanceTables/physicalTable[@name=$instanceTableName]/columns/column[@load='true']" mode="instance">
					<xsl:with-param name="instanceTableName" select="$instanceTableName"/>
					<xsl:with-param name="labelDefinition" select="."/>
					<xsl:with-param name="instanceTables" select="$instanceTables"/>
					<xsl:with-param name="indexType" select="'BOTH'"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="guiTab/computedColumns/column" mode="computed_i"/>
			</xsl:if>
			<xsl:if test="guiTab/reduceES/@allColumns='false'">
				<xsl:variable name="rc" select="guiTab/reduceES/reduceColumns/reduceColumn"/>
				<xsl:for-each select="$rc[substring(@name,1,4)='eng_']">			
					<xsl:if test="@name='eng_origin'">
						<column name="eng_origin" type="string" finalLabel="Origin" indexType="{if(@indexType!='') then @indexType else 'NOT_ANALYZED'}"/>
					</xsl:if>
					<xsl:if test="@name='eng_source_system'">
						<column name="eng_source_system" type="string" finalLabel="Source System" indexType="{if(@indexType!='') then @indexType else 'NOT_ANALYZED'}"/>
					</xsl:if>
					<xsl:if test="@name='eng_last_update_date'">
						<column name="eng_last_update_date" type="datetime" finalLabel="Last Update Date" indexType="{if(@indexType!='') then @indexType else 'NOT_ANALYZED'}"/>		
					</xsl:if>
					<xsl:if test="@name='eng_source_timestamp'">
						<column name="eng_source_timestamp" type="datetime" finalLabel="Source Timestamp" indexType="{if(@indexType!='') then @indexType else 'NOT_ANALYZED'}"/>		
					</xsl:if>					
				</xsl:for-each>					
				<xsl:apply-templates select="$databaseModel/instanceTables/physicalTable[@name=$instanceTableName]/columns/column[@load='true' and @name=$rc/@name]" mode="instance">
					<xsl:with-param name="instanceTableName" select="$instanceTableName"/>
					<xsl:with-param name="labelDefinition" select="."/>
					<xsl:with-param name="instanceTables" select="$instanceTables"/>
					<xsl:with-param name="rc" select="$rc"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="guiTab/computedColumns/column" mode="computed_i"/>
			</xsl:if>			
		</columns>
		<templates>
			<xsl:for-each select="guiTab/views/*">
				<template>
					<xsl:attribute name="templateType">
			      		<xsl:value-of select="name(.)"/>
			      	</xsl:attribute> 
					<detailTemplates>
						<xsl:for-each select="groups/*">
							<detailTemplate name="{@name}" relationship="{@relationship}" templatePosition="{@templatePosition}">
								<xsl:attribute name="templateType">
			      					<xsl:value-of select="name(.)"/>
			      				</xsl:attribute>
							</detailTemplate>
						</xsl:for-each>
					</detailTemplates>
				</template>
			</xsl:for-each>
		</templates>
	</instanceTable>
</xsl:template>

<xsl:template match="column" mode="master">
	<xsl:param name="instTableName"/>
	<xsl:variable name="currentColumn" select="@name"/>
	<xsl:variable name="instLabel" select="/logicalModel/instanceModel/tables/table[@name=$instTableName]/columns/column[@name=$currentColumn]/@label"/>
	<xsl:choose>
		<xsl:when test="@isCmo='true'">
			<column name="cmo_{fn:lower-case(@name)}" type="{if(@type='long_int') then 'long' else @type}" label="{sf:nvl(@label,$instLabel,@name)}" indexType="{if(@indexType!='') then @indexType else ''}"/>
		</xsl:when>
		<xsl:otherwise>
			<column name="{fn:lower-case(@name)}" type="{if(@type='long_int') then 'long' else @type}" label="{sf:nvl(@label,$instLabel,@name)}" indexType="{if(@indexType!='') then @indexType else ''}"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template match="column" mode="instance">
	<xsl:param name="instanceTableName"/>
	<xsl:param name="labelDefinition"/>
	<xsl:param name="instanceTables"/>
	<xsl:param name="indexType"/>
	<xsl:param name="rc"/>
	<xsl:variable name="currentColumn" select="@name"/>
	<xsl:variable name="curIndexType">
		<xsl:choose>
			<xsl:when test="$rc[@name=$currentColumn]/@indexType!=''">
				<xsl:value-of select="$rc[@name=$currentColumn]/@indexType"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>		
	<xsl:variable name="columnName" select="fn:replace(@name,'^(src|std|cio|exp|sco|dic)_(.+)$','$2')"/> 
	<xsl:variable name="columnPrefix" select="fn:replace(@name,'^(eng|src|std|cio|exp|sco|dic)_(.+)$','$1')"/> 
	<!--<xsl:variable name="instanceLabel" select="/logicalModel/instanceModel/tables/table[@name=$instanceTableName]/columns/column[@name=$columnName]/@label"/>-->
	<xsl:variable name="instanceLabel" select="$instanceTables/table[lower-case(@name)=lower-case($instanceTableName)]/columns/column[@name=$columnName]/@label"/>
	<xsl:variable name="customLabel" select="$labelDefinition/columns/column[lower-case(@name)=lower-case(current()/@name)]/@customLabel"/>

	<xsl:if test="$columnPrefix != 'eng'">
		<column name="{fn:lower-case(@name)}" customLabel="{$customLabel}" type="{if(@type='long_int') then 'long' else @type}" indexType="{if($indexType!='') then '' else $curIndexType}">
			<xsl:attribute name="label">
				<xsl:if test="$instanceLabel !='' and $columnName != $columnPrefix">
					<xsl:value-of select="$instanceLabel"/><xsl:text> (</xsl:text><xsl:value-of select="$columnPrefix"/><xsl:text>)</xsl:text>
				</xsl:if>
				<xsl:if test="$instanceLabel !='' and $columnName = $columnPrefix">
					<xsl:value-of select="$instanceLabel"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="finalLabel">
				<xsl:choose>
					<xsl:when test="$customLabel != ''"><xsl:value-of select="$customLabel"/></xsl:when>
					<xsl:when test="$instanceLabel !='' and $columnName != $columnPrefix ">
						<xsl:value-of select="$instanceLabel"/><xsl:text> (</xsl:text><xsl:value-of select="$columnPrefix"/><xsl:text>)</xsl:text>
					</xsl:when>
					<xsl:when test="$instanceLabel !=''">
						<xsl:value-of select="$instanceLabel"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="lower-case($columnName)"/><xsl:if test="$columnName != $columnPrefix"><xsl:text> (</xsl:text><xsl:value-of select="$columnPrefix"/><xsl:text>)</xsl:text></xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</column>
	</xsl:if>
</xsl:template>

<xsl:template match="column" mode="computed_i">	
	<column name="{fn:lower-case(@name)}" customLabel="{@label}" type="{if(@dataType='long_int') then 'long' else @dataType}" searchable="{@searchable}" label="{@label}" finalLabel="{@finalLabel}" indexType="{if(@indexType!='') then @indexType else''}">
		<producer value="{@producer|producer}"/>
	</column>
</xsl:template>

<xsl:template match="column" mode="computed_m">
	<column name="{fn:lower-case(@name)}" type="{if(@dataType='long_int') then 'long' else @dataType}" searchable="{@searchable}" label="{@label}" indexType="{if(@indexType!='') then @indexType else''}">
		<producer value="{@producer|producer}"/>
	</column>
</xsl:template>

<xsl:template match="column" mode="special">
	<xsl:param name="rc"/>
	<xsl:variable name="columnName" select="@name"/>
	<xsl:variable name="indexType" select="$rc[@name=$columnName]/@indexType"/>
	<column name="{@name}" label="{@label}" type="{if(@type='long_int') then 'long' else @type}" indexType="{$indexType}"/>	
</xsl:template>

<xsl:template match="relationship">
	<xsl:param name="instance"/>
	<xsl:param name="master"/>
	<xsl:variable name="parent" select="@parentTable"/>
	<xsl:variable name="child" select="@childTable"/>
	<xsl:variable name="parentLabel" select="$instance/instanceTable[@name=$parent]/@label|$master/masterTable[@name=$parent]/@label"/>
	<xsl:variable name="childLabel" select="$instance/instanceTable[@name=$child]/@label|$master/masterTable[@name=$child]/@label"/>
	<xsl:variable name="ignoreRel" select="advanced/@ignoreRelGui"/>
	
	<!-- self-reference was disabled for MDA
	<xsl:if test="@childTable != @parentTable">
	</xsl:if> -->
	<!-- self-relationship is now generated + validation is added -->
	<xsl:if test="$ignoreRel='false'">
		<relationship name="{lower-case(@name)}" label="{@label}" type="{if(@type='long_int') then 'long' else @type}" parentRole="{@parentRole}" childRole="{@childRole}" parentTable="{lower-case(@parentTable)}" childTable="{lower-case(@childTable)}" parentFk="{foreignKey/column/@parentColumn}" childFk="{foreignKey/column/@childColumn}" parentLabel="{sf:nvl($parentLabel,@parentTable)}" childLabel="{sf:nvl($childLabel,@childTable)}" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>