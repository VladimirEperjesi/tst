<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_constants.xsl" />
<!-- bound to /logicalModel/instanceModel/tables/table -->
<!-- also bound to /logicalModel/dictionary/tables/table -->
 <xsl:template match="/*">
 <xsl:variable name="maxTabLength">
	 <xsl:call-template name="maxTableLength"><xsl:with-param name="db_name" select="$settings/lengthValidation/@databaseType"/></xsl:call-template>
 </xsl:variable>
  <xsl:variable name="maxColLength">
	 <xsl:call-template name="maxColumnLength"><xsl:with-param name="db_name" select="$settings/lengthValidation/@databaseType"/></xsl:call-template>
 </xsl:variable>
 	<maxLength>
 		<xsl:attribute name="maxInstTableLength"> 
 		
 		<xsl:if test="matchingTab/@matching='true'">
			<xsl:variable name="nmePrefix">
				<xsl:choose>
					<xsl:when test="$settings/lengthValidation/@nmePrefixLength &gt; 7">
						<xsl:value-of select="$settings/lengthValidation/@nmePrefixLength - 7"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			 </xsl:variable> 
			 <!--  there has to be compatible mode param to decide  -->
				 <xsl:if test="$settings/advancedSettings/@matchingCompatibility='true'">
					<xsl:value-of select="$maxTabLength - $nmePrefix - 9"/> 
					<!-- 
						meaning of the constant at the end: 
						9 because of unification extended indexes (<nme_prefix><entity>_DATA_IX0)
					--> 
				</xsl:if>
				<xsl:if test="$settings/advancedSettings/@matchingCompatibility='false'">					
					<xsl:value-of select="$maxTabLength - $nmePrefix - 3"/>										
				</xsl:if> 
			</xsl:if>
			
			<xsl:if test="matchingTab/@matching='false'">
				<xsl:variable name="nmePrefix">
					<xsl:value-of select="$settings/lengthValidation/@nmePrefixLength"/>
				</xsl:variable> 
			<xsl:value-of select="$maxTabLength - $nmePrefix - 7"/>  <!-- 6 instead of 7 when assume there is up to 11 indexes per table -->
			</xsl:if>
			<!-- meaning of the constant at the end: 
					2 because of _i suffix (A_PARTY_I) for instance tables  
					1 more because of x-prefixed tables (A_XPARTY_I) 
					4 more because of indexes (A_PARTY_I_IX0) => (_IX0) and (_IX10)  ( 5 other characters -1 previous)
				PK is shorter then index, thus it's safe (PARTY_I_PK resp. X_PARTY_I_PK) 	
				
				examples:
				A_PARTY_I_PK  (3) 
				A_PARTY_I_IX0 (4-1) or A_PARTY_I_IX40 (5-1)
				A_XPARTY_I_PK (3)
				
				
			-->
      
      <!-- reference data length -->
			
			<xsl:if test="@loadInst='true'">
				<xsl:variable name="nmePrefix">
					<xsl:value-of select="$settings/lengthValidation/@nmePrefixLength"/>
				</xsl:variable> 
				<xsl:value-of select="$maxTabLength - $nmePrefix - 7 - 3 - 6"/>  
			</xsl:if>		
			<xsl:if test="@loadMas='true' and @loadInst='false'">
				<xsl:variable name="nmePrefix">
					<xsl:value-of select="$settings/lengthValidation/@nmePrefixLength"/>
				</xsl:variable> 
				<xsl:value-of select="$maxTabLength - $nmePrefix - 7 - 3"/>  
			</xsl:if>
			<!-- meaning of the constant at the end: 
					6 is same for as instance table (don't expect more then 11 indexes)	/ 7 because of qrd prefix for history table				
					3 more because of rd_ prefix  (gender -> rd_gender)
					6 more because of _trans suffix for instance trans table  
			-->
    	</xsl:attribute>
    	
       	<xsl:attribute name="maxColumnLength">
			<xsl:value-of select="$maxColLength"/>
		</xsl:attribute>
		
		<!-- for multipleMatching -->
		<xsl:attribute name="maxInstMatchTableLength">
			<xsl:variable name="nmePrefix">
				<xsl:choose>
					<xsl:when test="$settings/lengthValidation/@nmePrefixLength &gt; 7">
						<xsl:value-of select="$settings/lengthValidation/@nmePrefixLength - 7"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$settings/lengthValidation/@nmePrefixLength"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>		
			<xsl:variable name="entityLength">
				<xsl:value-of select="string-length(@name)"/>
			</xsl:variable>
			<xsl:if test="$settings/advancedSettings/@matchingCompatibility='false'">					
				<xsl:value-of select="$maxTabLength - $nmePrefix - $entityLength - 8"/>
				<!-- 
					3: _K_
					4: _IXn
					1: x-prefixed tables
				-->								
				<!-- 				  
					new matching: 
					not sure about the indexies - index(3-4 chars - including underscore _PK,_IX0-_IX9)
					<nme_prefix><entity>_K_K_index (8 chars + 1 name)
					<nme_prefix><entity>_K_(name)_index	(8 chars + length(name))		
					<nme_prefix>X<entity>_K_(name)_index (8 chars + length(name))					
				-->				
			</xsl:if> 
		</xsl:attribute>
   </maxLength>
 </xsl:template>
 </xsl:stylesheet>

