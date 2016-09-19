<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:param name="masterModels" select="document('param:masterModels')/*"/>  <!--/logicalModel/masterModels -->
	<xsl:param name="settings" select="document('param:settings')/*"/>  <!--/settings -->

<!-- bound to preview/guiPreview/masterModels/model -->
	<xsl:template match="/model">
	
	<xsl:variable name="model_name" select="lower-case(@name)"/>
	<xsl:variable name="guiConfig" select="$masterModels/masterModel[lower-case(@name)=$model_name]/guiConfig"/>
		<model version="1"> <!--  readOnly="{$guiConfig/@guiReadOnly}" -->
			<xsl:attribute name="readOnly">
				<xsl:choose>
					<xsl:when test="$guiConfig/@guiMode='Read-Only'">
						<xsl:value-of>true</xsl:value-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of>false</xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<topLevelEntities>
				<xsl:for-each select="masterTables/masterTable[@topLevel='true']">
					<topLevelEntity><xsl:value-of select="@name"/></topLevelEntity>
				</xsl:for-each>
				<xsl:for-each select="instanceTables/instanceTable[@topLevel='true']">
					<topLevelEntity><xsl:value-of select="@name"/></topLevelEntity>
				</xsl:for-each>
			</topLevelEntities>
			<displaySettings>
				<actions>
					<action name="MANUAL_Exception" visible="{$guiConfig/actions/@manualExceptions}"/>
					<action name="hierarchy" visible="{$guiConfig/actions/@hierarchies}"/>
					<action name="create" visible="{$guiConfig/actions/@create}"/>
					<action name="edit" visible="{$guiConfig/actions/@edit}"/>
					<action name="delete" visible="{$guiConfig/actions/@deactivate}"/>
					<action name="revert" visible="{$guiConfig/actions/@revert}"/>
				</actions>
				<indicators>
					<indicator name="dqi" visible="{$guiConfig/indicators/@dqi}"/>
				</indicators>
			</displaySettings>
			
			<hierarchies>
				<xsl:for-each select="$guiConfig/hierarchies/*">
					<hierarchy label="{@label}">
						<xsl:attribute name="type">
							<xsl:choose>
								<xsl:when test="./name()='hierarchy1N'">t_1n</xsl:when>
								<xsl:when test="./name()='hierarchyMN'">t_mn</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<!-- todo: should be a part of configuration? -->
						<xsl:if test="./name()='hierarchyMN'">
							<xsl:attribute name="directioned">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<startEndPoint label="{startPoint/@label}" position="{startPoint/@position}"/>
						<endEndPoint label="{endPoint/@label}" position="{endPoint/@position}"/>
						<connection color="{connection/@connectionColour}" shape="{connection/@connectionShape}"/>
						<path>
							<xsl:if test="./name()='hierarchy1N'">
								<relation name="rev_{@relationship}"/>
							</xsl:if>
							<xsl:if test="./name()='hierarchyMN'">
									<!-- tvy todo: simplified - in case of 3 and more relationships this will not work! -->
									<xsl:variable name="hierEntity" select="@tableMN"/>
									<xsl:for-each select="$masterModels/masterModel[lower-case(@name)=$model_name]/relationships/relationship[lower-case(@childTable)=lower-case($hierEntity) and advanced/@ignoreRelGui='false']">
									<!-- $masterModels/masterModel[@name=$model_name]/masterTables/masterTable[@name=$hierEntity] -->
										<relation name="rev_{@name}"/>
									</xsl:for-each>
							</xsl:if>
						</path>
					</hierarchy>
				</xsl:for-each>
			</hierarchies>
			<entities>
				<xsl:apply-templates select="masterTables/masterTable">
					<xsl:with-param name="model_name" select="$model_name"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="instanceTables/instanceTable">
					<xsl:with-param name="model_name" select="$model_name"/>
				</xsl:apply-templates>				
			</entities>
			<!-- added to enable edit feature -->
			<lookups>
				<xsl:apply-templates select="dictionaryTables/dictionaryTable">
					<xsl:with-param name="model_name" select="$model_name"/>
				</xsl:apply-templates>				
			</lookups> 
		</model>
	</xsl:template>

	<xsl:template match="dictionaryTable">
		<xsl:param name="model_name"/>
		<xsl:variable name="table_name" select="@name"/>
		<!-- previous version of lookup similar to instance entity		
		<lookup name="{@name}" label="{@label}" master="false" nmeEntity="{@name}"> -->
		<lookup name="{@name}" nmeView="{$model_name}" nmeEntity="{@name}">
			<columns>		
				<xsl:apply-templates select="columns/column" mode="lookup"/>
			</columns>
		</lookup>
	</xsl:template>	
	
	<xsl:template match="instanceTable">
		<xsl:param name="model_name"/>	
		<xsl:variable name="table_name" select="@name"/>
		<xsl:variable name="guiConfig" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/guiConfig"/>
		<entity name="{@name}" label="{@label}" master="false" nmeEntity="{$masterModels/masterModel[lower-case(@name)=$model_name]/instanceTables/instanceTable[@name=current()/@name]/@instanceTable}">
			<columns>
				<!-- <column name="eng_active" dataType="BOOLEAN" label="Active" editable="false" indexType="BOTH"/>
				<column name="eng_source_system" dataType="STRING" label="Source System" editable="false" indexType="BOTH"/>
				<column name="eng_origin" dataType="STRING" label="Origin" editable="false" indexType="BOTH"/>
				<column name="eng_mtdt" dataType="DATETIME" label="Updated" editable="false" indexType="BOTH"/>-->
				<xsl:apply-templates select="columns/column" mode="basic"/>
			</columns>
			<relationships>
				<xsl:apply-templates select="/model/relationships/relationship[lower-case(@childTable)=lower-case($table_name)]"/>
			</relationships>
		</entity>
	</xsl:template>

	<xsl:template match="masterTable">
		<xsl:param name="model_name"/>
		<xsl:variable name="table_name" select="@name"/>
		<xsl:variable name="gui_mode" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiEdit/@guiReadOnly"/>
		<xsl:variable name="instance_table_name" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/lower-case(@instanceTable)"/>
		<xsl:variable name="masterModel" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]"/>
		<xsl:variable name="instanceTableName" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/instanceTables/instanceTable[lower-case(@instanceTable)=lower-case($masterModel/masterTables/masterTable[lower-case(@name)=lower-case(current()/@name)]/@instanceTable)]/@name" />
		<xsl:variable name="guiConfig" select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/guiConfig"/>
		<entity name="{@name}" label="{@label}" master="true" nmeEntity="{@name}" nmeView="{$model_name}">
			<xsl:variable name="instances" select="/model/relationships/relationship[lower-case(@parentTable)=lower-case($table_name) and lower-case(@childTable)=$instanceTableName]/@name"/>
			<xsl:if test="$instances != ''">
				<!-- QUICK FIX - id works only for relations that are 1:N - N:1 does not work (rev is added anyway) -->
				<xsl:attribute name="instances">
					<xsl:text>rev_</xsl:text><xsl:value-of select="$instances"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$gui_mode !='use global setting (from GUI Configuration)'">
			<xsl:attribute name="readOnly">
				<xsl:choose>
					<xsl:when test="$gui_mode='Read-Only'">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			</xsl:if>
			<columns>
				<!-- <column name="eng_active" dataType="BOOLEAN" label="Active" editable="false" indexType="'BOTH'"/>
				<column name="eng_mtdt" dataType="DATETIME" label="Updated" editable="false" indexType="BOTH"/>-->
				<xsl:apply-templates select="columns/column" mode="basic">
					<xsl:with-param name="model_name" select="$model_name"/>
					<xsl:with-param name="table_name" select="$table_name"/>
					<!-- <xsl:with-param name="lookup_rels" select="/model[@name=$model_name]/relationships/relationship[@childTable=$table_name]"/>  --><!-- and substring(@parentTable,1,3)='rd_' --> 
				</xsl:apply-templates>
			</columns>
			<relationships>
					<xsl:apply-templates select="/model/relationships/relationship[lower-case(@childTable)=lower-case($table_name)]">
						<xsl:with-param name="model_name" select="$model_name"/>
						<xsl:with-param name="table_name" select="$table_name"/>
					</xsl:apply-templates>
			</relationships>

			<!-- instance mapping is required for activate/deactivate and revert even if there is no instance mapping defined.  -->
			<xsl:if test="$guiConfig/@guiMode='Read-Write'">
				<nmeInstanceMapping origin="{$guiConfig/@guiSystem}#{$table_name}#{$instance_table_name}">
					<xsl:if test="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiEdit/editColumns/column">
						<columns>
							<xsl:apply-templates select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiEdit/editColumns/column" mode="nmeMapping"/>
						</columns>
					</xsl:if>
				</nmeInstanceMapping>
			</xsl:if>
		</entity>
	</xsl:template>


