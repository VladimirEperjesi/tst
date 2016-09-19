<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml" version="1.0"/>

<xsl:param name="fileName"/>    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="step[@className='com.ataccama.dqc.tasks.flow.RecordCounter']">
		<step id="{lower-case(@id)}" className="{@className}" xmlns:comm="{@xmlns:comm}">
			<xsl:copy-of select="properties"/>
			<xsl:copy-of select="visual-constraints"/>
		</step>
    </xsl:template>
 	
    <xsl:template match="connection[contains(target/@step,'counter')]">
		<connection className="{@className}" disabled="{@disabled}">
			<source step="{source/@step}" endpoint="{source/@endpoint}"/>
			<target step="{lower-case(target/@step)}" endpoint="{target/@endpoint}"/>
			<xsl:copy-of select="visual-constraints"/>
		</connection>
    </xsl:template> 	
    
    <xsl:template match="connection[contains(source/@step,'counter')]">
		<connection className="{@className}" disabled="{@disabled}">
			<source step="{lower-case(source/@step)}" endpoint="{source/@endpoint}"/>
			<target step="{target/@step}" endpoint="{target/@endpoint}"/>
			<xsl:copy-of select="visual-constraints"/>
		</connection>
    </xsl:template>      	
</xsl:stylesheet>