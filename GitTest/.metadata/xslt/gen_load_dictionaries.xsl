<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="refData" select="document('param:refData')/*"/> <!-- /preview/databaseModel/refData -->
<xsl:param name="systems" select="document('param:systems')/*"/> <!-- /systems -->
<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>

<!-- bound to /logicalModel/dictionary -->
<xsl:template match="/*">
<xsl:variable name="no_master">
	<xsl:choose>
		<xsl:when test="tables/table[@loadMas='true']">false</xsl:when>
		<xsl:otherwise>true</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">

	<modelComment bounds="24,24,937,60" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
		<xsl:call-template name="dictionary_load_plan_comment"><xsl:with-param name="systems" select="$systems"/></xsl:call-template>
	</modelComment>
	
	<xsl:apply-templates select="tables/table[@loadInst='true']" mode="inst" >
		<xsl:with-param name="no_master" select="$no_master"/>
	</xsl:apply-templates>
	<xsl:apply-templates select="tables/table[@loadMas='true']" mode="mas"/>
	<!--<xsl:if test="boolean(tables/table[@loadMas='true'])">
		<modelComment bounds="24,24,937,60" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">Master dictionaries</modelComment>
	</xsl:if>
	<xsl:if test="boolean(tables/table[@loadInst='true'])">
		<modelComment bounds="24,480,937,60" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
			<xsl:attribute name="bounds">
				<xsl:text>24,</xsl:text>
				<xsl:choose>
					<xsl:when test="$no_master='true'">24</xsl:when>
					<xsl:otherwise>480</xsl:otherwise>
				</xsl:choose>
				<xsl:text>,937,60</xsl:text>
			</xsl:attribute>
		
		Instance dictionaries</modelComment>
	</xsl:if>-->
</purity-config>
</xsl:template>

<xsl:template match="table" mode="inst">
<xsl:param name="no_master"/>
<xsl:variable name="table_name" ><xsl:text>rd_</xsl:text><xsl:value-of select="@name"/><xsl:text>_trans</xsl:text></xsl:variable>
<!-- map source columns -->			
	<step id="map_{$table_name}_source_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
		<properties>
			<addedColumns>
				<mrg:mergeChildren key="@name">
					<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@origin='source']" mode="af"/>
					<addedColumn name="source_timestamp" type="DATETIME" mrg:retainNodes="expression"/>
				</mrg:mergeChildren>
			</addedColumns>
			<removedColumns/>
			<comm:comment>
            	<xsl:call-template name="generated_AFmapping_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/><xsl:text>,</xsl:text>
			<xsl:choose>
				<xsl:when test="$no_master='true'">288</xsl:when>
				<xsl:otherwise>744</xsl:otherwise>
			</xsl:choose>
			<xsl:text>,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
	</step>		

	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection">
		<source step="map_{$table_name}_internal_columns" endpoint="out"/>
		<target step="map_{$table_name}_source_columns" endpoint="in"/>
		<visual-constraints>
			<bendpoints/>
		</visual-constraints>
	</connection>		
	
<!-- map origin and source_id -->
	<step id="map_{$table_name}_internal_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
		<properties>
			<addedColumns>
				<!-- origin -->
	            <addedColumn name="origin" type="STRING">
              		<xsl:attribute name="expression">
              			<xsl:text>'hub_reference_data#internal#</xsl:text><xsl:value-of select="$table_name"/><xsl:text>'</xsl:text>
              		</xsl:attribute>
				</addedColumn>
				<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@origin='internal' and not(fn:matches(@name, 'eng.*'))]" mode="af_internal">
					<xsl:with-param name="table_name" select="$table_name"/>
					<xsl:with-param name="mode" select="'instance'"/>
				</xsl:apply-templates>
			</addedColumns>
			<removedColumns/>
			 <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/><xsl:text>,</xsl:text>
			<xsl:choose>
				<xsl:when test="$no_master='true'">192</xsl:when>
				<xsl:otherwise>648</xsl:otherwise>
			</xsl:choose>
			<xsl:text>,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
	</step>	
				
	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection">
		<source step="map_{$table_name}_source_columns" endpoint="out"/>
		<target step="{$table_name}" endpoint="in"/>
		<visual-constraints>
			<bendpoints/>
		</visual-constraints>
	</connection>		
		
	<!-- integration output -->			
	<step id="{$table_name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
		<properties>
			<requiredColumns>
				<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@origin='source' or @origin='internal' and not(fn:matches(@name, 'eng.*'))]" mode="out"/>
				<requiredColumn name="origin" type="STRING"/>
				<requiredColumn name="source_timestamp" type="DATETIME" />
				<!-- <requiredColumn name="source_code" type="STRING" />
				<requiredColumn name="source_system" type="STRING" />
				<requiredColumn name="master_code" type="{@masterCodeType}" />-->
			</requiredColumns>
			<comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/><xsl:text>,</xsl:text>
			<xsl:choose>
				<xsl:when test="$no_master='true'">384</xsl:when>
				<xsl:otherwise>840</xsl:otherwise>
			</xsl:choose>
			<xsl:text>,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
	</step>		    
			    
