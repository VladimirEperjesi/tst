<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_constants.xsl" />
<!-- bound to /logicalModel/masterModels/masterModel -->
 <xsl:template match="/*">
 <xsl:variable name="nmePrefix" select="sf:nvl($settings/lengthValidation/@nmePrefixLength,2)"/>
 <xsl:variable name="maxTabLength">
	 <xsl:call-template name="maxTableLength"><xsl:with-param name="db_name" select="$settings/lengthValidation/@databaseType"/></xsl:call-template>
 </xsl:variable>
   <xsl:variable name="maxColLength">
	 <xsl:call-template name="maxColumnLength"><xsl:with-param name="db_name" select="$settings/lengthValidation/@databaseType"/></xsl:call-template>
 </xsl:variable>
 <!--<xsl:variable name="maxTableLength" select="$setDatabases/setDatabase[@dbType=$settings/lengthValidation/@databaseType]/@tableLength"/>-->
 <xsl:variable name="layerPrefix" select="string-length(@name)"/>
  <maxLength>
    	<xsl:attribute name="maxTableLength">
        	<!-- a_party_Masters, tj, 2 nmePrefix, 7 layerPrefix -->
        	<xsl:value-of select="$maxTabLength - $nmePrefix - $layerPrefix - 2 - 4"/>  <!-- 3 instead of 4 when assume there is up to 11 indexes per table -->
        	<!-- 1 because of underscore in suffix with master layer name and 
        		 1 more because of x-prefixed tables (a_xparty_Masters), length of the name will be added on master layer (generated node masterLayer/maxLength)
        		 From maxTabLength is subtracted 4 as minimum (e.g. [a][x]party_[m]: 1 per nmePrefix, 1 per layerPrefix and 2 more for _ and x)
        		 
        		 additional 4 characters have to be subtracted because of indexes 	
        		 PK: A_XPARTY_M[_PK] 					3 chars subtracted -> always shorter then index  name, but there can be x variant (already counted in)
 		 
        		 IX: A_ADDRESS_MASTER[_IX1] or [_IX10] 	4 chars subtracted -> 5 because of index, but - 1 because this index pattern is not applicable for x-prefixed tables
        		 IX: a_xaddress_Master[_PK]				3 chars subtracted -> always shorter then previous index name, but there can be x variant (already counted in)
        		  -->
    	</xsl:attribute>
    	<xsl:attribute name="maxColumnLength">
        	<xsl:value-of select="$maxColLength"/> 
    	</xsl:attribute>
   </maxLength>
 </xsl:template>
 </xsl:stylesheet>

