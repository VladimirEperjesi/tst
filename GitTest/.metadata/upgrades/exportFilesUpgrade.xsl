<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf fn" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml" version="1.0"/>

<xsl:param name="fileName"/>  
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>   
        </xsl:copy>
    </xsl:template>

    <xsl:template match="step[@className='com.ataccama.dqc.tasks.common.usersteps.io.InputStep']">
    	<xsl:variable name="prefix" select="replace(@id,'(.*)\.(.*)','$1')"/>
    	<xsl:variable name="name" select="lower-case(replace(@id,'(.*)\.',''))"/>
    	<xsl:choose>
    		<xsl:when test="contains(@id, '.')">
				<step id="{concat($prefix,'.',$name)}" className="{@className}" xmlns:comm="{@xmlns:comm}">
					<xsl:copy-of select="properties"/>
					<xsl:copy-of select="visual-constraints"/>
				</step>		
			</xsl:when>
			<xsl:otherwise>
				<step id="{$name}" className="{@className}" xmlns:comm="{@xmlns:comm}">
					<xsl:copy-of select="properties"/>
					<xsl:copy-of select="visual-constraints"/>
				</step>				
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
 	
 	<xsl:variable name="inputID" select="//step[@className='com.ataccama.dqc.tasks.common.usersteps.io.InputStep']/@id"/>
    <xsl:template match="connection[source/@step = $inputID]">
    	<xsl:variable name="prefix" select="replace(source/@step,'(.*)\.(.*)','$1')"/>
    	<xsl:variable name="name" select="lower-case(replace(source/@step,'(.*)\.',''))"/>
		<connection className="{@className}" disabled="{@disabled}">
	    	<xsl:choose>
	    		<xsl:when test="contains(source/@step, '.')">
					<source step="{concat($prefix,'.',$name)}" endpoint="{source/@endpoint}"/>	
				</xsl:when>
				<xsl:otherwise>
					<source step="{$name}" endpoint="{source/@endpoint}"/>		
				</xsl:otherwise>
			</xsl:choose>		
			<target step="{target/@step}" endpoint="{target/@endpoint}"/>
			<xsl:copy-of select="visual-constraints"/>
		</connection>
    </xsl:template> 	
       	
</xsl:stylesheet>