<!-- COLUMN -->
	<xsl:template match="column" mode="basic"> <!-- nezapomen na computed columns-->
		<xsl:param name="model_name"/>
		<xsl:param name="table_name"/>
		<!-- <xsl:param name="lookup_rels"/> -->
		<xsl:variable name="columnName" select="fn:lower-case(@name)"/>
		<column name="{fn:lower-case(@name)}" dataType="{if(@type='long') then 'LONG_INT' else fn:upper-case(@type)}" label="{sf:nvl(@finalLabel,@label)}"> <!-- editable="false"  -->
			<xsl:if test="@indexType!=''">
				<xsl:attribute name="indexType" select="@indexType"/>
			</xsl:if>
			<xsl:attribute name="editable">
				 <xsl:choose>
					<!-- only mapped columns can be changed -->
					<xsl:when test="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiEdit/editColumns/column[lower-case(@name)=lower-case($columnName)]">true</xsl:when>
					<!-- each FK has to be editable -->
					<xsl:when test="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/columns/column[lower-case(@name)=lower-case($columnName) and @isFk='true']">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose> 
			</xsl:attribute>	
			<xsl:if test="fn:boolean(producer)">
				<producer class="com.ataccama.mda.core.beans.MdaExpressionProducerBean">
					<value><xsl:value-of select="producer/@value|producer/value"/></value>
				</producer>
			</xsl:if>
			
			<xsl:apply-templates select="/model/relationships/relationship[lower-case(@childTable)=lower-case($table_name) and lower-case(@childFk)=lower-case($columnName)]" mode="lookup">
				<!-- <xsl:with-param name="columnName" select="$columnName"/> -->
			</xsl:apply-templates>
			
		
		</column>
	</xsl:template>	
	
	<xsl:template match="column" mode="lookup"> 
		<!-- <xsl:param name="model_name"/>
		<xsl:param name="table_name"/> -->
		<xsl:variable name="columnName" select="fn:lower-case(@name)"/>
		<column name="{fn:lower-case(@name)}" dataType="{if(@type='long') then 'LONG_INT' else fn:upper-case(@type)}"/> 
	</xsl:template>	
	
	<xsl:template match="column" mode="view">
		<column>
			<xsl:attribute name="column">
				<xsl:value-of select="fn:lower-case(@name)"/>
			</xsl:attribute>
			
		</column>
	</xsl:template>
	
	<xsl:template match="column" mode="nmeMapping">
			<column name="{@nmeMapping}" value="{{{fn:lower-case(@name)}}}"/>
	</xsl:template>

