<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="relationship" select="document('param:relationship')/*"/>
	<xsl:param name="tables" select="document('param:tables')/*"/>

 <xsl:template match="/*">

	<copyAfterC2P>
		<xsl:variable name="relName" select="$relationship/@parentTable"/>
		<xsl:attribute name="name">
			<xsl:choose>
				<xsl:when test="$tables/table[@name=$relName]/matchingTab/@matching='false'">
					<xsl:value-of select="'Copy after '"/>
					<xsl:value-of select="$relName"/>
					<xsl:value-of select="'_clean'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</copyAfterC2P>

 </xsl:template>

</xsl:stylesheet>

