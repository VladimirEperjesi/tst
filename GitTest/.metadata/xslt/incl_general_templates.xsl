<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
 <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
 
 <!-- CONVERT DATA TYPES -->
 <!-- import model - logical model -->
 <xsl:template name="convertLogicalType">
	 <xsl:param name="type"/>
	 <xsl:param name="size"/>
	 <xsl:param name="precision"/>
		<xsl:choose>
				<xsl:when test="fn:matches(fn:upper-case($type),'BL')">boolean</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'D')">day</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'TS')">datetime</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'F.*')">float</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'TXT[0-9]*')">string</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'SI') ">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'LI') ">long</xsl:when>
				
				<xsl:when test="fn:matches(fn:upper-case($type),'V?A[0-9]*')">string</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $precision != ''">float</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $precision != ''">float</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $size &lt; 10">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $size &gt; 9">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') ">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $size &lt; 10">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $size &gt; 9">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'I')">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DT')">day</xsl:when>
				
				<xsl:otherwise><xsl:value-of select="fn:lower-case($type)"/></xsl:otherwise>
			</xsl:choose>
 </xsl:template>
 
 <!-- import model - physical model -->
 <xsl:template name="convertPhysicalType">
	 <xsl:param name="type"/>
	 <xsl:param name="size"/>
	 <xsl:param name="precision"/>
		 <xsl:choose>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'FLOAT.*')">float</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'SMALLINT')">integer</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'CLOB')">string</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'TIMESTAMP')">datetime</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DATE')">day</xsl:when>
		 		
		 		
				<xsl:when test="fn:matches(fn:upper-case($type),'(VAR)?CHAR.+')">string</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $precision !=''">float</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $precision !=''">float</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $size &lt; 10">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $size &gt; 9">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') ">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $size &lt; 10">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $size &gt; 9">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DATE.*')">datetime</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:lower-case($type)"/></xsl:otherwise>
			</xsl:choose>
</xsl:template>
<!-- import model in Connected Systems - logical model -->
 <xsl:template name="convertLogicalType_input">
	 <xsl:param name="type"/>
	 <xsl:param name="size"/>
	 <xsl:param name="precision"/>
		<xsl:choose>
				<xsl:when test="fn:matches(fn:upper-case($type),'BL')">boolean</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'D')">day</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'TS')">datetime</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'F')"><xsl:text>float</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'F[0-9]*')"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text>0<xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'F.*') and $precision != ''"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text><xsl:value-of select="$precision"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'TXT')">string(256)</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'TXT[0-9]*')"><xsl:text>string(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'SI') ">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'LI') ">long</xsl:when>
				
				<xsl:when test="fn:matches(fn:upper-case($type),'V?A[0-9]*')"><xsl:text>string(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $precision != ''"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text><xsl:value-of select="$precision"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $precision != ''"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text><xsl:value-of select="$precision"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $size &lt; 10"><xsl:text>integer(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') and $size &gt; 9"><xsl:text>long(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NO?.*') ">long</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $size &lt; 10"><xsl:text>integer(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DC?.*') and $size &gt; 9"><xsl:text>long(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'I')">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DT')">day</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:lower-case($type)"/></xsl:otherwise>
			</xsl:choose>
 </xsl:template>
 
 <!-- import model in Connected Systems - physical model -->
 <xsl:template name="convertPhysicalType_input">
	 <xsl:param name="type"/>
	 <xsl:param name="size"/>
	 <xsl:param name="precision"/>
		 <xsl:choose>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'FLOAT.*')">float</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'SMALLINT')">integer</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'CLOB')"><xsl:text>string(2000)</xsl:text></xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'TIMESTAMP')">datetime</xsl:when>
		 		<xsl:when test="fn:matches(fn:upper-case($type),'DATE')">day</xsl:when>
		 		
				<xsl:when test="fn:matches(fn:upper-case($type),'(VAR)?CHAR.+')"><xsl:text>string(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $precision !=''"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text><xsl:value-of select="$precision"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $precision !=''"><xsl:text>float(</xsl:text><xsl:value-of select="$size"/><xsl:text>,</xsl:text><xsl:value-of select="$precision"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $size &lt; 10"><xsl:text>integer(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') and $size &gt; 9"><xsl:text>long(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'NUMBER.*') ">integer</xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $size &lt; 10"><xsl:text>integer(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DECIMAL.*') and $size &gt; 9"><xsl:text>long(</xsl:text><xsl:value-of select="$size"/><xsl:text>)</xsl:text></xsl:when>
				<xsl:when test="fn:matches(fn:upper-case($type),'DATE.*')">datetime</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:lower-case($type)"/></xsl:otherwise>
			</xsl:choose>
</xsl:template>

</xsl:stylesheet>
