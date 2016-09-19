<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_general_templates.xsl"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:variable name="lookups" select="document('param:lookups')/*"/>
<xsl:param name="systems" select="document('param:systems')/*"/>
<xsl:param name="dictionary" select="document('param:dictionary')/*"/>

<xsl:template match="/*">
<purity-config version="{$version}">
	<modelComment bounds="48,24,445,73" borderColor="183,183,0" backgroundColor="128,255,255" foregroundColor="51,51,51">The following source system constants are expected to be used for translation purpose:
	<xsl:for-each select="$systems/system">
		<xsl:value-of select="fn:upper-case(@name)"/><xsl:text>, </xsl:text>
	</xsl:for-each>
	</modelComment>
	<xsl:apply-templates select="tables/table[@instUse !='none']" />	
	<xsl:if test="tables/table[@usageValidation !='none']">
		<xsl:call-template name="validTable"/>
	</xsl:if>
</purity-config>
</xsl:template>

<xsl:template match="table" >
<xsl:variable name="tableNameTrans" ><xsl:text>rd_</xsl:text><xsl:value-of select="@name"/><xsl:text>_trans</xsl:text></xsl:variable>
<!--
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		<properties>
		    <columns>
				<xsl:call-template name="inst_cols"/>
				<xsl:apply-templates select="columns/column[@instance='true']" />					
			</columns>
			<shadowColumns />
			
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*168)+288" />,24,-1,-1</xsl:attribute>
		</visual-constraints>
	</step>
-->	

	<step id="Map_columns_{$tableNameTrans}" className="com.ataccama.dqc.tasks.flow.AlterFormat">
		<properties>
			<addedColumns>
				<mrg:mergeChildren key="@name">
				 <xsl:for-each select="$lookups/physicalTable[@name=$tableNameTrans]/columns/column[@origin='source']">
                	<xsl:call-template name="column_af"/>
                </xsl:for-each>                
                </mrg:mergeChildren>
                <xsl:for-each select="columns/column[@instance='true']">
                	<addedColumn name="{@name}" type="STRING"/>
                </xsl:for-each>
			</addedColumns>
			<removedColumns>
				<mrg:mergeChildren key="@name">
					<!--<columnRef mrg:retainNodes="name"/>-->
				</mrg:mergeChildren>
			</removedColumns>
			<comm:comment>
            	<xsl:call-template name="generated_AFmapping_step"/>
            </comm:comment>
		</properties>
		 <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,312,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
	</step>
	
	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
		<source step="Map_columns_{$tableNameTrans}" endpoint="out"/>
		<target step="{$tableNameTrans}" endpoint="in"/>
		<visual-constraints>
			<bendpoints/>
		</visual-constraints>
	</connection>
		
	<!-- (Lookup Builder) -->			
		<step id="{$tableNameTrans}" className="com.ataccama.dqc.tasks.builders.LookupBuilder" disabled="false" mode="NORMAL">
			<properties approximativeIndex="{sf:nvl(lookupSettings/@approxIndex,'false')}" duplicities="{sf:nvl(lookupSettings/@duplicities,'FIRST')}" bestDistanceIndex="{sf:nvl(lookupSettings/@bestDistanceIndex,'false')}" fileName="pathvar://HUB_RD_LKP/{@name}_trans.lkp" bidirectApproximativeIndex="{lookupSettings/@bidirectApproxIndex}" key="source_code">
			    <additionalColumns>
			       <xsl:call-template name="inst_cols_builder"/>
			       <!-- <xsl:apply-templates select="columns/column[@instance='true']" mode="builder"/>-->
			       <xsl:apply-templates select="columns/column[@instance='true']" mode="builder"/>
		        </additionalColumns>
			    <matchingValue substituteWith="{lookupSettings/@substituteWith}" supportedCharacters="{sf:nvl(lookupSettings/@supportedChars,'[:all:]')}" doRemoveRepeatedChars="{lookupSettings/@removeRepeatedChars}" doSqueezeWS="{lookupSettings/@squeezeWS}" doRemoveDia="{lookupSettings/@removeAccents}" doUpperCase="{lookupSettings/@upperCase}"/>
			    <userMetadata>
			        <items/>
			        	</userMetadata>
			    <comm:comment>
            		<xsl:call-template name="generated_step"/>
            	</comm:comment>
			</properties>
			<visual-constraints layout="vertical">
				<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+48" />,480,-1,-1</xsl:attribute>
			</visual-constraints>        
		</step>								                 

</xsl:template>

<!-- ================= VALID ===================== -->
<xsl:template name="validTable" >		
	<xsl:for-each select="$dictionary/tables/table">	
		<xsl:variable name="tableNameValid" ><xsl:text>rd_</xsl:text><xsl:value-of select="@name"/><xsl:text>_valid</xsl:text></xsl:variable>	
		<xsl:if test="@usageValidation != 'none'">	
			<!-- valid alterFormat -->
			<step id="Map_columns_{$tableNameValid}" className="com.ataccama.dqc.tasks.flow.AlterFormat">
				<properties>
					<addedColumns>
						<addedColumn expression="master_code_in" name="master_code" type="{@masterCodeType}"/>
						<addedColumn name="master_name" type="STRING"/>
						<addedColumn name="source_timestamp" type="DATETIME"/>
						<xsl:for-each select="columns/column[@master='true']">
                			<addedColumn name="{@name}" type="STRING"/>
                		</xsl:for-each>
					</addedColumns>
					<removedColumns>
						<mrg:mergeChildren key="@name">
							<!--<columnRef mrg:retainNodes="name"/>-->
						</mrg:mergeChildren>
					</removedColumns>
					<comm:comment>
            			<xsl:call-template name="generated_AFmapping_step"/>
            		</comm:comment>
				</properties>
				 <visual-constraints layout="vertical">
					<xsl:attribute name="bounds">
						<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,312,-1,-1</xsl:text>
					</xsl:attribute>
				</visual-constraints>
			</step>		
			
			<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
				<source step="Map_columns_{$tableNameValid}" endpoint="out"/>
				<target step="{$tableNameValid}" endpoint="in"/>
				<visual-constraints>
					<bendpoints/>
				</visual-constraints>
			</connection>
			
			<!-- valid lookup builder -->  
			<step id="{$tableNameValid}" className="com.ataccama.dqc.tasks.builders.LookupBuilder" disabled="false" mode="NORMAL">
				<properties approximativeIndex="{sf:nvl(lookupSettings/@approxIndex,'false')}" duplicities="{sf:nvl(lookupSettings/@duplicities,'FIRST')}" bestDistanceIndex="{sf:nvl(lookupSettings/@bestDistanceIndex,'false')}" fileName="pathvar://HUB_RD_LKP/{@name}_valid.lkp" bidirectApproximativeIndex="{lookupSettings/@bidirectApproxIndex}" key="master_code">
				    <additionalColumns>
				       <columnExprDef expression="master_code" name="master_code"/>
				       <columnExprDef expression="master_name" name="master_name"/>
				       <xsl:apply-templates select="columns/column[@master='true']" mode="builder"/>
			        </additionalColumns>
				    <matchingValue substituteWith="{lookupSettings/@substituteWith}" supportedCharacters="{sf:nvl(lookupSettings/@supportedChars,'[:all:]')}" doRemoveRepeatedChars="{lookupSettings/@removeRepeatedChars}" doSqueezeWS="{lookupSettings/@squeezeWS}" doRemoveDia="{lookupSettings/@removeAccents}" doUpperCase="{lookupSettings/@upperCase}"/>
				    <userMetadata>
				        <items/>
			        </userMetadata>
			        <comm:comment>
		            	<xsl:call-template name="generated_step"/>
		            </comm:comment>
				</properties>
				<visual-constraints layout="vertical">
					<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+48" />,480,-1,-1</xsl:attribute>
				</visual-constraints>        
			</step>							
			
		</xsl:if>
	</xsl:for-each>
</xsl:template>		


<xsl:template name="inst_cols">
	<column name="origin" type="STRING" />
	<column name="source_id" type="STRING" />
	<column name="source_code" type="{@sourceCodeType}" />
	<column name="source_system" type="STRING" />
	<column name="master_code" type="{@masterCodeType}" />
</xsl:template>


<xsl:template match="column">
	<column name="{@name}" type="{fn:upper-case(@type)}" />
</xsl:template>

<xsl:template match="column" mode="builder">
	<columnExprDef expression="{@name}" name="{@name}"/>
</xsl:template>

<xsl:template name="column_af">
	  <addedColumn name="{@name}" mrg:retainNodes="expression">
		  <xsl:attribute name="type">
			  <xsl:call-template name="convertType"/>
		  </xsl:attribute>
	  </addedColumn>
</xsl:template>

<xsl:template name="inst_cols_builder">
	<columnExprDef expression="source_code" name="source_code" />
	<columnExprDef expression="source_system" name="source_system" />
	<columnExprDef expression="master_code" name="master_code" />
</xsl:template>

<xsl:template name="convertType">
	<xsl:choose>
		<xsl:when test="@type='long_int'">LONG</xsl:when>
		<xsl:otherwise><xsl:value-of select="fn:upper-case(@type)"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>