<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/>  <!-- /settings -->

<xsl:template match="/*">
<xsl:variable name="logical_model" select="logicalModel"/>

<model>
	<instanceLayer>
		<entities>
			<xsl:for-each select="preview/databaseModel/instanceTables/*">
				<xsl:call-template name="instanceTable" />
			</xsl:for-each>
			<!--<xsl:for-each select="preview/databaseModel/refData/physicalTable[@name=$logical_model/dictionary/tables/table[@loadInst='true']/@name]">-->
			<xsl:for-each select="logicalModel/dictionary/tables/table[@loadInst ='true']">
			<entity name="rd_{@name}_trans" usage="DICTIONARY">
				<columns>
					<column name="source_code" origin="source" type="{@sourceCodeType}" size="1000"/>
					<column name="source_system" origin="source" type="string" size="100"/>
					<column name="master_code" origin="source" type="{@masterCodeType}" size="1000"/>
					<xsl:apply-templates select="columns/column[@instance='true']" mode="dic"/>
				</columns>

			</entity>
			</xsl:for-each>
			<xsl:for-each select="logicalModel/dictionary/tables/table[@loadMas ='true']">
			<entity name="rd_{@name}" usage="DICTIONARY">
				<columns>
					<column name="master_code" origin="source" type="{@masterCodeType}" size="1000"/>
					<column name="master_name" origin="source" type="string" size="1000"/>
					<xsl:apply-templates select="columns/column[@master='true']" mode="dic"/>
				</columns>
				
			</entity>
			</xsl:for-each>
		</entities>
		<sourceSystems>
			<!-- if the same name as for gui is used here, system should not be generated  -->
			<xsl:for-each select="systems/*[@name!=sf:nvl($logical_model/masterModels/masterModel/guiConfig[@enableGui='true' ]/@guiSystem,'null')]">
				<xsl:call-template name="sourceSystem" />
			</xsl:for-each>
			<xsl:for-each select="logicalModel/masterModels/masterModel/guiConfig[@enableGui='true']">
				<xsl:variable name="guiConfig" select="."/>
				<xsl:variable name="guiModelName" select="ancestor::masterModel/@name"/>
				<system name="{$guiConfig/@guiSystem}">
					<instanceMappings>
						<xsl:for-each select="$logical_model/masterModels/masterModel[@name=$guiModelName]/masterTables/masterTable" >
								<!-- TODO zohlednit readOnly na entite 
								<xsl:if test="guiEdit/guiReadOnly!='Read-Only'"></xsl:if> -->
									<originId name="{$guiConfig/@guiSystem}#{@name}#{@instanceTable}" entity="{@instanceTable}"/>
								
						</xsl:for-each>
					</instanceMappings>
				</system>
			</xsl:for-each>
				
			<!-- 			name="party" label="Master Party" entityRole="golden" instanceTable="party
			<originId name="{$guiConfig/@guiSystem}#{$table_name}#{$instance_table_name}" entity="{@instance_table_name}"/> -->
			<xsl:if test="logicalModel/dictionary/tables/table[@loadInst ='true' or @loadMas='true']">
				<system name="hub_reference_data">
				<instanceMappings>
					<xsl:for-each select="logicalModel/dictionary/tables/table[@loadInst ='true']">
						<originId name="hub_reference_data#internal#rd_{@name}_trans" entity="rd_{@name}_trans"/>
					</xsl:for-each>
					<xsl:for-each select="logicalModel/dictionary/tables/table[@loadMas ='true']">
						<originId name="hub_reference_data#internal#rd_{@name}" entity="rd_{@name}"/>
					</xsl:for-each>
				</instanceMappings>
			</system>
			</xsl:if>
		</sourceSystems>
	</instanceLayer>
	<masterLayers>
		<xsl:for-each select="logicalModel/masterModels/*">
			<xsl:variable name="masterModel" select="." />
			<masterLayer name="{lower-case(@name)}">
				
				<entities>
					<xsl:for-each select="masterTables/*" >
						<xsl:call-template name="masterTable" />
					</xsl:for-each>
					<xsl:for-each select="instanceTables/*" >
						<xsl:call-template name="virtualInstanceTable" />
					</xsl:for-each>
					<!-- master dictionaries NEW -->
					<xsl:for-each select="$logical_model/dictionary/tables/table[@loadMas ='true']">
						<xsl:variable name="refTable" select="@name" />
						<xsl:if test="$masterModel/masterTables/*/columns/column[@refData = $refTable]">
							<entity instanceEntity="rd_{$refTable}" name="rd_{$refTable}" class="com.ataccama.nme.engine.model.VirtualInstanceEntity">
								<relationships>
								<!-- <rel reverseName="master_codes" parentEntity="{../../@name}" name="master" foreignKeyColumn="master_code">
										<xsl:attribute name="parentColumn">
										<xsl:choose>
											<xsl:when test="@isCmo='true'"><xsl:text>cmo_</xsl:text><xsl:value-of select="@name"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
										</xsl:choose>
										</xsl:attribute>
									</rel> -->
								</relationships>
							</entity>
						</xsl:if>
					</xsl:for-each>
				</entities>
			</masterLayer>
		</xsl:for-each>
	</masterLayers>
	<eventHandlersConfigFile>nme-event_handler.gen.xml</eventHandlersConfigFile>
