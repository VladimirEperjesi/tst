<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/>  <!-- /settings/advancedSettings -->
<xsl:param name="nativeServices" select="document('param:nativeServices')/*"/>
<xsl:param name="logicalModel" select="document('param:logicalModel')/*"/>

<xsl:variable name="dropAlternative" select="$settings/@alternativeKeys"/>
<xsl:variable name="srcStringLength" select="$settings/@srcStringLength"/>
<xsl:variable name="expStringLength" select="$settings/@expStringLength"/>
<!-- Bound to /logicalModel -->
<xsl:template match="/*">
<xsl:variable name="dictionary" select="dictionary"/>
	<databaseModel>
		<instanceTables>
			<xsl:for-each select="instanceModel/*/table">
				<xsl:call-template name="instanceTable">
					<xsl:with-param name="dictionary" select="$dictionary"/>
					<xsl:with-param name="tables" select=".."/>
				</xsl:call-template>
			</xsl:for-each>
		</instanceTables>
		<masterTables>
			<xsl:for-each select="masterModels/masterModel/masterTables/masterTable">
				<xsl:call-template name="masterTable">
				</xsl:call-template>
			</xsl:for-each>
		</masterTables>
		<refData>
			<xsl:apply-templates select="dictionary/tables/table[@loadInst='true']">
				<xsl:with-param name="mode" select="'inst'"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="dictionary/tables/table[@loadMas='true']">
				<xsl:with-param name="mode" select="'mas'"/>
			</xsl:apply-templates>
		</refData>
		<lookups>
			<xsl:apply-templates select="dictionary/tables/table[@instUse!='none']">
				<xsl:with-param name="mode" select="'inst'"/>
			</xsl:apply-templates>
		</lookups>
  </databaseModel>
</xsl:template>

