<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
		
	<xsl:template match="/">
		<xsl:variable select="/table/columns/column[fn:lower-case(@isPk)='true']/@size" name="size"/>
		<pkValue>	
			<xsl:attribute name="valuepk">
					<xsl:call-template name="sum">	
						<xsl:with-param select="$size" name="sizes"/>
					</xsl:call-template>		
			</xsl:attribute>
		</pkValue>	
	</xsl:template>
	
	<xsl:template name="sum">
		<xsl:param select="0" name="tempsum"/>
		<xsl:param name="sizes"/>

		<xsl:choose>
			<xsl:when test="$sizes">
				<xsl:call-template name="sum">
					<xsl:with-param select="$sizes[position()&gt;1]" name="sizes"/>
					<xsl:with-param select="$tempsum + sf:nvl($sizes[1], 0)" name="tempsum"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$tempsum"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>	
	
</xsl:stylesheet>