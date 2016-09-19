<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/> 

<xsl:param name="logicalModel" select="document('param:logicalModel')/*"/>  <!-- /logicalModel/masterModels-->
<xsl:param name="guiPreview" select="document('param:guiPreview')/*"/>  <!-- /preview/guiPreview-->
<xsl:param name="systems" select="document('param:systems')/*"/>  <!-- /systems-->
<xsl:param name="settings" select="document('param:settings')/*"/>  <!-- /settings-->
<xsl:param name="advancedSettings" select="document('param:advancedSettings')/*"/>  <!-- /advancedSettings-->
<xsl:param name="outputOperations" select="document('param:outputOperations')/*"/>  <!-- /outputOperations-->

<!-- bound to /preview/databaseModel -->
<xsl:template match="/databaseModel">
<xsl:variable name="root" select="."/>
	<documentation>
		<modelDocumentation>
			<instanceTables>
				<xsl:apply-templates select="instanceTables/physicalTable" mode="instance"/>
			</instanceTables>
			<masterLayers>
				<xsl:apply-templates select="$logicalModel/masterModels/masterModel">
					<xsl:with-param name="root" select="$root"/>
				</xsl:apply-templates>
			</masterLayers>
			<refDataTables>
				<xsl:apply-templates select="refData/physicalTable" mode="dic"/>
			</refDataTables>
		</modelDocumentation>
		<guiDocumentation masterLayer="{$guiPreview/masterModels/model/@name}">
		<entities>
			<xsl:apply-templates select="$logicalModel/masterModels/masterModel[@name=$guiPreview/masterModels/model/@name]/masterTables/masterTable" mode="guiTable">
				<xsl:with-param name="mode" select="'master'"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="$logicalModel/masterModels/masterModel[@name=$guiPreview/masterModels/model/@name]/instanceTables/instanceTable" mode="guiTable">
				<xsl:with-param name="mode" select="'instance'"/>	
			</xsl:apply-templates>
		</entities>
	</guiDocumentation>
		<technicalDocumentation>
			<sourceSystems>
				<xsl:apply-templates select="$systems/system"/>
			</sourceSystems>
			<other taskInfoPlan="{$advancedSettings/taskInfoExport/@name}" taskInfo="{$advancedSettings/taskInfoExport/@enable}" taskInfoDesc="{$advancedSettings/taskInfoExport/@description|$advancedSettings/taskInfoExport/description}">
				<xsl:attribute name="doReprocess">
					<xsl:choose>
						<xsl:when test="$advancedSettings/reprocessSettings/reprocess/*">true</xsl:when>
						<xsl:otherwise>false</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<reprocess>
					<xsl:apply-templates select="$advancedSettings/reprocessSettings/reprocess/*" mode="reprocess"/>
				</reprocess>
			</other>
			<exportOperations>
				<xsl:apply-templates select="$outputOperations/exportModel/*" mode="export"/>
			</exportOperations>
			<eventHandlers>
				<xsl:apply-templates select="$outputOperations/eventHandler/handlers/handler"/>
			</eventHandlers>
		</technicalDocumentation>
	</documentation>
</xsl:template>


<xsl:template match="physicalTable" mode="instance">
	<table name="{@name}" type="{@type}" layer="instance" desc="{@description|description}" >
		<xsl:attribute name="cleansingPlan">
			<xsl:choose>
				<xsl:when test="columns/column[@origin='clean']"><xsl:value-of select="@name"/><xsl:text>_clean.comp</xsl:text></xsl:when>
				<xsl:otherwise>NO CLEANSING</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="matchingPlan">
			<xsl:choose>
				<xsl:when test="columns/column[@origin='match']"><xsl:value-of select="@name"/><xsl:text>_match.comp</xsl:text></xsl:when>
				<xsl:otherwise>NO MATCHING</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="aggregatingPlan">
			<xsl:choose>
				<xsl:when test="columns/column[@origin='aggregation']"><xsl:value-of select="@name"/><xsl:text>_aggregate.comp</xsl:text></xsl:when>
				<xsl:otherwise>NO AGGREGATING</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>		
		<columns>
			<xsl:apply-templates select="columns/column" mode="instance"/>
		</columns>
		<relationships>
			<xsl:apply-templates select="relationships/relationship">
				<xsl:with-param name="type" select="'instance'"/>
			</xsl:apply-templates>
		</relationships>
	</table>