<!-- RELATIONSHIPS -->	
	<xsl:template match="relationship"> 
		<xsl:param name="model_name"/>
		<xsl:param name="table_name"/>
		<!-- added to template, but temporary disabled rd_ relationships now they are part of each column  -->
		<xsl:if test="substring(@parentTable,1,3)!='rd_'">
			<relationship reverseName="rev_{@name}" parentColumn="{@parentFk}" name="{@name}" entity="{@parentTable}" foreignKeyColumn="{@childFk}" label="{@label}" required="false" reverseLabel="{@label} (rev)">
				<!-- MDA relationship type override preparation 
				<xsl:choose>
					<xsl:when test="@type!=''">
						<xsl:attribute name="type">
							<xsl:value-of select="@type" />
						</xsl:attribute>
					</xsl:when>
				</xsl:choose> -->
				
						<xsl:attribute name="parentSrcIdColumn">
							<xsl:value-of select="$masterModels/masterModel[lower-case(@name)=lower-case($model_name)]/masterTables/masterTable[lower-case(@name)=lower-case($table_name)]/guiEdit/parentColumns/parentColumn[lower-case(@relationship)=lower-case(current()/@name)]/@name" />
							<!--  
							remove
							<xsl:variable name="rel_name" select="@name"/>  
							[@relationship=$rel_name]-->
						</xsl:attribute>
				
				<!-- parentColumnId= 
				<ParentColumns>
			<parentColumns relationship="party_has_child_party" name="child_source_id" elemId="43257"/>
			<parentColumns relationship="party_has_parent_party" name="parent_source_id" elemId="43258"/>
		</ParentColumns>
				
				
				-->
			</relationship>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template match="relationship" mode="lookup"> 
		<!-- only rd_ relationships used / there should be some flag instead of rd_ prefix  -->
		<xsl:if test="fn:substring(@parentTable,1,3)='rd_'">
			<lookupRelationship> 
	                  <lookupName><xsl:value-of select="@parentTable"/></lookupName>
	                  <lookupColumnName>master_code</lookupColumnName>
					  <lookupColumnLabel>master_name</lookupColumnLabel>
			</lookupRelationship>
		</xsl:if>
	</xsl:template>	

	<xsl:template match="mnRelationship">
		<xsl:param name="model"/>
		<m2nRelationship
			srcName="rev_{@srcTable}2{@destTable}_bridge"
			srcRel="{@srcRelationship}"
			srcLabel="{$model/mnRelationships/mnRelationship[@name=current()/@name]/@srcLabel}"
			destName="{@srcTable}2{@destTable}_bridge"
			destRel="{@destRelationship}"
			destLabel="{$model/mnRelationships/mnRelationship[@name=current()/@name]/@destLabel}" />
			<!--destLabel="{$model/relationships/relationship[@name=current()/@destRelationship]/@label}"/>-->
			<!--srcLabel="{$model/relationships/relationship[@name=current()/@srcRelationship]/@label}"-->
		</xsl:template>

	


