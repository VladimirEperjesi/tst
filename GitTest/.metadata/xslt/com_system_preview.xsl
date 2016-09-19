<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:param name="guiConfig" select="document('param:guiConfig')/*"/>
	<xsl:template match="/*">
		<systems>
			<xsl:for-each select="system">
				<system name="{lower-case(@name)}"/>
			</xsl:for-each>
			<xsl:for-each select="$guiConfig">
				<xsl:if test="@guiMode='Read-Write' and @enableGui='true' and @guiSystem!=''">
					<system name="{lower-case(@guiSystem)}"/>
				</xsl:if>
			</xsl:for-each>
			
	  </systems>
	</xsl:template>

</xsl:stylesheet>