<!-- TABLE templates -->
<xsl:template name="instanceTable">
	<xsl:param name="dictionary"/>
	<xsl:param name="tables"/>
	<xsl:variable name="tableName" select="@name" />
	<physicalTable name="{lower-case(@name)}" layerName="instance" description="{description}">
		<xsl:variable name="tableName" select="lower-case(@name)"/>
		<xsl:variable name="layerName" select="'instance'"/>
		<xsl:attribute name="type">
			<xsl:if test="fn:boolean(ancestor::dicTables)">dictionary</xsl:if>
			<xsl:if test="fn:boolean(ancestor::tables)">instance</xsl:if>	
		</xsl:attribute>
		<columns>
		<!-- table keys -->		
			<column name="id" type="long_int" origin="internal" isFk="false" isPk="false" dqcType="long" description="{concat(upper-case(substring(@name,1,1)),substring(@name, 2),' '[not(last())])} ID" /> <!-- size="30" -->
			<column name="eng_source_timestamp" type="datetime" origin="internal" dqcType="datetime" eng="true" description="Source Timestamp" />
			<!-- audit pseudocolumns -->
		    <xsl:call-template name="pseudocolumns_inst"/> 
		    <!-- eng_match_isolate -->
		    <!-- todo:  matchException in not a part of native service, but it is setting on entity's matching tab
		    <xsl:variable name="name" select="@name"/>
			<xsl:variable name="entityName" select="nativeServices/configurableServices/matchException/@entity"/>
			 and $nativeServices/configurableServices/matchException[@entity=$name]   -->
			<!-- matching attributes definition -->
			<xsl:if test="matchingTab[@matching='true' and $settings/@matchingCompatibility='false']">
				<xsl:if test="matchingTab/multipleMatching/@disableDefault='false'">	
					<column name="{lower-case(matchingTab/defaultMatchingDefinition/@masterIdColumn)}" type="long_int" origin="internal_match" size="" isFk="true" isPk="false" dqcType="long" description="{description}"/>
					<!--  <column name="{lower-case(matchingTab/defaultMatchingDefinition/@idKeeperFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean"/> -->
					<column name="{lower-case(matchingTab/defaultMatchingDefinition/@isolateFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean" description="{description}"/>		
				</xsl:if>
				<!-- multiple matchings -->
				<xsl:for-each select="matchingTab[@matching='true']/multipleMatching/matchingDefinitions/matchingDefinition">
					<column name="{lower-case(@masterIdColumn)}" type="long_int" origin="internal_match" size="" isFk="true" isPk="false" dqcType="long"/>
					<!--  <column name="{lower-case(@idKeeperFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean"/> -->
					<!-- isolate flag is an optional attribute -->
					<xsl:if test="@isolateFlagColumn != ''">	
						<column name="{lower-case(@isolateFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean"/>
					</xsl:if>
				</xsl:for-each>
				<!-- distinct rematch column  -->
				<!-- <xsl:for-each-group select="matchingTab[@matching='true']/multipleMatching/matchingDefinitions/matchingDefinition|matchingTab/defaultMatchingDefinition[ancestor::matchingTab/multipleMatching/@disableDefault='false']" group-by="@rematchFlagColumn">
					<column name="{lower-case(@rematchFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean"/>
				</xsl:for-each-group> -->
			</xsl:if>
			
			<!-- columns for old matching -->
			<xsl:if test="matchingTab[@matching='true' and $settings/@matchingCompatibility='true']">
				<column name="master_id" type="long_int" origin="internal_match" size="" isFk="true" isPk="false" dqcType="long" description="Master {@name} ID"/>
			</xsl:if>
			
			<!-- compound primary key -->
			<xsl:if test="count(columns/column[@isPk='true'])>1">
				<column name="source_id" type="string" size="1000" origin="internal" isFk="false" isPk="true" artificial="true" dqcType="string" description="Data Source ID">
					<compoundDefinition>
						<xsl:for-each select="columns/column[@isPk='true']">
							<column name="{fn:lower-case(@name)}" type="{@type}" dqcType="{if(@type='long_int') then 'long' else @type}" description="{description}"/>
						</xsl:for-each>
					</compoundDefinition>
				</column>
			</xsl:if>	
			<!-- compound foreign key - artificial compound column-->
			<xsl:if test="../../relationships/relationship[@childTable=$tableName and count(foreignKey/column)>1]"> 
				<xsl:call-template name="artificial_fk">
					<xsl:with-param name="tables" select="$tables"/>
					<xsl:with-param name="tableName" select="$tableName"/>
					<xsl:with-param name="mode" select="'compound'"/>
				</xsl:call-template>
			</xsl:if> 
		<!-- standard columns -->
			<xsl:apply-templates select="columns/column[@name != 'id' and @name != 'master_id' ]" mode="instance">
				<xsl:with-param name="dictionary" select="$dictionary"/>
				<xsl:with-param name="relationships" select="../../relationships[relationship/@childTable=$tableName]"/>
			</xsl:apply-templates>
		<!-- special columns -->	
			<xsl:apply-templates select="advanced/specialColumns/column" mode="special"/>
		<!-- historical columns -->
			<xsl:apply-templates select="advanced/historicalColumns/column" mode="historical"/>
		<!-- old value columns 
			<xsl:apply-templates select="advanced/oldValueColumns/column" mode="oldValue"/>-->
		<!-- matching columns -->	
			<xsl:for-each select="matchingTab[@matching='true']/matchingTabColumns/*">
				<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" origin="match" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" description="{description}"/>
			</xsl:for-each>
		<!-- aggregation columns -->
			<xsl:for-each select="aggregationTab[@aggregation='true']/aggregationTabColumns/*">
				<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" origin="aggregate" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" description="{description}"/>
			</xsl:for-each>		
		<!-- parent to child copy columns -->	
			<xsl:apply-templates select="../../relationships/*[lower-case(@childTable)=lower-case($tableName)]/parentToChild/column" mode="par2chld"/>
		<!-- child to parent copy columns -->
			<xsl:apply-templates select="../../relationships/*[lower-case(@parentTable)=lower-case($tableName)]/childToParent/column" mode="chld2par"/>
		<!-- relationships same system columns  -->
			<xsl:for-each select="../../relationships/relationship[lower-case(@childTable)=lower-case($tableName)]/advanced/extendedSameSystem">
				<xsl:if test="../extendedSameSystem[@enable='true' and @childColumn!='']">
					<column name="{lower-case(@childColumn)}" type="string" origin="source" size="100" extendedSS="true" dqcType="string" description="{description}"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="../../relationships/relationship[lower-case(@parentTable)=lower-case($tableName)]/advanced/extendedSameSystem">
				<xsl:if test="../extendedSameSystem[@enable='true' and @parentColumn!='']">
					<column name="{lower-case(@parentColumn)}" type="string" origin="source" size="100" extendedSS="true" dqcType="string" description="{description}"/>
				</xsl:if>
			</xsl:for-each>		
		</columns>
		<relationships>
			<xsl:apply-templates select="../../relationships/relationship[lower-case(@childTable)=lower-case($tableName)]" >
				<xsl:with-param name="tables" select="$tables"/>
				<xsl:with-param name="mode" select="'instance'"/>
				<xsl:with-param name="layerName" select="$layerName"/>
			</xsl:apply-templates>
		</relationships>
		<virtualColumns>
			<!-- distinct rematch column  -->
			<xsl:for-each-group select="matchingTab[@matching='true']/multipleMatching/matchingDefinitions/matchingDefinition|matchingTab/defaultMatchingDefinition[ancestor::matchingTab/multipleMatching/@disableDefault='false']" group-by="@rematchFlagColumn">
				<xsl:if test="@rematchFlagColumn != ''">	
					<column name="{lower-case(@rematchFlagColumn)}" type="boolean" origin="internal_match" size="" isFk="false" isPk="false" dqcType="boolean"/>
				</xsl:if>
			</xsl:for-each-group>
		</virtualColumns> 
	</physicalTable>
</xsl:template>