</model>
</xsl:template>

<xsl:template name="sourceSystem">
<system name="{@name}">
	<instanceMappings>
		<xsl:for-each select="sourceMappings/*">
		<xsl:variable name="default_origin">
			<xsl:value-of select="../../@name"/><xsl:text>#</xsl:text><xsl:value-of select="@table"/><xsl:text>#</xsl:text><xsl:value-of select="@entity"/>
		</xsl:variable>
			<originId entity="{@entity}"  name="{sf:nvl(@customOrigin,$default_origin)}">
			<!--	<xsl:attribute name="name">
					<xsl:choose>
						<xsl:when test="@cutomOrigin !=''">
							<xsl:value-of select="@customOrigin"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="../../@name"/><xsl:text>#</xsl:text><xsl:value-of select="@table"/><xsl:text>#</xsl:text><xsl:value-of select="@entity"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>-->
			</originId>
		</xsl:for-each> 
	</instanceMappings>
</system>
</xsl:template>

<xsl:template name="virtualInstanceTable">

<xsl:variable name="tableName" select="@name" />
<entity class="com.ataccama.nme.engine.model.VirtualInstanceEntity" name="{@name}" instanceEntity="{@instanceTable}">
	<relationships>
		<xsl:for-each select="../../relationships/relationship[@childTable=$tableName]">
			<rel name="{sf:nvl(@parentRole, @name)}"  parentEntity="{@parentTable}" 
				foreignKeyColumn="{foreignKey/column/@childColumn}"
				parentColumn="{foreignKey/column/@parentColumn}">
				
					<xsl:attribute name="reverseName">
						<xsl:choose>
							<xsl:when test="@childRole != ''"><xsl:value-of select="lower-case(@childRole)"/></xsl:when>
							<xsl:otherwise><xsl:text>rev_</xsl:text><xsl:value-of select="lower-case(@name)"/></xsl:otherwise>
						</xsl:choose>	
					</xsl:attribute>
					<xsl:choose>
					<xsl:when test="@type='Same System'">
						<type class="com.ataccama.nme.engine.model.SameSystemRelationship"/>
					</xsl:when>
					<xsl:when test="@type='Cross System'">
						<type class="com.ataccama.nme.engine.model.CrossSystemRelationship"/>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
				
			</rel>
		</xsl:for-each>
	</relationships>
</entity>

</xsl:template>

