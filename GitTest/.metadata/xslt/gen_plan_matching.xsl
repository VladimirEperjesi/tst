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


<xsl:template match="/*">
<xsl:variable name="table_name" select="@name"/>
<xsl:variable name="custom_master_column">
	<xsl:for-each select="$logicalModel/masterModels/masterModel/masterTables/masterTable[lower-case(@instanceTable)=lower-case($table_name)]/advanced[@groupColumn != '']">
		<xsl:value-of select="lower-case(@groupColumn)"/><xsl:text> and </xsl:text>
	</xsl:for-each>
</xsl:variable>
<xsl:variable name="record_counter_name_in" select="concat('counter_', $table_name,'_match_in')"/>
<xsl:variable name="record_counter_name_out" select="concat('counter_', $table_name,'_match_out')"/>

<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
<modelComment bounds="68,20,913,169" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
	<xsl:call-template name="matching_plan_comment"><xsl:with-param name="master_column" select="fn:replace($custom_master_column,'^(.+) and $','$1')"/></xsl:call-template>
</modelComment>

	<step id="in" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>
                <xsl:for-each select="columns/column[(@origin='source' or @origin='copy_source' or @origin='clean' or @origin='copy_clean' or (@origin='internal' and @load='true')) and @name!='master_id']">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>
                <!-- todo: grouping column instead - i.e. if count of master layers = count of groupColumns specified, master id should not be there, othewise master_id is there-->
                <!-- $logicalModel/masterModels/masterModel/masterTables/masterTable[@instanceTable=$table_name]/advanced/@groupColumn  -->
                <columnDef name="master_id" type="LONG"/>
                <columnDef name="eng_external_record" type="BOOLEAN"/>
                <columnDef name="eng_change_type" type="STRING"/>
                <columnDef name="eng_activity_change_type" type="STRING"/>
                 <xsl:for-each select="columns/column[@origin='source' or @origin='clean' or @origin='match' or @origin='copy_source' or @origin='copy_clean' or (@origin='internal_match' and @name!='master_id')]">
					<xsl:call-template name="oldValueColumn">
						<xsl:with-param name="table_name" select="$table_name"/>
						<xsl:with-param name="logicalModel" select="$logicalModel"/>
					</xsl:call-template>
                </xsl:for-each>
                <!-- <xsl:for-each select="columns/column">
                	<xsl:if test="contains(@origin,'copy')">
						<xsl:call-template name="oldValueColumn">
							<xsl:with-param name="table_name" select="$table_name"/>
							<xsl:with-param name="logicalModel" select="$logicalModel"/>
						</xsl:call-template>                		
                	</xsl:if>
                </xsl:for-each>-->
                <!-- all match columns are now moved to the input) -->
                <xsl:for-each select="columns/column[@origin='match' or (@origin='internal_match' and @name!='master_id')]">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>
                <xsl:for-each select="virtualColumns/column[@origin='match' or (@origin='internal_match' and @name!='master_id')]">
                	<xsl:call-template name="column_def"/>
                </xsl:for-each>
            </columns>
            <shadowColumns>
                <!-- moved to columns above 
                <xsl:for-each select="columns/column[@origin='match']">
                	<xsl:call-template name="column_shadow"/>
                </xsl:for-each>
                 -->
            </shadowColumns>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints bounds="216,240,-1,-1" layout="vertical"/>
    </step>
    
    <xsl:if test="$settings/@enableRC='false'">
		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
	        <source step="in" endpoint="out"/>
	        <target step="out" endpoint="in"/>
	    </connection>
	</xsl:if>
	
	<xsl:if test="$settings/@enableRC='true'">
		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
	        <source step="in" endpoint="out"/>
	        <target step="{$record_counter_name_in}" endpoint="in"/>
	    </connection>
	        
	    <step id="{$record_counter_name_in}" className="com.ataccama.dqc.tasks.flow.RecordCounter">
			<properties reportPerfPerBatch="true" append="true" reportFileName="\\logger" timeStampFormat="yyyy-MM-dd HH:mm:ss" batchSize="100000" reportPerfPerSecond="true">
			<comm:comment>
	        	<xsl:call-template name="generated_step"/>
	        </comm:comment>
	        </properties>
		</step>
		
	    <connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
	        <source step="{$record_counter_name_in}" endpoint="out"/>
	        <target step="{$record_counter_name_out}" endpoint="in"/>
	    </connection>
	    
		<step id="{$record_counter_name_out}" className="com.ataccama.dqc.tasks.flow.RecordCounter">
			<properties reportPerfPerBatch="true" append="true" reportFileName="\\logger" timeStampFormat="yyyy-MM-dd HH:mm:ss" batchSize="100000" reportPerfPerSecond="true">
			<comm:comment>
	        	<xsl:call-template name="generated_step"/>
			</comm:comment>
			</properties>
		</step>

		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
	        <source step="{$record_counter_name_out}" endpoint="out"/>
	        <target step="out" endpoint="in"/>
	    </connection>
	</xsl:if>
	
	<step id="out" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
        <properties>
            <requiredColumns>
				<requiredColumn name="id" type="LONG"/>
                <requiredColumn name="master_id" type="LONG"/>
                <xsl:for-each select="columns/column[@origin='match' or (@origin='internal_match' and @name!='master_id')]">
                	<xsl:call-template name="column_required"/>
                </xsl:for-each>
            </requiredColumns>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
         <visual-constraints bounds="216,504,-1,-1" layout="vertical"/>
    </step>
</purity-config>
</xsl:template>

</xsl:stylesheet>