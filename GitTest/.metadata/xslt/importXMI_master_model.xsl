<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/model">
<!--/*/*[name()='bk:Books']/*[name()='bk:Book' and text()='Time Machine']-->
	<masterModel>
	<!--<instanceTables>
		<xsl:apply-templates select="tables/table[@stereotype='instance']"/>
	</instanceTables>-->
	
	<masterTables>
		<xsl:apply-templates select="tables/table[@stereotype='master' or not(@stereotype)]" mode="master"/>
	</masterTables>
	
	<instanceTables>
		<xsl:apply-templates select="tables/table[@stereotype='instance']" mode="instance"/>
	</instanceTables>
	<xsl:variable name="mas" select="tables"/>
	<relationships>
		<!--<xsl:apply-templates select="relations/relation[@parentTable=$mas/table[@stereotype='master']/@name]"/>-->
		<xsl:apply-templates select="relations/relation"/>
	</relationships>


		</masterModel>
</xsl:template>

<xsl:template match="table"  mode="master">
	<masterTable name="{@code}" label="{@name}" description="{@comment}">
		<columns>
			<xsl:apply-templates select="columns/column">
					<xsl:with-param name="table" select="."/>
			</xsl:apply-templates>
			
		</columns>
	</masterTable>
</xsl:template>

<xsl:template match="table" mode="instance" >
	<instanceTable name="{@code}" label="{@name}" description="{@comment}" instanceTable="{@code}">
		<!--<columns>
			<xsl:apply-templates select="columns/column"/>
		</columns>-->
	</instanceTable>
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
		<xsl:attribute name="isCmo">
			<xsl:choose>
				<xsl:when test="//relations/relation[@parentTable=$tableName or @childTable=$tableName]/foreignKeys/foreignKey[@parentColumn=current()/@code or @childColumn=current()/@code]">false</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isCMO' and @value='true']">true</xsl:when>
				<xsl:when test="extendedAttributes/attribute/attributes/attribute[@name='isCMO' and @value='false']">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<!--<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="fn:matches(@baseDataType,'VA[0-9]+')">string</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:lower-case(@baseDataType)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>-->
	</column>
</xsl:template>

<xsl:template match="relation">
	<relationship name="{@code}" parentTable="{//tables/table[@name=current()/@parentTable]/@code}" childTable="{//tables/table[@name=current()/@childTable]/@code}" label="{@name}">
		<foreignKey> 
			<!--<xsl:apply-templates select="foreignKey/column"/>-->
			<column parentColumn="{foreignKeys/foreignKey/@parentColumn}" childColumn="{foreignKeys/foreignKey/@childColumn}"/>
		</foreignKey>
	</relationship>
</xsl:template>
</xsl:stylesheet>