<xsl:template name="masterTable">
<xsl:variable name="tableName" select="@name" />
<xsl:variable name="layerName" select="lower-case(../../@name)"/>
<physicalTable name="{lower-case(@name)}" layerName="{lower-case(../../@name)}" customActivity="{advanced/@customActivity}" type="{@entityRole}" description="{description}">
	<xsl:variable name="layerName" select="lower-case(../../@name)"/>
	<columns>
		<column name="id" type="long_int" origin="merge" isFk="false" isPk="true" dqcType="long" description="{concat(upper-case(substring(@name,1,1)),substring(@name, 2),' '[not(last())])} ID" /> <!-- size="30" -->
		<xsl:call-template name="pseudocolumns_mas"/>
		<xsl:apply-templates select="columns/column[@name != 'id']" mode="master"/>
		<xsl:apply-templates select="advanced/specialColumns/column" mode="master"/>
	</columns>
	<relationships>
		<xsl:apply-templates select="../../relationships/relationship[@childTable=$tableName]">
			<xsl:with-param name="tables" select=".."/>
			<xsl:with-param name="mode" select="'master'"/>
			<xsl:with-param name="layerName" select="$layerName"/>
		</xsl:apply-templates>
		<!-- generated relationships for reference data -->
		<xsl:for-each select="columns/column[@refData != '']">
			<xsl:variable name="foreignKey">
				<xsl:choose>
					<xsl:when test="@isCmo='true'"><xsl:text>cmo_</xsl:text><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<relationship name="{lower-case($foreignKey)}_master_details" parentTable="{lower-case(concat('rd_',@refData))}"  childTable="{lower-case(../../@name)}" parentColumn="master_code" childColumn="{lower-case($foreignKey)}" />
			<!-- reverseName="master_codes_{$foreignKey}" parentEntity="rd_{@refData}" name="" parentColumn="master_code" foreignKeyColumn="{$foreignKey}"/> -->
		</xsl:for-each> 	
	</relationships>	
</physicalTable>
</xsl:template>

<!-- Reference data -->
<xsl:template match="table">
	<xsl:param name="mode"/>
	<xsl:variable name="tableName" select="lower-case(@name)"/>
	<physicalTable>
		<xsl:attribute name="name">
			<xsl:text>rd_</xsl:text><xsl:value-of select="fn:lower-case(@name)"/><xsl:if test="$mode='inst'">_trans</xsl:if>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="$mode='mas'">master_rd</xsl:when>
				<xsl:otherwise><xsl:text>translation_</xsl:text><xsl:value-of select="@instUse"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="layerName">
			<xsl:choose>
				<xsl:when test="$mode='mas'">Loaded_master</xsl:when>
				<xsl:when test="$mode='inst' and @loadInst='true'">Loaded_translation</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="description">
			<xsl:value-of select="description"/>
		</xsl:attribute>
		<columns>
			<column name="id" type="long_int" origin="merge" isFk="false" isPk="true" dqcType="long" description="{concat(upper-case(substring($tableName,1,1)),substring($tableName, 2),' '[not(last())])} ID"/>  <!-- size="30" -->		
			<xsl:call-template name="pseudocolumns_inst"/>		
			<xsl:if test="$mode='inst'">
				<xsl:call-template name="inst_dic_columns"/>
				<xsl:apply-templates select="columns/column[@instance='true']" mode="dic"/>
			</xsl:if>
			<xsl:if test="$mode='mas'">
				<xsl:call-template name="mas_dic_columns"/>
				<xsl:apply-templates select="columns/column[@master='true']" mode="dic"/>
			</xsl:if>
		</columns>
	<!--
	<xsl:attribute name="name">
			<xsl:value-of select="fn:lower-case(@name)"/><xsl:if test="$mode='mas'">_mas</xsl:if>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="$mode='mas'">master</xsl:when>
				<xsl:otherwise><xsl:text>instance_</xsl:text><xsl:value-of select="@instUse"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="layerName">
			<xsl:choose>
				<xsl:when test="$mode='mas'">Loaded_master</xsl:when>
				<xsl:when test="$mode='inst' and @loadInst='true'">Loaded_instance</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		<columns>
			<xsl:if test="$mode='inst'">
				<xsl:call-template name="inst_dic_columns"/>
				<xsl:apply-templates select="columns/column[@instance='true']" mode="dic"/>
			</xsl:if>
			<xsl:if test="$mode='mas'">
				<xsl:call-template name="mas_dic_columns"/>
				<xsl:apply-templates select="columns/column[@master='true']" mode="dic"/>
			</xsl:if>
		</columns> -->
	</physicalTable>
</xsl:template>

