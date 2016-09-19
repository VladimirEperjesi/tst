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
<xsl:param name="databaseModel" select="document('param:databaseModel')/*"/>

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
     	
	<step id="map_internal_columns_for_{@name}" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
        <properties>
            <addedColumns>
            <!-- MAPPING -->
            	<addedColumn expression="eng_origin" name="origin" type="STRING"/>
				<addedColumn expression="eng_source_timestamp" name="source_timestamp" type="DATETIME"/>
				<addedColumn expression="iif(eng_active=false,&#39;D&#39;,null)" name="change_type" type="STRING"/>	
            </addedColumns>
            <removedColumns/>
             <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
       <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,288,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>  
    
	<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
        <source step="map_internal_columns_for_{@name}" endpoint="out"/>
        <target step="{@name}" endpoint="in"/>
        <visual-constraints>
            <bendpoints/>
        </visual-constraints>
    </connection>
	
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL" update="true">
        <xsl:variable name="entityName" select="@name"/>
        <properties>
            <requiredColumns>
            	<!-- id -->
            	<xsl:if test="$advancedSettings/migration/migrationLoad/@loadId='true'">
	            	<requiredColumn name="id" type="LONG"/>
	            </xsl:if>
            	<!-- general columns -->
				<requiredColumn name="source_id" type="STRING"/>
				<requiredColumn name="origin" type="STRING"/>
				<requiredColumn name="source_timestamp" type="DATETIME"/>
				<requiredColumn name="change_type" type="STRING"/>
				<xsl:for-each select="columns/column[@origin='source' and not(@name=$histCols)]">
                	<xsl:call-template name="column_required"/>                	
                </xsl:for-each> 
            	<!-- eng columns -->
            	<xsl:if test="$advancedSettings/migration/migrationLoad/@loadEng='true'">
	                <xsl:for-each select="columns/column[(substring(@name,1,4))='eng_' and @name!='eng_active' and @name!='eng_existing' and @name!='eng_system' and @name!='eng_source_timestamp' and @name!='eng_origin' and @name!='eng_source_system']">
	                	<xsl:call-template name="column_required"/>
	                </xsl:for-each>
	            </xsl:if>
                <xsl:for-each select="$advancedSettings/migration[migrationLoad/@loadEng='true']/tidColumns/tidColumn">
                	<xsl:call-template name="column_required"/>
                </xsl:for-each>                              
                <!-- match columns -->
	            <xsl:if test="$advancedSettings/migration/migrationLoad/@loadMatch='true'">
		        	<!-- TODO / configuration has to be extended - now constants are used instead
		        	<requiredColumn name="master_id" type="LONG"/>            
                	<requiredColumn name="id_keeper_flag" type="BOOLEAN"/>
                	<requiredColumn name="isolate_flag" type="BOOLEAN"/>
                	<requiredColumn name="uni_rule_name" type="STRING"/>
		        	-->
		            <xsl:for-each select="columns/column[@origin='internal_match']">
	                	<xsl:call-template name="column_required"/>
	                </xsl:for-each>   
	            </xsl:if>
	            
	            <xsl:for-each select="$advancedSettings/migration/migrationLoad[@loadMatch='true']/selectedMatchingColumns/selectedMatchingColumn[@allEntities='true']">
	            	<xsl:variable name="columnName" select="@name"/>
	            	<xsl:for-each select="$instanceTables/physicalTable[@name=lower-case($tableName)]/columns/column[@name=lower-case($columnName)]">
	            		<xsl:call-template name="column_required"/>
	            	</xsl:for-each>
                </xsl:for-each>               	            	          
								
	            <xsl:for-each select="$advancedSettings/migration/migrationLoad[@loadMatch='true']/selectedMatchingColumns/selectedMatchingColumn[selectedEntities/selectedEntity[@name=$entityName]]">
	            	<xsl:variable name="columnName" select="@name"/>
	            		<xsl:for-each select="$instanceTables/physicalTable[@name=lower-case($tableName)]/columns/column[@name=lower-case($columnName)]">
	            			<xsl:call-template name="column_required"/>
                	 	</xsl:for-each> 
                </xsl:for-each>                
	            
                <!-- history columns -->
                <xsl:if test="$advancedSettings/migration/migrationLoad/@loadHist='true'">
	                <xsl:for-each select="$instanceModel/tables/table[lower-case(@name)=lower-case($tableName)]/advanced/historicalColumns/column">
	                	<requiredColumn name="{lower-case(@name)}" type="STRING"/>
	                </xsl:for-each>  
	            </xsl:if>
            </requiredColumns>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,432,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>	

</xsl:template>

</xsl:stylesheet>