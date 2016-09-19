<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<!-- Bound to /logicalModel -->
<!--<xsl:template match="/logicalModel/instanceModel">-->
<xsl:template match="/logicalModel">
	<inputModel>
		<tables>
			<xsl:apply-templates select="instanceModel/*/table"/>
		</tables>
		<relationships>
			<xsl:apply-templates select="instanceModel/relationships/relationship"/>
		</relationships>
	</inputModel>
</xsl:template>


<xsl:template match="table">
	<table name="{@name}">
		<columns>
			<xsl:apply-templates select="columns/column[@isSrc='true' or @isPk='true' or @isFk='true' or not(isSrc) or (@isSrc='false' and @isCio='false' and @isStd='false' and @isExp='false' and @isSco='false' and @isPk='false' and @isFk='false')]"/>
		</columns>
		
	</table>
</xsl:template>

<xsl:template match="column">
	<xsl:choose>
		<xsl:when test="@isSrc='true'">
			<column name="src_{@name}" type="string" size="{@size}" isPk="{sf:nvl(@isPk,'false')}" isFk="{sf:nvl(@isFk,'false')}"/>
		</xsl:when>
		<!-- workaroung for dictionary table -->
		<xsl:when test="not(isSrc) and (@isSrc='false' or @isSrc='true')">
			<column name="{@name}" type="string" size="{@size}" isPk="{sf:nvl(@isPk,'false')}" isFk="{sf:nvl(@isFk,'false')}"/>
		</xsl:when>
		<xsl:otherwise>
				<column name="{@name}" type="string" size="{@size}" isPk="{sf:nvl(@isPk,'false')}" isFk="{sf:nvl(@isFk,'false')}" >
				<!-- Hidden attribute -->
					<xsl:attribute name="key">
						<xsl:choose>
							<xsl:when test="@isPk='true'"> PK</xsl:when>
							<xsl:when test="@isFk='true'"> FK</xsl:when>
						</xsl:choose>
					</xsl:attribute>
				<!-- End of hidden attribute -->
				</column>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template match="relationship">
	<relationship name="{@name}" parentTable="{@parentTable}" childTable="{@childTable}" parentColumn="{foreignKey/@parentColumn}" childColumn="{foreignKey/@childColumn}"/>
</xsl:template>

</xsl:stylesheet>