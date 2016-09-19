<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn comm">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="instances" select="document('param:instances')/*"/> <!--preview/databaseModel/instanceTables -->
<xsl:param name="tables" select="document('param:tables')/*"/> <!--logicalModel/instanceModel/tables -->

<xsl:include href="incl_constants.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="_constants.xsl"/>

<xsl:template match="/*">

<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
	<xsl:choose>
		<!-- full -->
		<xsl:when test="local-name(.)='allmatchings'">			
			<xsl:for-each select="$tables/table">
				<xsl:call-template name="tableAll">
					<xsl:with-param name="matchingDefinitions" select="matchingTab/multipleMatching/matchingDefinitions"/>
					<xsl:with-param name="defaultMatching" select="matchingTab/defaultMatchingDefinition"/>
					<xsl:with-param name="position" select="position()-1"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:when>
		<!-- partial -->
		<xsl:otherwise>
			<xsl:variable name="matchingName" select="matchings/matching/@name"/>
			<xsl:for-each select="$tables/table[matchingTab/multipleMatching/matchingDefinitions/matchingDefinition/@name = $matchingName or matchingTab/defaultMatchingDefinition/@name = $matchingName]">			
				<xsl:call-template name="table">
					<xsl:with-param name="matchingName" select="$matchingName"/>
					<xsl:with-param name="matchingDefinitions" select="matchingTab/multipleMatching/matchingDefinitions"/>
					<xsl:with-param name="defaultMatching" select="matchingTab/defaultMatchingDefinition"/>
					<xsl:with-param name="position" select="position()-1"/>
				</xsl:call-template>			
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</purity-config>
</xsl:template>

<xsl:template name="tableAll">
 	<xsl:param name="position"/>
 	<xsl:param name="matchingDefinitions"/>
 	<xsl:param name="defaultMatching"/>
	<xsl:variable name="name" select="@name"/>
		
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
		<properties>
			<requiredColumns>
				<requiredColumn name="operation" type="STRING"/>
				<requiredColumn name="id" type="LONG"/>
				<requiredColumn name="isolate_group_id" type="LONG"/>

				<!-- default matching -->
				<xsl:for-each select="$defaultMatching">
					<requiredColumn name="{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>
				<xsl:for-each select="$defaultMatching">
					<requiredColumn name="target_{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>						
						
				<!-- multiple matching -->				
				<xsl:for-each select="$matchingDefinitions/matchingDefinition">
					<requiredColumn name="{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>
				<xsl:for-each select="$matchingDefinitions/matchingDefinition">
					<requiredColumn name="target_{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>				
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

<xsl:template name="table">
 	<xsl:param name="position"/>
 	<xsl:param name="matchingDefinitions"/>
 	<xsl:param name="defaultMatching"/>
 	<xsl:param name="matchingName"/>
	<xsl:variable name="name" select="@name"/>
		
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
		<properties>
			<requiredColumns>
				<requiredColumn name="operation" type="STRING"/>
				<requiredColumn name="id" type="LONG"/>
				<requiredColumn name="isolate_group_id" type="LONG"/>

				<!-- default matching -->
				<xsl:for-each select="$defaultMatching[@name=$matchingName]">
					<requiredColumn name="{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>
				<xsl:for-each select="$defaultMatching[@name=$matchingName]">
					<requiredColumn name="target_{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>						
						
				<!-- multiple matching -->				
				<xsl:for-each select="$matchingDefinitions/matchingDefinition[@name=$matchingName]">
					<requiredColumn name="{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>
				<xsl:for-each select="$matchingDefinitions/matchingDefinition[@name=$matchingName]">
					<requiredColumn name="target_{@masterIdColumn}" type="LONG"/>
				</xsl:for-each>				
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

</xsl:stylesheet>