<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/model">
<!--/*/*[name()='bk:Books']/*[name()='bk:Book' and text()='Time Machine']-->
	<instanceModel>
	<tables>
		<xsl:apply-templates select="tables/table[@stereotype='instance' or not(@stereotype)]"/>
	</tables>
	<dicTables>
		<xsl:apply-templates select="tables/table[@stereotype='dictionary']"/>
	</dicTables>

	<relationships>
		<xsl:apply-templates select="relations/relation[@stereotype='instance' or not(@stereotype)]"/>
	</relationships>


		</instanceModel>
</xsl:template>

<xsl:template match="table">
	<table name="{@code}" description="{@comment}" label="{@name}">
		<columns>
			<xsl:apply-templates select="columns/column">
					<xsl:with-param name="table" select="."/>
			</xsl:apply-templates>
		</columns>
	</table>
</xsl:template>

<xsl:template match="column">
	<xsl:param name="table"/>
	<xsl:variable name="tableName" select="$table/@name"/>
	<column name="{@code}" description="{@comment}" size="{@length}" type="{@columnType}" label="{@name}">
		<xsl:attribute name="isPk">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code]">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isFk">
			<xsl:choose>
				<xsl:when test="//relations/relation[@childTable=$tableName]/foreignKeys/foreignKey[@childColumn=current()/@code]">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSrc">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSRC' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSRC' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isStd">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSTD' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSTD' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isCio">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isCIO' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isCIO' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
				<xsl:attribute name="isExp">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isEXP' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isEXP' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSco">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSCO' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isSCO' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<!--	<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="fn:matches(@baseDataType,'VA[0-9]+')">string</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:lower-case(@baseDataType)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>-->
	</column>
</xsl:template>

<xsl:template match="relation">	
	<relationship name="{@code}" parentTable="{//tables/table[@name=current()/@parentTable]/@code}" childTable="{//tables/table[@name=current()/@childTable]/@code}">
		<foreignKey> 
			<column parentColumn="{foreignKeys/foreignKey/@parentColumn}" childColumn="{foreignKeys/foreignKey/@childColumn}"/>
		</foreignKey>
	</relationship>
</xsl:template>
</xsl:stylesheet>