</xsl:template>

<xsl:template match="masterModel" >
<xsl:param name="root"/>
	<!-- desc missing -->
	<xsl:variable name="layerDescription" select="$logicalModel/masterModels/masterModel[@name=current()/@name]/@description|$logicalModel/masterModels/masterModel[@name=current()/@name]/description"/>
	<layer name="{@name}" desc="{$layerDescription}">
		<masterTables>
			<xsl:apply-templates select="masterTables/masterTable">
				<xsl:with-param name="root" select="$root"/>
			</xsl:apply-templates>
		</masterTables>
	</layer>
</xsl:template>

<xsl:template match="masterTable" >
<xsl:param name="root"/>
<xsl:variable name="layer" select="../../@name"/>
<xsl:variable name="tableDescription" select="$logicalModel/masterModels/masterModel[@name=$layer]/masterTables/masterTable[@name=current()/@name]/@description|$logicalModel/masterModels/masterModel[@name=$layer]/masterTables/masterTable[@name=current()/@name]/description"/>
	<table name="{@name}" type="{@entityRole}"  layer="{$layer}" mergingPlan="{$layer}_{@name}_merge.comp" desc="{@description|description}">
		<!--  was: desc="{$tableDescription}" -->
		<columns>
			<xsl:apply-templates select="$root/masterTables/physicalTable[@name=current()/@name and @layerName=$layer]/columns/column" mode="master">
			</xsl:apply-templates>
		</columns>
		<relationships>
			<xsl:apply-templates select="$root/masterTables/physicalTable[@name=current()/@name and @layerName=$layer]/relationships/relationship">
				<xsl:with-param name="type" select="'master'"/>
			</xsl:apply-templates>
		</relationships>
	</table>
</xsl:template>

<xsl:template match="physicalTable" mode="dic">
<xsl:variable name="tableDescription" select="$logicalModel/dictionary/tables/table[concat('rd_',@name)=current()/@name]/@description|$logicalModel/dictionary/tables/table[concat('rd_',@name)=current()/@name]/description"/>
	<table name="{@name}" type="{@type}"  layer="{@layerName}" desc="{@description|description}"> 
		<columns>
			<xsl:apply-templates select="columns/column" mode="dic"/>
		</columns>
	</table>
</xsl:template>

<xsl:template match="masterTable" mode="gui">
<xsl:param name="tableNode"/>
	<entity name="{@name}" label="{@label}" comment="{@description|description}">
		<xsl:apply-templates select="guiTab/views/*" mode="view">
			<xsl:with-param name="tableNode" select="$tableNode"/>
		</xsl:apply-templates>
	</entity>
</xsl:template>

<xsl:template match="gridView" mode="view">
<xsl:param name="tableNode"/>
<!--<xsl:variable name="tableNode" select="../../.."/>-->
	<gridView>
		<columns>
			<xsl:apply-templates select="columns/column" mode="gui">
			<xsl:with-param name="tableNode" select="$tableNode"/>
				<!--<xsl:with-param name="tableNode" select="$tableNode"/>-->
			</xsl:apply-templates>
		</columns>
	</gridView>
</xsl:template>

<xsl:template match="column" mode="gui">
<xsl:param name="tableNode"/>
<!--<xsl:param name="tableNode"/>-->
<xsl:variable name="columnName" select="fn:replace(@name,'cmo_(.+)','$1')"/> <!-- jeste advanced/specialColumns -->
<xsl:variable name="label" select="$tableNode/columns/column[@name=$columnName]/@label"/>
		<column label="{$label}" name="{@name}" desc="{@description|description}"/>
</xsl:template>

