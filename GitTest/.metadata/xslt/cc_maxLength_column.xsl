<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_constants.xsl" />
<!-- bound to GeneralColumn and MasterColumn -->
 <xsl:template match="/*">
  <xsl:variable name="maxLength">
	 <xsl:call-template name="maxColumnLength"><xsl:with-param name="db_name" select="$settings/lengthValidation/@databaseType"/></xsl:call-template>
 </xsl:variable>
 
  <generatedColumnMaxLength>
		<xsl:attribute name="maxColumnLength">
			<xsl:choose>
				<xsl:when test="@isSrc='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:when test="@isCio='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:when test="@isStd='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:when test="@isExp='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:when test="@isSco='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:when test="@isCmo='true'"><xsl:value-of select="$maxLength - 4"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$maxLength"/></xsl:otherwise>
			</xsl:choose>
    	</xsl:attribute>
   </generatedColumnMaxLength>
 </xsl:template>
 </xsl:stylesheet>