<xsl:template name="masterTable">
<xsl:variable name="tableName" select="@name" />
<xsl:variable name="viewName" select="../../@name" />
<entity class="com.ataccama.nme.engine.model.PersistentMasterEntity" name="{lower-case(@name)}" instanceEntity="{@instanceTable}" groupingColumn="{sf:nvl(advanced/@groupColumn,'master_id')}">
	<columns>
		<xsl:apply-templates select="/*/preview/databaseModel/masterTables/*[@name=lower-case($tableName) and @layerName=lower-case($viewName)]/columns/column[@origin != 'internal' and fn:lower-case(@name)!='id']" mode="master"/>
	</columns>
	<relationships>
		<xsl:for-each select="../../relationships/relationship[@childTable=$tableName]">
			<rel name="{sf:nvl(@parentRole, @name)}"  parentEntity="{@parentTable}" 
				foreignKeyColumn="{foreignKey/column/@childColumn}"
				parentColumn="{foreignKey/column/@parentColumn}">
				
					<xsl:attribute name="reverseName">
						<xsl:choose>
							<xsl:when test="@childRole != ''"><xsl:value-of select="lower-case(@childRole)"/></xsl:when>
							<xsl:otherwise><xsl:text>rev_</xsl:text><xsl:value-of select="lower-case(@name)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:choose>
					<xsl:when test="@type='Same System'">
						<type class="com.ataccama.nme.engine.model.SameSystemRelationship"/>
					</xsl:when>
					<xsl:when test="@type='Cross System'">
						<type class="com.ataccama.nme.engine.model.CrossSystemRelationship"/>
					</xsl:when>
					<xsl:when test="@type='Extended Same System'">
						<type class="com.ataccama.nme.engine.model.SameSystemExtendedRelationship"/>
					</xsl:when>					
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			
			</rel>
		</xsl:for-each>
		<xsl:for-each select="columns/column[@refData != '']">
			<xsl:if test="ancestor::logicalModel/dictionary/tables/table[@name=current()/@refData]/@loadMas='true'">
			<xsl:variable name="foreignKey">
					<xsl:choose>
						<xsl:when test="@isCmo='true'"><xsl:text>cmo_</xsl:text><xsl:value-of select="@name"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
					</xsl:choose>
			</xsl:variable>
			<!-- TODO reverseName="master_codes_{$foreignKey}{@tableName} -->
			<rel reverseName="master_codes_{$foreignKey}_{lower-case($tableName)}" parentEntity="rd_{@refData}" name="{$foreignKey}_master_details" parentColumn="master_code" foreignKeyColumn="{$foreignKey}"/>
			</xsl:if>
		</xsl:for-each>
	</relationships>
	<mergingOperation class="com.ataccama.nme.dqc.operations.MergingPlan" customActivityTracking="{advanced/@customActivity}"
			planFileName="../engine/trans/{lower-case(@instanceTable)}/{$viewName}_{lower-case(@name)}_merge.comp">
		<xsl:if test="advanced/@inputFilterExpression != '' or advanced/inputFilterExpression != ''">
			<recordFilterExpression><xsl:value-of select="advanced/@inputFilterExpression|advanced/inputFilterExpression"/></recordFilterExpression>
		</xsl:if>
	</mergingOperation>
</entity>
</xsl:template>