<xsl:template match="column" mode="master">
	<xsl:variable name="prefix" select="fn:replace(@name,'(cmo)_(.+)','$1')"/>
	<xsl:variable name="name" select="fn:replace(@name,'(cmo)_(.+)','$2')"/>
	<!--<xsl:variable name="name" select="@name"/>-->
	<xsl:variable name="columnDescription" select="$logicalModel/masterModels/masterModel/masterTables/masterTable[@name=current()/../../@name]/columns/column[@name=$name]/@description|$logicalModel/masterModels/masterModel/masterTables/masterTable[@name=current()/../../@name]/columns/column[@name=$name]/description"/>
	<column name="{@name}" type="{@type}" size="{@size}" origin="{@origin}" desc="{@description|description}" pk="{@isPk}" fk="{@isFk}">
		<!--<xsl:attribute name="name">
			<xsl:choose>
				<xsl:when test="@isCmo='true'"><xsl:text>cmo_</xsl:text><xsl:value-of select="@name"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>-->
	</column>
</xsl:template>


<xsl:template match="column" mode="dic">
	<xsl:variable name="columnDescription" select="$logicalModel/instanceModel/tables/table[@name=current()/../../@name]/columns/column[@name=current()/@name]/@description|$logicalModel/instanceModel/tables/table[@name=current()/../../@name]/columns/column[@name=current()/@name]/description"/>
	<column name="{@name}" type="{@type}" size="{@size}" origin="{@origin}" desc="{@description|description}" pk="{@isPk}" fk="{@isFk}"></column>
</xsl:template>

<xsl:template match="column" mode="instance">
	<xsl:variable name="prefix" select="fn:replace(@name,'(src|cio|exp|sco|std|dic)_(.+)','$1')"/>
	<xsl:variable name="name" select="fn:replace(@name,'(src|cio|exp|sco|std|dic)_(.+)','$2')"/>
	<xsl:variable name="columnDescription" select="$logicalModel/instanceModel/tables/table[@name=current()/../../@name]/columns/column[@name=$name]/@description|$logicalModel/instanceModel/tables/table[@name=current()/../../@name]/columns/column[@name=$name]/description"/>
	
	<column name="{@name}" type="{@type}" size="{@size}" origin="{@origin}" desc="{@description|description}" pk="{@isPk}" fk="{@isFk}"></column>
</xsl:template>

<xsl:template match="relationship">
	<xsl:param name="type"/>
	<!-- TODO: doesn't work --> 
	<!--<xsl:variable name="relInstDescription" select="$logicalModel/instanceModel/relationships/relationship[@childTable=current()/@childTable]/@description|$logicalModel/instanceModel/relationships/relationship[@childTable=current()/@childTable]/description"/>
	
	<xsl:variable name="relMasDescription" select="$logicalModel/masterModels/masterModel[@name=current()/@name]/relationships/relationship[@childTable=current()/@childTable]/@description|$logicalModel/masterModels/masterModel[@name=$layer]/relationships/relationship[@childTable=current()/@childTable]/description"/>-->
	<relationship name="{@name}" parentRole="{@parentRole}" childRole="{@childRole}" parentTable="{@parentTable}" childTable="{@childTable}" parentColumn="{@parentColumn}" childColumn="{@childColumn}" type="{$type}" desc="{@description|description}"/>
</xsl:template>

<!-- bound to $guiPreview/masterModels/model/masterTables/masterTable or instanceTables/instanceTable -->
<xsl:template match="*" mode="guiTable">
<xsl:param name="mode"/>
	<entity label="{@label}" name="{@name}" topLevel="{@topLevel}" layer="{$mode}" >
		<xsl:attribute name="desc">
			<xsl:variable name="instanceDesc" select="$logicalModel/instanceModel/tables/table[@name=current()/@instanceTable]/@description|$logicalModel/instanceModel/tables/table[@name=current()/@instanceTable]/description"/>
			<xsl:value-of select="sf:nvl(@description|description,$instanceDesc)"/>
		</xsl:attribute>
		<xsl:apply-templates select="guiTab/views/*" >
		</xsl:apply-templates>
	</entity>
</xsl:template>

<!-- VIEWS -->		
<xsl:template match="gridView">
<xsl:param name="table"/>
	<xsl:variable name="table_name" select="../../../@name"/>
	<gridView desc="Search results in grid, related records in grid">
		<columns>
			<xsl:choose>
				<xsl:when test="@allColumns='true'">
					<xsl:apply-templates select="$guiPreview/masterModels/model/*/*[@name=$table_name]/columns/column" mode="view2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="columns/column" mode="view">
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>	
		</columns>
	</gridView>
</xsl:template>
		
