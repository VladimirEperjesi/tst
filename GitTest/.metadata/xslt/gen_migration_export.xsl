<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="instanceTables" select="document('param:instanceTables')/*"/> <!--/preview/databaseModel/instanceTables -->
<xsl:param name="system" select="document('param:system')/*"/> <!--/system -->
<xsl:param name="dictionary" select="document('param:dictionary')/*"/>
<xsl:param name="instanceModel" select="document('param:instanceModel')/*"/>
<xsl:param name="advancedSettings" select="document('param:advancedSettings')/*"/>

<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:include href="incl_gen_plan_templates.xsl"/>

<xsl:template match="/*">
<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
<modelComment bounds="24,24,937,60" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
	<xsl:call-template name="load_plan_comment"/>
</modelComment>
	<xsl:apply-templates select="$instanceTables/physicalTable"/>
</purity-config>
</xsl:template>

<xsl:template match="physicalTable"> 
	<xsl:variable name="columns" select="columns"/>
	<xsl:variable name="tableName" select="@name"/>
	<xsl:variable name="dic" select="@dic"/>
	<xsl:variable name="histCols" select="lower-case($instanceModel/tables/table[lower-case(@name)=lower-case($tableName)]/advanced/historicalColumns/column/@name)"/>
	
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>      	
                <xsl:for-each select="columns/column[@name='id' or @name='source_id']">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each> 

                <xsl:for-each select="columns/column[(substring(@name,1,4))='eng_']">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each> 

                <xsl:for-each select="$advancedSettings/migration/tidColumns/tidColumn">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>              

                <xsl:for-each select="columns/column[@origin='source' and not(@name=$histCols)]">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>
  
                <!-- TODO / configuration has to be extended - now all matching column are used and constant for master_id is used instead-->
                <xsl:for-each select="columns/column[@origin='match' or @origin='internal_match']">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>
                
                <!--historical columns -->
                <xsl:for-each select="$instanceModel/tables/table[lower-case(@name)=lower-case($tableName)]/advanced/historicalColumns/column">
                	<columnDef name="{lower-case(@name)}" type="STRING"/>
                </xsl:for-each>            		
			</columns>
			<shadowColumns/>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*216)+48"/><xsl:text>,144,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>	
    
</xsl:template>

</xsl:stylesheet>