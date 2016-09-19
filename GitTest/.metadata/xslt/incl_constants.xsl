<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<!-- MDC version that is used in all plans in purity-config version 
<xsl:variable select="'10.2.0'" name="version"/>-->

<!-- DATABASES LIMITS TO TABLE AND COLUMN NAME LENGTH -->
<!-- any new db_name has to be defined in Preferences node mmd (enum)-->
<xsl:template name="maxTableLength">
	<xsl:param name="db_name"/>
	<xsl:choose>
		<xsl:when test="$db_name='Oracle R9+'">30</xsl:when>
		<xsl:when test="$db_name='MS SQL 2008+'">128</xsl:when>
		<xsl:when test="$db_name='PostgreSQL 8.2+'">63</xsl:when>
		<xsl:when test="$db_name='Apache Derby 10.6+'">128</xsl:when>
		<!-- <xsl:when test="$db_name='MySQL'">64</xsl:when> -->
		<xsl:when test="$db_name='IBM DB2 (LUW) 9+'">128</xsl:when>
		<xsl:when test="$db_name='IBM DB2 (z/OS) 10+'">128</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="maxColumnLength">
	<xsl:param name="db_name"/>
	<xsl:choose>
		<xsl:when test="$db_name='Oracle R9+'">30</xsl:when>
		<xsl:when test="$db_name='MS SQL 2008+'">128</xsl:when>
		<xsl:when test="$db_name='PostgreSQL 8.2+'">63</xsl:when>
		<xsl:when test="$db_name='Apache Derby 10.6+'">128</xsl:when>
		<!-- <xsl:when test="$db_name='MySQL'">64</xsl:when> -->
		<xsl:when test="$db_name='IBM DB2 (LUW) 9+'">128</xsl:when>
		<xsl:when test="$db_name='IBM DB2 (z/OS) 10+'">128</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>