<!-- COLUMN templates -->
<xsl:template match="column" mode="instance">
<xsl:param name="dictionary"/>
<xsl:param name="relationships"/>
<xsl:variable name="tables" select="ancestor::tables"/>
<xsl:variable name="tableName" select="../../@name"/>
<xsl:variable name="columnName" select="@name"/>
<xsl:variable name="refDataName" select="@refData"/>
<xsl:choose>
	<xsl:when test="@isSrc='true' or @isCio='true' or @isStd='true' or @isSco='true' or @isExp='true' or @isPk='true' or @isFk='true'">
		<xsl:if test="@isPk='true'">	
			<xsl:choose>
				<!-- SOURCE_ID and ALTERNATIVE PKEY -->
				<xsl:when test="count(preceding-sibling::column[@isPk='true'])=0 and count(following-sibling::column[@isPk='true'])=0">
					<xsl:if test="fn:lower-case(@name)='source_id'"> 
						<column name="source_id" type="string" size="{@size}" origin="internal" isFk="{@isFk}" isPk="{@isPk}" originalPk="{@isPk}" originalFk="{@isFk}" dqcType="string" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}"/>	
					</xsl:if>			
					<xsl:if test="fn:lower-case(@name)!='source_id'">
					<column name="source_id" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="string" size="{@size}" origin="internal" isFk="{@isFk}" isPk="{@isPk}" artificial="true" dqcType="string">
						<compoundDefinition>
							<column name="{fn:lower-case(@name)}" type="{@type}"/>
						</compoundDefinition>
					</column>	
					<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" isFk="true" isPk="false"  originalPk="{@isPk}" originalFk="{@isFk}" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
						<xsl:attribute name="load">
							<xsl:if test="$dropAlternative='true'">false</xsl:if>
							<xsl:if test="$dropAlternative='false'">true</xsl:if>
						</xsl:attribute>
							<xsl:attribute name="origin">
							<xsl:if test="$dropAlternative='true'">internal</xsl:if>
							<xsl:if test="$dropAlternative='false'">source</xsl:if>
						</xsl:attribute>
					</column>
					</xsl:if>	
				</xsl:when>
				<!-- COMPOUND PKEY -->
				<xsl:when test="(count(preceding-sibling::column[@isPk='true'])>0 or count(following-sibling::column[@isPk='true'])>0)">
					<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" isFk="false" isPk="false"  originalPk="{@isPk}" originalFk="{@isFk}" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
						<xsl:attribute name="load">
							<xsl:if test="$dropAlternative='true'">false</xsl:if>
							<xsl:if test="$dropAlternative='false'">true</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="origin">
							<xsl:if test="$dropAlternative='true'">internal</xsl:if>
							<xsl:if test="$dropAlternative='false'">source</xsl:if>
						</xsl:attribute>
					</column>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="@isFk='true'"> 
			<!--<xsl:variable name="columnName" select="@name"/>-->
			<xsl:choose>				
				<!-- COMPOUND FK -->
				<xsl:when test="../../../../relationships/relationship[@childTable=$tableName and count(foreignKey/column)>1 and foreignKey/column/@childColumn=current()/@name]">
						<xsl:if test="@isPk='false'">
						<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}"  isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">					
							<xsl:attribute name="isFk">
								<xsl:choose>
									<xsl:when test="../../../../relationships/relationship[@childTable=$tableName and count(foreignKey/column)>1]/foreignKey/column[@childColumn=$columnName]">false</xsl:when>
									<xsl:otherwise><xsl:value-of select="@isFk"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="originalFk">
								<xsl:choose>
									<xsl:when test="../../../../relationships/relationship[@childTable=$tableName]/foreignKey/column[@childColumn=$columnName]">true</xsl:when>
									<xsl:otherwise>false</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="load">
							<xsl:if test="$dropAlternative='true'">false</xsl:if>
							<xsl:if test="$dropAlternative='false'">true</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="origin">
							<xsl:if test="$dropAlternative='true'">internal</xsl:if>
							<xsl:if test="$dropAlternative='false'">source</xsl:if>
						</xsl:attribute>
						</column>
						</xsl:if>
				</xsl:when>
				<!-- ALTERNATIVE FK - NOT STRING -->
				<xsl:when test="@type!='string'">
					<xsl:if test="@isPk='false'">
					<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}"  isPk="false" isFk="false" originalFk="true" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">		
						<xsl:attribute name="load">
							<xsl:if test="$dropAlternative='true'">false</xsl:if>
							<xsl:if test="$dropAlternative='false'">true</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="origin">
							<xsl:if test="$dropAlternative='true'">internal</xsl:if>
							<xsl:if test="$dropAlternative='false'">source</xsl:if>
						</xsl:attribute>
					</column>
					</xsl:if>
					<!-- artificial column -->
					<xsl:call-template name="artificial_fk">
						<xsl:with-param name="tables" select="$tables"/>
						<xsl:with-param name="tableName" select="$tableName"/>
						<xsl:with-param name="mode" select="'artificial'"/>
						<xsl:with-param name="columnName" select="@name"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="@isPk='false'">
						<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" origin="source" isFk="{@isFk}" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
		<xsl:if test="@isSrc='true' and @type='string'">			
			<column name="src_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('src_',$columnName)]/@customLabel),' (src)')}" type="string" size="{@size}" origin="source" isSrc="true" isFk="false" isPk="false" dqcType="string" refData="{@refData}" instUse="{$dictionary/tables/table[@name=$refDataName]/@instUse}" usageValidation="{$dictionary/tables/table[@name=$refDataName]/@usageValidation}"/>
	    </xsl:if>
		<xsl:if test="@isSrc='true' and @type!='string'">
			<column name="src_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('src_',$columnName)]/@customLabel),' (src)')}" type="string" size="{$srcStringLength}" origin="source" isSrc="true" isFk="false" isPk="false" dqcType="string" refData="{@refData}" instUse="{$dictionary/tables/table[@name=$refDataName]/@instUse}"/>
		</xsl:if>		
		<xsl:if test="@isStd='true'">
			<column name="std_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('std_',$columnName)]/@customLabel),' (std)')}" type="{@type}" size="{@size}" origin="clean" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}"/>
		</xsl:if>		
		<xsl:if test="@isCio='true'">
			<column name="cio_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('cio_',$columnName)]/@customLabel),' (cio)')}" type="{@type}" size="{@size}" origin="clean" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}"/>
		</xsl:if>		
		<xsl:if test="@isExp='true'">
			<column name="exp_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel),' (exp)')}" type="string" size="{$expStringLength}" origin="clean" isFk="false" isPk="false" dqcType="string"/>
		</xsl:if>		
		<xsl:if test="@isSco='true'">
			<column name="sco_{fn:lower-case(@name)}" description="{concat(sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('sco_',$columnName)]/@customLabel),' (sco)')}" type="integer" origin="clean" isFk="false" isPk="false" dqcType="integer" />  <!-- size="10"  -->
		</xsl:if>	
		<xsl:if test="@isSrc='true' and @refData != ''">
			<xsl:variable name="refDataName" select="@refData"/>
			<column name="dic_{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('src_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" isSrc="true" isFk="false" isPk="false" dic="{@refData}" dqcType="{if(@type='long_int') then 'long' else @type}" usageValidation="{$dictionary/tables/table[@name=$refDataName]/@usageValidation}">
				<xsl:attribute name="origin">
					<xsl:choose>
						<xsl:when test="$dictionary/tables/table[@name=$refDataName]/@instUse='load'">source</xsl:when>
						<xsl:otherwise>clean</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</column>
		</xsl:if>	
		<xsl:if test="@isSrc='false' and @refData != ''">
			<xsl:variable name="refDataName" select="@refData"/>
			<column name="dic_{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('src_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" isSrc="false" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" usageValidation="{$dictionary/tables/table[@name=$refDataName]/@usageValidation}">
				<xsl:attribute name="origin">
					<xsl:choose>
						<xsl:when test="$dictionary/tables/table[@name=$refDataName]/@instUse='load'">source</xsl:when>
						<xsl:otherwise>clean</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</column>
			<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" origin="source" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" usageValidation="{$dictionary/tables/table[@name=$refDataName]/@usageValidation}" isSrc="false" refData="{$refDataName}" instUse="{$dictionary/tables/table[@name=$refDataName]/@instUse}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
				<!-- <xsl:attribute name="origin">
					<xsl:choose>
						<xsl:when test="$dictionary/tables/table[@name=$refDataName]/@instUse='load'">source</xsl:when>
						<xsl:otherwise>clean</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>-->
			</column>
		</xsl:if>
	</xsl:when>
	<xsl:when test="@isSrc='false' and @isCio='false' and @isStd='false' and @isSco='false' and @isExp='false' and @isPk='false' and @isFk='false' and @refData != ''">
		<xsl:variable name="refDataName" select="@refData"/>
		<column name="dic_{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" isFk="false" isPk="false" dic="{@refData}" dqcType="{if(@type='long_int') then 'long' else @type}" isSrc="false">
			<xsl:attribute name="origin">
				<xsl:choose>
					<xsl:when test="$dictionary/tables/table[@name=$refDataName]/@instUse='load'">source</xsl:when>
					<xsl:otherwise>clean</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</column>		
		<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" origin="source" refData="{$refDataName}" isFk="false" isPk="false" dic="{@refData}" dqcType="{if(@type='long_int') then 'long' else @type}" isSrc="false" instUse="{$dictionary/tables/table[@name=$refDataName]/@instUse}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
			<!-- <xsl:attribute name="origin">
				<xsl:choose>
					<xsl:when test="$dictionary/tables/table[@name=$refDataName]/@instUse='load'">source</xsl:when>
					<xsl:otherwise>clean</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>-->
		</column>	
	</xsl:when>
	<xsl:otherwise>
		<column name="{fn:lower-case(@name)}" description="{sf:nvl(description, @label, $logicalModel/masterModels/masterModel[guiConfig/@enableGui='true']/instanceTables/instanceTable[@instanceTable=$tableName]/columns/column[@name=concat('exp_',$columnName)]/@customLabel)}" type="{@type}" size="{@size}" origin="source" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}"/>
	</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template match="column" mode="special">
	<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{description}">
		<xsl:attribute name="origin">
			<xsl:call-template name="originTransformSpecial">
				<xsl:with-param name="origin" select="@createInto"/>
			</xsl:call-template>
		</xsl:attribute>
	</column>