<xsl:template match="cartView">
<xsl:variable name="table_name" select="../../../@name"/>
	<cartView desc="Display of record in cart panel">
		<columns>
			<xsl:choose>
				<xsl:when test="@allColumns='true'">
					<xsl:apply-templates select="$guiPreview/masterModels/model/*/*[@name=$table_name]/columns/column" mode="view2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="columns/column" mode="view">
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>	
		</columns>
	</cartView>
</xsl:template>

<xsl:template match="historyView">
<xsl:variable name="table_name" select="../../../@name"/>
	<historyView desc="Display of record in history panel">
		<columns>
			<xsl:choose>
				<xsl:when test="@allColumns='true'">
					<xsl:apply-templates select="$guiPreview/masterModels/model/*/*[@name=$table_name]/columns/column" mode="view2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="columns/column" mode="view">
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>	
		</columns>
	</historyView>
</xsl:template>

<xsl:template match="detailedView">
<xsl:variable name="table_name" select="../../../@name"/>
	<detailedView desc="Detail view of record, possibility to display related records">
		<groups>
		
		</groups>
	</detailedView>
</xsl:template>

<xsl:template match="column" mode="view">
<xsl:variable name="columnName" select="fn:replace(@name,'^(cmo|eng|src|std|cio|exp|sco|dic)_(.+)$','$2')"/> 
<xsl:variable name="label" select="sf:nvl($guiPreview/masterModels/model[@name=current()/ancestor::model/@name]/*/*[@name=current()/ancestor::masterTable/@name]/columns/column[@name=current()/@name]/@label, $guiPreview/masterModels/model[@name=current()/ancestor::model/@name]/*/*[@name=current()/ancestor::instanceTable/@name]/columns/column[@name=current()/@name]/@finalLabel)"/>
	<column label="{sf:nvl($label,@name)}" name="{@name}" desc="{@description|description}">

	</column>
</xsl:template>
<!-- desc="{ancestor::masterTable/columns/column[@name=$columnName]/@description}"> -->
<!-- desc="{$logicalModel/masterModels/masterModel/masterTables/masterTable[@name=current()/ancestor::masterTable/@name]/columns/column[@name=$columnName]/@description}"-->
<xsl:template match="column" mode="view2">
	<xsl:variable name="label" select="'XYZ'"/>
	<column label="{sf:nvl($label,@name)}" name="{@name}" desc="{@description|description}"/>
</xsl:template>

<xsl:template match="system">
	<sourceSystem name="{@name}" desc="{@description|description}">
		<entities>
			<xsl:apply-templates select="sourceMappings/mapping"/>
		</entities>
		<plans>
			<xsl:apply-templates select="loadOperations/*" mode="loadOp"/>
		</plans>
	</sourceSystem>
</xsl:template>

<xsl:template match="mapping">
	<entity name="{@entity}" desc="{$logicalModel/instanceModel/tables/table[@name=current()/@entity]/@description|$logicalModel/instanceModel/tables/table[@name=current()/@entity]/description}">
		<columns>
			<xsl:apply-templates select="ancestor::system/loadOperations/*/advanced/ignoredComparisonColumns/ignoredComparisonColumn[entities/entity/@name=current()/@entity or @allEntities='true']"/>
			<xsl:apply-templates select="$settings/advanced/ignoredComparisonColumns/ignoredComparisonColumn[entities/entity/@name=current()/@entity or @allEntities='true']"/>
		</columns>
	</entity>
</xsl:template>

<xsl:template match="table" mode="loadedTable">
	<entity name="{@name}" desc="{$logicalModel/instanceModel/tables/table[@name=current()/@name]/@description|$logicalModel/instanceModel/tables/table[@name=current()/@name]/description}">
		<columns>
			<xsl:apply-templates select="ancestor::system/loadOperations/*/advanced/ignoredComparisonColumns/ignoredComparisonColumn[entities/entity/@name=current()/@name or @allEntities='true']"/>
			<xsl:apply-templates select="$settings/advanced/ignoredComparisonColumns/ignoredComparisonColumn[entities/entity/@name=current()/@name or @allEntities='true']"/>
		</columns>
	</entity>
</xsl:template>

