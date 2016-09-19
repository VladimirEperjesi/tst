<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!--<xsl:param name="instanceTables" select="document('param:instanceTables')/*"/>   /preview/databaseModel/instanceTables -->

<!-- Bound to /logicalModel -->
<xsl:template match="/*">
	<transformations>
		<xsl:for-each select="instanceModel/tables/table">
			<entity name="{lower-case(@name)}">
				<dummy name="{lower-case(@name)}_clean"/>
				<plans>
					<xsl:call-template name="instanceTablePlans" />
				</plans>
			</entity>
		</xsl:for-each>
  </transformations>
</xsl:template>

<xsl:template name="instanceTablePlans">
	<xsl:variable name="tableName" select="@name" />
	<xsl:variable name="dicToCleanse">
		<xsl:choose>
			<xsl:when test="/logicalModel/dictionary/tables/table[@name=current()/columns/column/@refData and @instUse='cleansing']">
				<xsl:value-of select="'true'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'false'" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:if test="columns/column[@isStd='true' or @isCio='true' or @isExp='true' or @isSco='true'] or $dicToCleanse='true' or advanced/specialColumns/column[fn:matches(@createInto,'.+_clean')]">
		<cleansingPlan name="{lower-case(@name)}_clean" entity="{lower-case(@name)}" layerName="instance" instanceEntity="{lower-case(@name)}" />
	</xsl:if>
	<xsl:if test="matchingTab[@matching='true']">
		<matchingPlan name="{lower-case(@name)}_match" entity="{lower-case(@name)}" layerName="instance" instanceEntity="{lower-case(@name)}" />
	</xsl:if>
	<xsl:if test="aggregationTab[@aggregation='true']">
		<aggregationPlan name="{lower-case(@name)}_aggregate" entity="{lower-case(@name)}" layerName="instance" instanceEntity="{lower-case(@name)}" />
	</xsl:if>
	<xsl:for-each select="/*/masterModels/*/masterTables/*[lower-case(@instanceTable)=lower-case($tableName)]">
		<mergingPlan name="{lower-case(../../@name)}_{lower-case(@name)}_merge" entity="{lower-case(@name)}" layerName="{lower-case(../../@name)}" 
			instanceEntity="{lower-case(@instanceTable)}" />
	</xsl:for-each>

</xsl:template>

</xsl:stylesheet>