</xsl:template>

<xsl:template match="column" mode="historical">
	<xsl:variable name="table_name" select="../../../@name"/>
	<xsl:variable name="src" select="fn:replace(@srcColumn,'^(src|std|cio|exp|sco)_(.+)$','$2')"/>
	<xsl:variable name="src_whole" select="@srcColumn"/>
	<column name="{fn:lower-case(@name)}" isFk='false' isPk="false" type="string" size="{@size}" dqcType="string" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{description}">
		<xsl:attribute name="origin">
			<xsl:choose>				
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isStd='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isCio='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isExp='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isSco='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isSrc='true'">source</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]">
					<xsl:call-template name="originTransformSpecial">
						<xsl:with-param name="origin" select="/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]/@createInto"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>source</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<valueDefinition srcColumn="{fn:lower-case(@srcColumn)}" type="historical" maxCnt="{@maxCnt}" separator="{@separator}"/>
	</column>
</xsl:template>

<!--
<xsl:template match="column" mode="oldValue">
	<xsl:variable name="src" select="fn:replace(@srcColumn,'^(src|std|cio|exp|sco)_(.+)$','$2')"/>
	<xsl:variable name="src_whole" select="@srcColumn"/>
	<xsl:variable name="table_name" select="../../../@name"/>
	
	<column name="{@name}" isFk='false' >
		<xsl:attribute name="origin">
			<xsl:choose>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isSrc='true'">source</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isStd='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isCio='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isExp='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@isSco='true'">clean</xsl:when>
				<xsl:when test="/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]">
					<xsl:call-template name="originTransformSpecial">
						<xsl:with-param name="origin" select="/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]/@createInto"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>source</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:value-of select="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@type|/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]/@type"/>
		</xsl:attribute>
		<xsl:attribute name="size">
			<xsl:value-of select="/logicalModel/instanceModel/tables/table[@name=$table_name]/columns/column[@name=$src]/@size|/logicalModel/instanceModel/tables/table[@name=$table_name]/advanced/specialColumns/column[@name=$src_whole]/@size"/>
		</xsl:attribute>
			<valueDefinition srcColumn="{@srcColumn}" type="oldValue"/>
	</column> 
