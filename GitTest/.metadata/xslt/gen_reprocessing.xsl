<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn comm">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="instances" select="document('param:instances')/*"/> <!--preview/databaseModel/instanceTables -->
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="_constants.xsl"/>

<xsl:template match="/*">
<xsl:variable name="record_id" select="@recordId"/>
<xsl:variable name="enableRematch" select="@enableRematch"/>

<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
	<xsl:if test="@allTables='true'">
		<xsl:for-each select="$instances/*">
			<xsl:call-template name="table">
				<xsl:with-param name="record_id" select="$record_id"/>
				<xsl:with-param name="enableRematch" select="$enableRematch"/>
				<xsl:with-param name="position" select="position()-1"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:if>
	<xsl:if test="@allTables='false'">
		<xsl:for-each select="entities/entity">
			<xsl:variable name="enableRematch" select="@enableRematch"/>
			<xsl:call-template name="table">
				<xsl:with-param name="enableEntityRematch" select="$enableRematch"/>
				<xsl:with-param name="position" select="position()-1"/>
			</xsl:call-template>
			
		<!--<modelComment bounds="312,96,217,73" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51"><xsl:value-of select="../../@recordId"/></modelComment>-->
		</xsl:for-each>
	</xsl:if>
</purity-config>
</xsl:template>


<xsl:template name="table">
<xsl:param name="record_id" />
<xsl:param name="position" />
<xsl:param name="enableRematch" />
<xsl:param name="enableEntityRematch" />
<xsl:variable name="identification" select="sf:nvl(../../@recordId,$record_id)"/>
<xsl:variable name="name" select="@name"/>
	 <step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
			<properties>
				<requiredColumns>
					<xsl:call-template name="columns">
						<xsl:with-param name="record_id" select="$identification"/>
					</xsl:call-template>
					<!-- used when rematch flag is defined globally -->
					<xsl:if test="$enableRematch='true'">
						<!-- instead of testing origin, there should be a purpose attribute or other better way-->
						<xsl:for-each select="virtualColumns/column[@origin='internal_match']">
							<requiredColumn name="{@name}" type="{@type}"/>
						</xsl:for-each>
					</xsl:if>
					<!-- used when rematch flag is defined on entity -->
					<xsl:if test="$enableEntityRematch='true'">
						<!-- instead of testing origin, there should be a purpose attribute or other better way -->
						<xsl:for-each select="$instances/*[@name=$name]/virtualColumns/column[@origin='internal_match']">
							<requiredColumn name="{@name}" type="{@type}"/>
						</xsl:for-each>
					</xsl:if>
				</requiredColumns>
				<comm:comment>
            		<xsl:call-template name="generated_step"/>
            	</comm:comment>
			</properties>
			<visual-constraints layout="vertical">
				<xsl:attribute name="bounds"><xsl:value-of select="($position*168)+288"/><xsl:text>,392,-1,-1</xsl:text></xsl:attribute>
			</visual-constraints>
	</step>
</xsl:template>

<xsl:template name="columns">
<xsl:param name="record_id" />
	<xsl:if test="$record_id='SOURCE_ID + ORIGIN'">
		<requiredColumn name="origin" type="STRING"/>
		<requiredColumn name="source_id" type="STRING"/>
	</xsl:if> 
	<xsl:if test="$record_id='ID (instance)'">
		<requiredColumn name="id" type="LONG"/>
	</xsl:if> 
</xsl:template>



</xsl:stylesheet>