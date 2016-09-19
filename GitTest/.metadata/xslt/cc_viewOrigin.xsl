<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>	

	<xsl:param name="thisSystem" select="document('param:thisSystem')/*"/>
	<xsl:param name="thisMapping" select="document('param:thisMapping')/*"/>
	
	<xsl:template match="/">
	<viewOrigin>
		<xsl:attribute name="origin">
			<xsl:value-of select="$thisSystem/@name"/><xsl:text>#</xsl:text><xsl:value-of select="$thisMapping/@table"/><xsl:text>#</xsl:text><xsl:value-of select="$thisMapping/@entity"/>
		</xsl:attribute>
	</viewOrigin>	
	</xsl:template>

</xsl:stylesheet>