<xsl:template match="*" mode="loadOp">
	<plan name="{../../@name}_{@nameSuffix}.comp" desc="{local-name(.)}">
		<xsl:attribute name="deletionStrategy">
			<xsl:choose>
				<xsl:when test="advanced/@deletionStrategy ='deactivate' or advanced/@deletionStrategy ='delete'"><xsl:value-of select="advanced/@deletionStrategy"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$settings/@deletionStrategy"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<entities>
			<xsl:if test="@allTables='true'">
				<xsl:apply-templates select="ancestor::system/sourceMappings/mapping"/>
			</xsl:if>
			<xsl:if test="@allTables='false'">
				<xsl:apply-templates select="*/table" mode="loadedTable"/>
			</xsl:if>
		</entities>
	</plan>
</xsl:template>

<xsl:template match="ignoredComparisonColumn">
	<column name="{@name}" desc="{@description|description}"/>
</xsl:template>

<xsl:template match="*" mode="reprocess">
	<plan name="{@plan}" type="{local-name(.)}" desc="{@description|description}"/>
</xsl:template>

<xsl:template match="*" mode="export">
	<xsl:if test="local-name(.) = 'fullMasterExport' or local-name(.) = 'fullInstanceExport'">
		<exportOperation type="{local-name(.)}" name="{@name}" scope="{@scope}" desc="{@description|description}" layerName="{@layerName}" allEntities="{@allEntities}" sourceSystem="{@sourceSystem}">
			<entities>
				<xsl:if test="@allEntities='false'">
					<xsl:apply-templates select="selectedTables/*" mode="exportTables"/>
				</xsl:if>
				<xsl:if test="@allEntities='true'">
					<xsl:if test="local-name(.) = 'fullInstanceExport'">
						<xsl:apply-templates select="/databaseModel/instanceTables/physicalTable" mode="exportTables"/>
					</xsl:if>
					<xsl:if test="local-name(.) = 'fullMasterExport'">
							<xsl:apply-templates select="/databaseModel/masterTables/physicalTable[@layerName=current()/@layerName]" mode="exportTables"/>
					</xsl:if>
				</xsl:if>
			</entities>
		</exportOperation>
	</xsl:if>
	<xsl:if test="local-name(.) = 'complexExport'">
		<exportOperation type="{local-name(.)}" name="{@name}" scope="{@scope}" desc="{@description|description}">
			<dataSources>
				<xsl:apply-templates select="dataSources/*" mode="exportDataSource"/>
			</dataSources>
		</exportOperation>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="exportTables">
	<entity name="{@name}" ></entity>
</xsl:template>

<xsl:template match="*" mode="exportDataSource">
	<dataSource type="{local-name(.)}" mode="{@mode}" scope="{@scope}" allEntities="{@allEntities}" sourceSystem="{@sourceSystem}" layerName="{@layerName}">
		<entities>
			<xsl:if test="@allEntities='false'">
					<xsl:apply-templates select="selectedTables/*" mode="exportTables"/>
				</xsl:if>
				<xsl:if test="@allEntities='true'">
					<xsl:if test="local-name(.) = 'instanceDataSource' or local-name(.) = 'conditionalInstanceDataSource'">
						<xsl:apply-templates select="/databaseModel/instanceTables/physicalTable" mode="exportTables"/>
					</xsl:if>
					<xsl:if test="local-name(.) = 'masterDataSource' or local-name(.) = 'conditionalMasterDataSource'">
							<xsl:apply-templates select="/databaseModel/masterTables/physicalTable[@layerName=current()/@layerName]" mode="exportTables"/>
					</xsl:if>
				</xsl:if>
		</entities>
	</dataSource>
</xsl:template>

<xsl:template match="handler">
	<xsl:if test="@enable='true'">
		<eventHandler name="{@class}" desc="{@desc}" enabled="{@enable}"> 
			<publishers>
				<xsl:for-each select="publishers/*"> 	
					<xsl:apply-templates select="." mode="publisher"/>
				</xsl:for-each>
			</publishers>
		</eventHandler>
		
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="publisher">
	<xsl:if test="@enable='true'">
		<publisher desc="{@description|description}" name="{name()}">
		</publisher>
	</xsl:if>
	
</xsl:template>

</xsl:stylesheet>