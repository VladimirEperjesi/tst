<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>	

<xsl:param name="fileName"/>    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="step[@className='com.ataccama.dqc.tasks.common.usersteps.io.OutputStep']">
		<step id="{lower-case(@id)}" className="{@className}" xmlns:comm="{@xmlns:comm}">
			<xsl:copy-of select="properties"/>
			<xsl:copy-of select="visual-constraints"/>
		</step>
    </xsl:template>
    
    <xsl:variable name="outputID" select="//step[@className='com.ataccama.dqc.tasks.common.usersteps.io.OutputStep']/@id"/>
    <xsl:template match="connection[target/@step = $outputID]">    		
		<connection className="{@className}" disabled="{@disabled}">
			<source step="{source/@step}" endpoint="{source/@endpoint}"/>
			<target step="{lower-case(target/@step)}" endpoint="{target/@endpoint}"/>
			<xsl:copy-of select="visual-constraints"/>
		</connection>
    </xsl:template>      	
</xsl:stylesheet>