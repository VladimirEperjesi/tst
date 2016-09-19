<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn comm">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="logicalModel" select="document('param:logicalModel')/*"/>
<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_gen_plan_templates.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:param name="master" select="document('param:master')/*"/>


<!-- bound to /preview/databaseModel/instanceTables/*[@name=$current/@instanceEntity] -->
<xsl:template match="/*">
<xsl:variable name="table_name" select="@name"/>
<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">

<modelComment bounds="68,20,926,125" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
	<xsl:call-template name="merging_plan_comment">
		<xsl:with-param name="master_column" select="$master/advanced/@groupColumn"/>
	</xsl:call-template>
</modelComment>

	<step id="in" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>
     
                <xsl:for-each select="columns/column[@load='true' or @origin='aggregate']">
                	<xsl:call-template name="column_def"/>
                	<xsl:call-template name="oldValueColumn">
						<xsl:with-param name="table_name" select="$table_name"/>
						<xsl:with-param name="logicalModel" select="$logicalModel"/>
					</xsl:call-template>
                </xsl:for-each>
                <columnDef name="eng_change_type" type="STRING"/>
                <columnDef name="eng_activity_change_type" type="STRING"/>
            </columns>
            <shadowColumns>
				  <!--  <xsl:for-each select="$master/columns/column[@origin!='internal']">
                	<xsl:call-template name="column"/>
                </xsl:for-each>
             <xsl:if test="$logicalModel/masterModels/masterModel[@name=current()/ancestor::]"-->
            </shadowColumns>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints bounds="216,192,-1,-1" layout="vertical"/>
    </step>

    <!-- <xsl:if test="$settings/@enableRC='false'"></xsl:if> -->
    <connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
        <source step="in" endpoint="out"/>
        <target step="out" endpoint="in"/>
    </connection>
		


	<step id="out" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
        <properties>
            <requiredColumns>
               <!-- <columnDef name="id" type="LONG"/>-->
                <xsl:for-each select="$master/columns/column[@origin!='internal']">
                	<xsl:call-template name="column_required"/>
                </xsl:for-each>
                <xsl:if test="$master/@customActivity='true'">
					<requiredColumn name="eng_active" type="BOOLEAN"/>
                </xsl:if>
            </requiredColumns>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints bounds="216,456,-1,-1" layout="vertical"/>
    </step>
</purity-config>
</xsl:template>

</xsl:stylesheet>