</xsl:template>
-->

<xsl:template match="column" mode="par2chld">
	<xsl:variable name="parentTable" select="../../@parentTable"/>
		<xsl:choose>
			<xsl:when test="@type='long_int'">
				<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" isFk="true" isPk="false" dqcType="long" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{description}">
					<xsl:attribute name="origin">
						<xsl:call-template name="originTransform">
							<xsl:with-param name="origin" select="@createInto"/>
						</xsl:call-template>
					</xsl:attribute>
					<aggregationSource relationshipName="{sf:nvl(../../@parentRole,lower-case(../../@name))}" sourceColumn="{lower-case(@source)}" 
						method="firstvalue" separator=""><filterExpression><xsl:value-of select="filterExpression|@filterExpression"/></filterExpression></aggregationSource>
				</column>		
			</xsl:when>
			<xsl:otherwise>
				<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" isFk="true" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{description}">
					<xsl:attribute name="origin">
						<xsl:call-template name="originTransform">
							<xsl:with-param name="origin" select="@createInto"/>
						</xsl:call-template>
					</xsl:attribute>
					<aggregationSource relationshipName="{lower-case(sf:nvl(../../@parentRole,../../@name))}" sourceColumn="{lower-case(@source)}" 
						method="firstvalue" separator=""><filterExpression><xsl:value-of select="filterExpression|@filterExpression"/></filterExpression></aggregationSource>
				</column>			
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

<xsl:template match="column" mode="chld2par">
	<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{description}">
		<xsl:attribute name="origin">
			<xsl:call-template name="originTransform">
				<xsl:with-param name="origin" select="@createInto"/>
			</xsl:call-template>
		</xsl:attribute>
		<aggregationSource relationshipName="{sf:nvl(../../@childRole,lower-case(concat('rev_',../../@name)))}" sourceColumn="{lower-case(@source)}" 
			method="{fn:lower-case(@method)}" separator="{@separator}" ><filterExpression><xsl:value-of select="filterExpression|@filterExpression"/></filterExpression></aggregationSource>
	</column>
</xsl:template>

<xsl:template match="column" mode="master">
	<xsl:choose>
		<xsl:when test="@isPk='true' or @isFk='true'">
			<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" origin="merge" isFk="{@isFk}" isPk="{@isPk}" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{sf:nvl(@description,@label,@customLabel)}"/>
		</xsl:when>
		<xsl:when test="@isCmo='true'">
			<column name="cmo_{fn:lower-case(@name)}" type="{@type}" size="{@size}" origin="merge" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" refData="{lower-case(@refData)}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{sf:nvl(@description,@label,@customLabel)}"/>
		</xsl:when>
		<xsl:otherwise>
			<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" origin="merge" isFk="false" isPk="false" dqcType="{if(@type='long_int') then 'long' else @type}" refData="{lower-case(@refData)}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{sf:nvl(@description,@label,@customLabel)}"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="column" mode="dic">
	<column name="{fn:lower-case(@name)}" type="{@type}" size="{@size}" isFk="false" isPk="false" origin="source" dqcType="{if(@type='long_int') then 'long' else @type}" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}" description="{comment}"/>