<xsl:template name="instanceTable">
<xsl:variable name="tableName" select="@name" />
<entity name="{@name}">
	<xsl:if test="@type='dictionary'">
		<xsl:attribute name="usage"><xsl:text>DICTIONARY</xsl:text></xsl:attribute>
	</xsl:if>
	<columns>
		<!-- instance model columns, special columns, unification columns, copy columns and old value columns-->
		<xsl:apply-templates select="columns/column[(@origin != 'internal' and @origin != 'internal_match') and not(valueDefinition)]">
			<xsl:with-param name="table_name" select="$tableName"/>
		</xsl:apply-templates>
		<!-- historical columns -->
		<xsl:apply-templates select="columns/column[valueDefinition/@type='historical']" mode="historical"/>
	</columns>
	<relationships>
		<!--<xsl:for-each select="/*/logicalModel/instanceModel/relationships/relationship[@childTable=$tableName]">-->
		<xsl:for-each select="relationships/relationship[@childTable=$tableName]">
			<xsl:variable name="relName" select="@name"/>
			<rel name="{sf:nvl(lower-case(/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/@parentRole), @name)}"  parentEntity="{@parentTable}" 
				foreignKeyColumn="{@childColumn}"
				parentColumn="{@parentColumn}">
				<xsl:attribute name="reverseName">
					<xsl:choose>
						<xsl:when test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/@childRole != ''">
							<xsl:value-of select="lower-case(/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/@childRole)"/>
						</xsl:when>
						<xsl:otherwise><xsl:text>rev_</xsl:text><xsl:value-of select="lower-case(@name)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/@type='Same System'">
						<xsl:if test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@enable='false'">
							<type class="com.ataccama.nme.engine.model.SameSystemRelationship"/>											
						</xsl:if>
						<xsl:if test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@enable='true'">
							<type class="com.ataccama.nme.engine.model.SameSystemExtendedRelationship">
								<xsl:choose>
								<xsl:when test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@parentColumn!='' and /*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@childColumn=''">	
									<parentSystemColumnName><xsl:value-of select="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@parentColumn"/></parentSystemColumnName>
								</xsl:when>
								<xsl:when test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@childColumn!='' and /*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@parentColumn=''">
									<childSystemColumnName><xsl:value-of select="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@childColumn"/></childSystemColumnName>
								</xsl:when>
								<xsl:when test="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@parentColumn!='' and /*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@childColumn!=''">
									<parentSystemColumnName><xsl:value-of select="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@parentColumn"/></parentSystemColumnName>
									<childSystemColumnName><xsl:value-of select="/*/logicalModel/instanceModel/relationships/relationship[lower-case(@name)=$relName]/advanced/extendedSameSystem/@childColumn"/></childSystemColumnName>
								</xsl:when>
								<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
							</type>					
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<type class="com.ataccama.nme.engine.model.CrossSystemRelationship"/>
					</xsl:otherwise>
				</xsl:choose>
			</rel>
		</xsl:for-each>		
		
		<xsl:for-each select="columns/column[@refData != '' and @isSrc='true']">
			<xsl:variable name="refData" select="@refData"/>
			<xsl:if test="/*/logicalModel/dictionary/tables/table[lower-case(@name)=$refData]/@loadInst='true'">
			<rel name="fk_{fn:replace(@name,'src_','dic_')}_{$tableName}" parentEntity="rd_{$refData}_trans" foreignKeyColumn="{fn:replace(@name,'dic_','src_')}" parentColumn="source_code" reverseName="rev_fk_{fn:replace(@name,'src_','dic_')}_{lower-case($tableName)}">
				<!-- <type class="com.ataccama.nme.engine.model.CrossSystemRelationship"/> -->
				<type class="com.ataccama.nme.engine.model.SameSystemExtendedRelationship">
		            <parentSystemColumnName>source_system</parentSystemColumnName>
       			 </type>
			</rel>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="columns/column[@refData != '' and @isSrc='false']">
			<xsl:variable name="refData" select="@refData"/>
			<xsl:if test="/*/logicalModel/dictionary/tables/table[lower-case(@name)=$refData]/@loadInst='true'">
			<rel name="fk_dic_{@name}_{$tableName}" parentEntity="rd_{$refData}_trans" foreignKeyColumn="{fn:replace(@name,'dic_','')}" parentColumn="source_code" reverseName="rev_fk_dic_{@name}_{lower-case($tableName)}">
				<!-- <type class="com.ataccama.nme.engine.model.CrossSystemRelationship"/> -->
				<type class="com.ataccama.nme.engine.model.SameSystemExtendedRelationship">
		            <parentSystemColumnName>source_system</parentSystemColumnName>
       			 </type>
			</rel>
			</xsl:if>
		</xsl:for-each>
	</relationships>
	
	<xsl:if test="/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/matchingTab[@matching = 'true']">
		<matchingOperation 
			planFileName="../engine/trans/{$tableName}/{$tableName}_match.comp" enableIdentify="{/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/matchingTab/@enableIdentify}">
			<xsl:attribute name="class">
					<!-- <xsl:text>com.ataccama.nme.dqc.mdu.MduMatchingPlan</xsl:text>
					<xsl:value-of select="name($settings)"/> -->
					<xsl:if test="$settings/advancedSettings[@matchingCompatibility = 'false']">
						<xsl:text>com.ataccama.nme.dqc.mdu.MduMatchingPlan</xsl:text>
					</xsl:if>
					<xsl:if test="$settings/advancedSettings[@matchingCompatibility = 'true']">
						<xsl:text>com.ataccama.nme.dqc.operations.MatchingPlan</xsl:text>
					</xsl:if> 
			</xsl:attribute>

			<xsl:variable name="matchingTab" select="/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/matchingTab"/>
			<xsl:if test="$settings/advancedSettings[@matchingCompatibility = 'false']">
			<matchings>				
			<!-- default matching -->
			<xsl:if test="/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/matchingTab/multipleMatching/@disableDefault='false'">	
			
				<matching name="{$matchingTab/defaultMatchingDefinition/@name}">
           			<masterIdColumn><xsl:value-of select="lower-case($matchingTab/defaultMatchingDefinition/@masterIdColumn)"/></masterIdColumn>
           			<!-- <idKeeperFlagColumn><xsl:value-of select="lower-case($matchingTab/defaultMatchingDefinition/@idKeeperFlagColumn)"/></idKeeperFlagColumn> -->
           			<isolateFlagColumn><xsl:value-of select="lower-case($matchingTab/defaultMatchingDefinition/@isolateFlagColumn)"/></isolateFlagColumn>
           			<rematchFlagColumn><xsl:value-of select="lower-case($matchingTab/defaultMatchingDefinition/@rematchFlagColumn)"/></rematchFlagColumn>
       			</matching>
			</xsl:if>
			<!-- multiple matchings -->
			<xsl:for-each select="/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/matchingTab[@matching='true']/multipleMatching/matchingDefinitions/matchingDefinition">
				<matching name="{@name}">
           			<masterIdColumn><xsl:value-of select="lower-case(@masterIdColumn)"/></masterIdColumn>
           			<!-- <idKeeperFlagColumn><xsl:value-of select="lower-case(@idKeeperFlagColumn)"/></idKeeperFlagColumn> -->
           			<xsl:if test="@isolateFlagColumn != ''">	
           				<isolateFlagColumn><xsl:value-of select="lower-case(@isolateFlagColumn)"/></isolateFlagColumn>
           			</xsl:if>
           			<xsl:if test="@rematchFlagColumn != ''">	
           				<rematchFlagColumn><xsl:value-of select="lower-case(@rematchFlagColumn)"/></rematchFlagColumn>
           			</xsl:if>
       			</matching>
			</xsl:for-each>
			</matchings>
			</xsl:if>
		</matchingOperation>
			<!--  class="com.ataccama.nme.dqc.mdu.MduMatchingPlan" -->
	</xsl:if>
	<xsl:if test="columns/column[@origin = 'clean']">
		<cleansingOperation class="com.ataccama.nme.dqc.operations.CleansingPlan" 
			planFileName="../engine/trans/{lower-case(@name)}/{lower-case(@name)}_clean.comp"/>
	</xsl:if>
	<xsl:if test="/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/aggregationTab[@aggregation = 'true']">
		<aggregatingOperation 
			planFileName="../engine/trans/{$tableName}/{$tableName}_aggregate.comp" 
			class="com.ataccama.nme.dqc.operations.AggregatingPlan"
			groupingColumn="{/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$tableName]/aggregationTab/@groupingColumn}">
		</aggregatingOperation>
	</xsl:if>	