</xsl:template>

<xsl:template match="table" mode="mas">
<xsl:variable name="table_name" >
	<xsl:text>rd_</xsl:text><xsl:value-of select="@name"/>
</xsl:variable>
<!-- map other source columns -->			
	<step id="map_{$table_name}_source_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
		<properties>
			<addedColumns>
				<mrg:mergeChildren key="@name">
					<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@origin='source']" mode="af"/>
					<addedColumn name="source_timestamp" type="DATETIME" mrg:retainNodes="expression"/>
				</mrg:mergeChildren>
			</addedColumns>
			<removedColumns/>
			 <comm:comment>
            	<xsl:call-template name="generated_AFmapping_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/>,288,-1,-1</xsl:attribute>
		</visual-constraints>
	</step>
				
	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection">
		<source step="map_{$table_name}_internal_columns" endpoint="out"/>
		<target step="map_{$table_name}_source_columns" endpoint="in"/>
		<visual-constraints>
			<bendpoints/>
		</visual-constraints>
	</connection>	
	
<!-- map origin and source_id -->
	<step id="map_{$table_name}_internal_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
		<properties>
			<addedColumns>
					<!-- origin -->
                	<addedColumn name="origin" type="STRING">
                		<xsl:attribute name="expression">
                			<xsl:text>'hub_reference_data#internal#</xsl:text><xsl:value-of select="$table_name"/><xsl:text>'</xsl:text>
                		</xsl:attribute>
					</addedColumn>
					<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@origin='internal' and not(fn:matches(@name, 'eng.*'))]" mode="af_internal">
						<xsl:with-param name="table_name" select="$table_name"/>
						<xsl:with-param name="mode" select="'master'"/>
					</xsl:apply-templates>
			</addedColumns>
			<removedColumns/>
			 <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/>,192,-1,-1</xsl:attribute>
		</visual-constraints>
	</step>		
	
	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection">
		<source step="map_{$table_name}_source_columns" endpoint="out"/>
		<target step="{$table_name}" endpoint="in"/>
		<visual-constraints>
			<bendpoints/>
		</visual-constraints>
	</connection>	
			
	<!-- integration output -->			
	<step id="{$table_name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
		<properties>
			<requiredColumns>
				<xsl:apply-templates select="$refData/physicalTable[@name=lower-case($table_name)]/columns/column[@name!='id' and not(fn:matches(@name, 'eng.*'))]" mode="out"/>
				<requiredColumn name="origin" type="STRING"/>
				<requiredColumn name="source_timestamp" type="DATETIME" />
			</requiredColumns>
			 <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
		</properties>
		<visual-constraints layout="vertical">
			<xsl:attribute name="bounds"><xsl:value-of select="((position()-1)*336)+96"/>,384,-1,-1</xsl:attribute>
		</visual-constraints>
	</step>		    
			    
</xsl:template>

<xsl:template match="column" mode="out">
	<requiredColumn name="{@name}" type="{fn:upper-case(@type)}" />
</xsl:template>

<xsl:template match="column" mode="af">
	<addedColumn name="{@name}" type="{fn:upper-case(@type)}" mrg:retainNodes="expression" />
</xsl:template>

<xsl:template match="column" mode="af_internal">
<xsl:param name="table_name"/>
<xsl:param name="mode"/>
	<addedColumn name="{@name}" type="{fn:upper-case(@type)}" >
		<xsl:attribute name="expression">
			<xsl:choose>
				<xsl:when test="@name='origin'"><xsl:text>'hub_reference_data#internal#</xsl:text><xsl:value-of select="$table_name"/><xsl:text>'</xsl:text></xsl:when>
				<xsl:when test="@name='source_id'">
					<xsl:if test="$mode='instance'">source_code+source_system</xsl:if>
					<xsl:if test="$mode='master'">toString(master_code)</xsl:if>
				</xsl:when>
				<xsl:otherwise>''</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</addedColumn>
</xsl:template>

</xsl:stylesheet>