</xsl:template>

<xsl:template match="relationship">
	<xsl:param name="tables"/>
	<xsl:param name="mode"/>
	<xsl:param name="layerName"/>
	<xsl:variable name="parent" select="@parentTable"/>
	<xsl:variable name="child" select="@childTable"/>
	
	<xsl:if test="$mode='instance'">
		<xsl:variable name="position_par" >
			<xsl:for-each select="$tables/table[@name=$parent]"><xsl:value-of select="count(preceding-sibling::table)"/></xsl:for-each>
		</xsl:variable>
		<xsl:variable name="generatedName"><xsl:value-of select="fn:lower-case($parent)"/><xsl:text>_source_id</xsl:text></xsl:variable>
		<xsl:variable name="relName" select="lower-case(@name)"/>
		<relationship name="{lower-case(@name)}" parentTable="{lower-case(@parentTable)}"  childTable="{lower-case(@childTable)}" description="{$logicalModel/instanceModel/relationships/relationship[@name=$relName]/description}">
			<xsl:attribute name="parentColumn">
				<xsl:choose>
					<xsl:when test="count(foreignKey/column)=1 and fn:lower-case(foreignKey/column/@parentColumn)!='source_id'">source_id</xsl:when>
					<xsl:when test="count(foreignKey/column)>1 and foreignKey/column[1]/@parentColumn != foreignKey/column[2]/@parentColumn and foreignKey/column/@parentColumn !='source_id'">source_id</xsl:when>
					<xsl:when test="count(foreignKey/column)>1">source_id</xsl:when>
					<xsl:otherwise><xsl:value-of select="foreignKey/column/@parentColumn"/></xsl:otherwise>
				</xsl:choose> 
			</xsl:attribute>
			<xsl:attribute name="childColumn">
				<xsl:choose>
					<xsl:when test="count(foreignKey/column)>1 and foreignKey/column[1]/@childColumn != foreignKey/column[2]/@childColumn and foreignKey/column/@childColumn !='source_id'">
							<xsl:value-of select="sf:nvl(advanced/alternativeKey/@alternativeFk,$generatedName)"/>
					</xsl:when>
					<xsl:when test="$tables/table[@name=$child]/columns/column[@name=current()/foreignKey/column/@childColumn and @type!='string']">
						<xsl:value-of select="sf:nvl(advanced/alternativeKey/@alternativeFk,$generatedName)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="foreignKey/column/@childColumn"/></xsl:otherwise>
				</xsl:choose> 
			</xsl:attribute>
		</relationship>
	</xsl:if>
	<xsl:if test="$mode='master'">
		<xsl:variable name="relName" select="lower-case(@name)"/>
		<relationship name="{lower-case(@name)}" parentTable="{lower-case(@parentTable)}"  childTable="{lower-case(@childTable)}" parentColumn="{lower-case(foreignKey/column/@parentColumn)}" childColumn="{lower-case(foreignKey/column/@childColumn)}" description="{$logicalModel/masterModels/masterModel[@name=$layerName]/relationships/relationship[@name=$relName]/description}" />
	</xsl:if>
</xsl:template>

<xsl:template name="artificial_fk">
	<xsl:param name="tables"/>
	<xsl:param name="tableName"/>
	<xsl:param name="mode"/>
	<xsl:param name="columnName"/>
	<xsl:if test="$mode='compound'">
	<xsl:for-each select="../../relationships/relationship[@childTable=$tableName and count(foreignKey/column)>1]">		
		<xsl:variable name="generatedName"><xsl:value-of select="fn:lower-case(@parentTable)"/><xsl:text>_source_id</xsl:text></xsl:variable>
		<xsl:variable name="columns" select="foreignKey"/>
			<column type="string" size="1000" origin="source" isFk="true" isPk="false" artificial="true" dqcType="string" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
				<xsl:attribute name="name">
					<xsl:value-of select="sf:nvl(advanced/alternativeKey/@alternativeFk,$generatedName)"/>
				</xsl:attribute>
				<compoundDefinition>
					<xsl:for-each select="$tables/table[@name=$tableName]/columns/column[@name=$columns/column/@childColumn]">
						<column name="{fn:lower-case(@name)}" type="{@type}"/>
					</xsl:for-each>
				</compoundDefinition>
			</column>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="$mode='artificial'">
			<xsl:for-each select="ancestor::instanceModel/relationships/relationship[@childTable=$tableName and foreignKey/column/@childColumn=$columnName]">-->
			<xsl:variable name="generatedName"><xsl:value-of select="fn:lower-case(@parentTable)"/><xsl:text>_source_id</xsl:text></xsl:variable>
			<column type="string" size="1000" origin="source" isFk="true" isPk="false" artificial="true" dqcType="string" eng="{if(substring(@name,1,4)='eng_') then 'true' else 'false'}">
				<xsl:attribute name="name">
					<xsl:value-of select="lower-case(sf:nvl(advanced/alternativeKey/@alternativeFk,$generatedName))"/>
				</xsl:attribute>
				<compoundDefinition>
				<xsl:variable name="colName" select="fn:lower-case(foreignKey/column/@childColumn)"/>
					<column name="{fn:lower-case(foreignKey/column/@childColumn)}" 
					type="{$tables/table[@name=$tableName]/columns/column[@name=$colName]/@type}"/>
				</compoundDefinition>
			</column>
		</xsl:for-each> 		
	</xsl:if>