<!-- VIEWS --> 		
		
<!-- GRID VIEW -->		
		<xsl:template match="gridView">
			<xsl:param name="model"/>
			<xsl:variable name="table_name" select="../../../@name"/>
			<view name="gridView" type="grid">
				<columnList>
					<xsl:choose>
						<xsl:when test="@allColumns='true'">
								<xsl:apply-templates select="$model/*/*[lower-case(@name)=lower-case($table_name)]/columns/column" mode="view"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="columns/column" mode="view"/>
						</xsl:otherwise>
					</xsl:choose>	
				</columnList>
			</view>
		</xsl:template>

<!-- CART VIEW -->		
		<xsl:template match="cartView">
			<xsl:param name="model"/>
			<xsl:variable name="table_name" select="../../../@name"/>
			<view name="cartView" type="cartView">
				<groups>
					<group groupType="tab" groupName="tab" groupLabel="tab" name="tab">
						<columnList>
							<xsl:choose>
								<xsl:when test="@allColumns='true'">
									<xsl:apply-templates select="$model/*/*[lower-case(@name)=lower-case($table_name)]/columns/column" mode="view"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="columns/column" mode="view"/>
								</xsl:otherwise>
							</xsl:choose>	
						</columnList>
					</group>
				</groups>
			</view>
		</xsl:template>

<!-- HISTORY VIEW -->		
		<xsl:template match="historyView">
			<xsl:param name="model"/>
			<xsl:variable name="table_name" select="../../../@name"/>
			<view name="historyView" type="historyView">
				<groups>
					<group groupType="tab" groupName="tab" groupLabel="tab" name="tab">
						<columnList>
							<xsl:choose>
								<xsl:when test="@allColumns='true'">
									<xsl:apply-templates select="$model/*/*[lower-case(@name)=lower-case($table_name)]/columns/column" mode="view"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="columns/column" mode="view"/>
								</xsl:otherwise>
							</xsl:choose>	
						</columnList>
					</group>
				</groups>
			</view>
		</xsl:template>