</entity>
</xsl:template>


<!-- COLUMNS -->
<xsl:template match="column">
<xsl:param name="table_name"/>
<xsl:variable name="column_name" select="@name"/>
	<column name="{@name}" type="{@type}" origin="{@origin}" >
		<xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>
		<xsl:choose>
		<!-- oldValueProvider and valueSource -->
			<!-- childToParent -->
			<xsl:when test="@name=/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column/@srcColumn and @name=/*/logicalModel/instanceModel/relationships/relationship[@parentTable=$table_name]/childToParent/column/@name">
				<!-- valueSource -->
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
				<xsl:if test="aggregationSource">
					<valueSource relationshipName="{aggregationSource/@relationshipName}" columnName="{aggregationSource/@sourceColumn}" >
						<xsl:if test="aggregationSource/@filterExpression != '' or aggregationSource/filterExpression != ''">
							<filterExpression><xsl:value-of select="aggregationSource/@filterExpression|aggregationSource/filterExpression"/></filterExpression>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="aggregationSource/@method='concatenatedistinct'">
								<aggregation class="com.ataccama.nme.engine.model.ConcatenateDistinct" 
									separator="{aggregationSource/@separator}" maxLength="{@size}"/>
							</xsl:when>
							<xsl:when test="aggregationSource/@method='max'">
								<aggregation class="com.ataccama.nme.engine.model.MaxValue" />
							</xsl:when>
							<xsl:when test="aggregationSource/@method='min'">
								<aggregation class="com.ataccama.nme.engine.model.MinValue" />
							</xsl:when>
							<xsl:otherwise>
								<aggregation class="com.ataccama.nme.engine.model.FirstValue" />
							</xsl:otherwise>
						</xsl:choose>
					</valueSource>
				</xsl:if>				
				<!-- oldValueProvider -->
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
					<oldValueProvider columnName="{/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column[@srcColumn=$column_name]/@name}">
						<xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>
					</oldValueProvider>
			</xsl:when>	
			<!-- parentToChild -->
			<xsl:when test="@name=/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column/@srcColumn and @name=/*/logicalModel/instanceModel/relationships/relationship[lower-case(@childTable)=$table_name]/parentToChild/column/@name">
				<!-- valueSource -->
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
				<xsl:if test="aggregationSource">
					<valueSource relationshipName="{aggregationSource/@relationshipName}" columnName="{aggregationSource/@sourceColumn}" >
						<xsl:if test="aggregationSource/@filterExpression != '' or aggregationSource/filterExpression != ''">
							<filterExpression><xsl:value-of select="aggregationSource/@filterExpression|aggregationSource/filterExpression"/></filterExpression>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="aggregationSource/@method='concatenatedistinct'">
								<aggregation class="com.ataccama.nme.engine.model.ConcatenateDistinct" 
									separator="{aggregationSource/@separator}" maxLength="{@size}"/>
							</xsl:when>
							<xsl:when test="aggregationSource/@method='max'">
								<aggregation class="com.ataccama.nme.engine.model.MaxValue" />
							</xsl:when>
							<xsl:when test="aggregationSource/@method='min'">
								<aggregation class="com.ataccama.nme.engine.model.MinValue" />
							</xsl:when>
							<xsl:otherwise>
								<aggregation class="com.ataccama.nme.engine.model.FirstValue" />								
							</xsl:otherwise>
						</xsl:choose>
					</valueSource>
				</xsl:if>				
				<!-- oldValueProvider -->
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
					<oldValueProvider columnName="{/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column[@srcColumn=$column_name]/@name}" /> 			
			</xsl:when>
			<!-- oldValueProvider -->
			<xsl:when test="@name=/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column/@srcColumn">
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
				<oldValueProvider columnName="{/*/logicalModel/instanceModel/tables/table[lower-case(@name)=$table_name]/advanced/oldValueColumns/column[@srcColumn=$column_name]/@name}" /> 
			</xsl:when>	
			<!-- valueSource -->		
			<xsl:otherwise>
				<!-- <xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>-->
				<xsl:if test="aggregationSource">
					<valueSource relationshipName="{aggregationSource/@relationshipName}" columnName="{aggregationSource/@sourceColumn}" >
						<xsl:if test="aggregationSource/@filterExpression != '' or aggregationSource/filterExpression != ''">
							<filterExpression><xsl:value-of select="aggregationSource/@filterExpression|aggregationSource/filterExpression"/></filterExpression>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="aggregationSource/@method='concatenatedistinct'">
								<aggregation class="com.ataccama.nme.engine.model.ConcatenateDistinct" 
									separator="{aggregationSource/@separator}" maxLength="{@size}"/>
							</xsl:when>
							<xsl:when test="aggregationSource/@method='max'">
								<aggregation class="com.ataccama.nme.engine.model.MaxValue" />
							</xsl:when>
							<xsl:when test="aggregationSource/@method='min'">
								<aggregation class="com.ataccama.nme.engine.model.MinValue" />
							</xsl:when>
							<xsl:otherwise>
								<aggregation class="com.ataccama.nme.engine.model.FirstValue" />							
							</xsl:otherwise>
						</xsl:choose>
					</valueSource>
				</xsl:if>
			</xsl:otherwise>	
		</xsl:choose>
	</column>
</xsl:template>

<xsl:template match="column" mode="historical">
	<xsl:variable name="src" select="@srcColumn"/>
	<xsl:variable name="table_name" select="../../../@name"/>
	<column name="{@name}" origin="{@origin}" type="string" >
		<xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>
		<historyCollector columnName="{valueDefinition/@srcColumn}" separator="{valueDefinition/@separator}" maxCount="{valueDefinition/@maxCnt}"/>
	</column>
</xsl:template>

<xsl:template match="column" mode="master">
	<column name="{@name}" type="{@type}" >
		<xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>
	</column>
</xsl:template>

<xsl:template match="column" mode="dic">
	<column name="{fn:lower-case(@name)}" origin="source" type="{@type}"  >
		<xsl:if test="@size!=''"><xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute></xsl:if>
	</column>
</xsl:template>
</xsl:stylesheet>