</xsl:template>

<xsl:template name="originTransform">
	<xsl:param name="origin"/>
	<xsl:choose>
		<xsl:when test="fn:matches($origin,'^.+_clean')">copy_source</xsl:when>
		<xsl:when test="fn:matches($origin,'^.+_match')">copy_clean</xsl:when>
		<xsl:when test="fn:matches($origin,'^.+_merge')">copy_match</xsl:when>
		<xsl:when test="fn:matches($origin,'^Copy after+.')">copy_clean</xsl:when>
		<xsl:otherwise><xsl:value-of select="$origin"/></xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template name="originTransformSpecial">
	<xsl:param name="origin"/>
	<xsl:choose>
		<xsl:when test="fn:matches($origin,'^.+_clean')">clean</xsl:when>
		<xsl:when test="fn:matches($origin,'^.+_match')">match</xsl:when>
		<xsl:when test="$origin='load'">source</xsl:when>
		<xsl:otherwise><xsl:value-of select="$origin"/></xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template name="pseudocolumns_inst">
	<column name="eng_active" type="boolean" origin="internal" isFk="false" dqcType="boolean" eng="true" description="Active"/> <!-- size="1" -->
	<column name="eng_origin" type="string" size="100" origin="internal" isFk="false" dqcType="string" eng="true" description="Origin"/>
	<column name="eng_source_system" type="string" size="100" origin="internal" isFk="false" dqcType="string" eng="true" description="Source System"/>
	<!-- <column name="eng_change_type" type="string" size="1" origin="internal" isFk="false" dqcType="string" eng="true"/> -->
	<column name="eng_last_update_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Last Update Date"/> <!-- size="38" -->
	<column name="eng_last_source_update_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Source Update Date"/> <!-- size="38" -->
	<column name="eng_creation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Creation Date"/> <!-- size="38" -->
	<column name="eng_deletion_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Deletion Date"/> <!-- size="38" -->
	<column name="eng_activation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Activation Date"/> <!-- size="38" -->
	<column name="eng_deactivation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Deactivation Date"/> <!-- size="38" -->             
</xsl:template>

<xsl:template name="pseudocolumns_mas">
	<column name="eng_active" type="boolean" origin="internal" isFk="false" dqcType="boolean" eng="true" description="Active"/> <!-- size="1" -->
	<column name="eng_last_update_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Last Update Date"/> <!-- size="38" -->
	<column name="eng_creation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Creation Date"/> <!-- size="38" -->
	<column name="eng_deletion_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Deletion Date"/> <!-- size="38" -->
	<column name="eng_activation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Activation Date"/> <!-- size="38" -->
	<column name="eng_deactivation_date" type="datetime" origin="internal" isFk="false" dqcType="datetime" eng="true" description="Deactivation Date"/> <!-- size="38" -->
</xsl:template>

<xsl:template name="mas_dic_columns">
	<column name="source_id" origin="internal" type="string" size="20" isFk="false" isPk="true" dqcType="string" description="Source ID"/>
	<!-- <column name="origin" origin="internal" type="string" size="35" isFk="false" isPk="false"/> -->
	<column name="master_code" origin="source" type="{@masterCodeType}" size="20" isFk="false" isPk="false" dqcType="{@masterCodeType}" description="Master Code"/>
	<column name="master_name" origin="source" type="string" size="{$settings/@srcStringLength}" isFk="false" isPk="false" dqcType="string" description="Master Name"/>
</xsl:template>

<xsl:template name="inst_dic_columns">
	<column name="source_id" origin="internal" type="string" size="20" isFk="false" isPk="true" dqcType="string" description="Source ID"/>
	<!--  <column name="origin" origin="internal" type="string" size="35" isFk="false" isPk="false"/> -->
	<column name="source_code" origin="source" type="{@sourceCodeType}" size="20" isPk="false" isFk="false" dqcType="{@sourceCodeType}" description="Source Code"/>
	<column name="source_system" origin="source" type="string" size="20" isPk="false" isFk="false" dqcType="string" description="Source System"/>
	<column name="master_code" origin="source" type="{@masterCodeType}" size="20" isPk="false" isFk="true" dqcType="{@masterCodeType}" description="Master Code"/>
</xsl:template>

</xsl:stylesheet>