<!-- BREADCRUMB VIEW -->		
		<xsl:template match="breadcrumbView">
			<xsl:param name="model"/>
			<xsl:variable name="table_name" select="../../../@name"/>
			<view name="breadcrumbView" type="breadcrumbView">
				<groups>
					<group groupType="tab" groupName="tab" groupLabel="tab" name="tab">
						<columnList>
							<xsl:choose>
								<xsl:when test="@allColumns='true'">
									<xsl:apply-templates select="$model/*/*[lower-case(@name)=lower-case($table_name)]/columns/column" mode="view"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="columns/column" mode="view"/>
								</xsl:otherwise>
							</xsl:choose>	
						</columnList>
					</group>
				</groups>
			</view>
		</xsl:template>
				
<!-- DETAIL VIEW -->
		<xsl:template match="detailView">
			<view name="detailView" type="groupedDetail">
				<groups>
					<xsl:apply-templates select="groups/*"/>
				</groups>
			</view>
		</xsl:template>

<!-- EDIT VIEW 	
		<xsl:template match="editView">
			<view name="editView" type="addView">
				<groups>
					<xsl:apply-templates select="groups/*"/>
				</groups>
			</view>
		</xsl:template>
-->	



<!-- GROUPS -->
	<!-- detail view groups -->
		<xsl:template match="labeledRelatedList">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="LabeledRelatedList" label="{@columnLabel}" value="{@columnName}">
				<xsl:attribute name="relation">
					<xsl:choose>
						<xsl:when test="fn:matches(fn:lower-case(@relationship),'.*bridge.*')"><xsl:value-of select="@relationship" /></xsl:when>
						<xsl:otherwise>
							<xsl:text>rev_</xsl:text><xsl:value-of select="@relationship" />
						</xsl:otherwise>
					</xsl:choose>
					<!--<xsl:if test="not(sf:matches(fn:lower-case(@relationship),'.*bridge.*'))"><xsl:text>rev_</xsl:text></xsl:if><xsl:value-of select="current()/relatedEntity/@rel" />
					<xsl:value-of select="@relationship" />-->
				</xsl:attribute>
			</group>
		</xsl:template>
		
		<xsl:template match="labeledGroup">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="LabeledGroup">
				<columnList>
					<xsl:apply-templates select="columns/column" mode="view"/>
				</columnList>
			</group>
		</xsl:template>
		
		<xsl:template match="listGrid">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="ListGrid" relation="rev_{@relationship}"> <!--relation="{sf:replace(@relationship, ' : .*$', '')}"-->
				<columnList>
					<xsl:apply-templates select="columns/column" mode="view"/>
				</columnList>
			</group>
		</xsl:template>
		
	<!-- edit view groups 
		<xsl:template match="mnRelation">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="MnRelation" label="{@columnLabel}" value="{@columnName}">
				<xsl:attribute name="relation">
					<xsl:value-of select="current()/relatedEntity/@rel" />
				</xsl:attribute>
				<columnList>
					<xsl:apply-templates select="columns/column"/>
				</columnList>
			</group>
		</xsl:template>
		
		<xsl:template match="childRelation">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="ChildRelation" label="{@columnLabel}" value="{@columnName}">
				<xsl:attribute name="relation">
					<xsl:value-of select="current()/relatedEntity/@rel" />
				</xsl:attribute>
				<columnList>
					<xsl:apply-templates select="columns/column"/>
				</columnList>
			</group>
		</xsl:template>
		
		<xsl:template match="basicForm">
			<group name="{@name}" groupName="{@name}" groupLabel="{@label}" groupType="BasicForm" label="{@columnLabel}" value="{@columnName}">
				<xsl:attribute name="relation">
					<xsl:value-of select="current()/relatedEntity/@rel" />
				</xsl:attribute>
				<columnList>
					<xsl:apply-templates select="columns/column"/>
				</columnList>
			</group>
		</xsl:template>

-->	
</xsl:stylesheet>