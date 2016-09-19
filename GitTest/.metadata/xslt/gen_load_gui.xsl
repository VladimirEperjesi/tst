<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="instanceTables" select="document('param:instanceTables')/*"/> <!--/preview/databaseModel/instanceTables -->
<xsl:param name="masterTables" select="document('param:masterTables')/*"/> <!--/preview/databaseModel/masterTables -->
<xsl:param name="system" select="document('param:system')/*"/> <!--/system -->
<xsl:param name="dictionary" select="document('param:dictionary')/*"/>
<xsl:param name="instanceModel" select="document('param:instanceModel')/*"/>
<xsl:param name="masterModel" select="document('param:masterModel')/*"/>
<xsl:param name="guiConfig" select="document('param:guiConfig')/*"/>
<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:include href="incl_gen_plan_templates.xsl"/>

<xsl:template match="/*">
<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
<modelComment bounds="24,24,937,60" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
	<xsl:call-template name="load_plan_comment"/>
</modelComment>
	<xsl:choose>
		<!-- allTables OPTION -->
		<xsl:when test="@guiLoadAllEntities='true'"> 
			<!-- generate integration output -->			
			<xsl:apply-templates select="$instanceTables/physicalTable[@name=lower-case($masterModel/masterTables/masterTable[guiEdit/@guiReadOnly='use global setting (from GUI Configuration)']/@instanceTable)]">
				<xsl:with-param name="origin_system" select="$guiConfig/@guiSystem"/>
			</xsl:apply-templates>
		</xsl:when>
		<!-- ENTITIES DEFINED ON LOAD OP -->
		<xsl:otherwise> 
			<xsl:variable name="selTables" select="loadedEntities"/>
			<!-- generate integration output -->
			<xsl:apply-templates select="$instanceTables/physicalTable[@name=lower-case($masterModel/masterTables/masterTable[@name=$selTables/*/@name]/@instanceTable)]">
				<xsl:with-param name="origin_system" select="$guiConfig/@guiSystem"/>
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</purity-config>
</xsl:template>

<xsl:template match="physicalTable"> 
	<xsl:param name="origin_system"/>
	<xsl:variable name="columns" select="columns"/>
	<xsl:variable name="dic" select="@dic"/>
	<xsl:variable name="entityName" select="@name"/>
	<xsl:variable name="instanceTable" select="$masterModel/masterTables/masterTable[lower-case(@name)=lower-case($entityName)]/@instanceTable"/>
	
	<step id="map_{@name}_source_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
        <properties>
            <addedColumns>
            <mrg:mergeChildren key="@name">
				 <xsl:for-each select="columns/column[(@origin='source' and @artificial='false' and @load='true') or (@name='source_id' and @originalPk='true')]">
                	<xsl:call-template name="column_af"/>
                </xsl:for-each>
                <!-- <xsl:for-each select="columns/column[@isSrc='false']">
                	<columnDef name="{replace(@name,'dic_','')}" type="{@type}"/>
            	</xsl:for-each>-->
                <addedColumn name="source_timestamp" type="DATETIME" mrg:retainNodes="expression" />
            </mrg:mergeChildren>
            </addedColumns>
            <removedColumns/>
            <comm:comment>
            	<xsl:call-template name="generated_AFmapping_step"/>
            </comm:comment>
        </properties>
       <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,216,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>  
       
    <xsl:if test="$settings/@enableRC='true'">    	  	       
	    <step id="SRC_{@name}" className="com.ataccama.dqc.tasks.flow.RecordCounter" disabled="false" mode="BYPASS">
			<properties reportPerfPerBatch="true" append="true" reportFileName="\\logger" timeStampFormat="yyyy-MM-dd HH:mm:ss" batchSize="100000" reportPerfPerSecond="true">
			<comm:comment>
	        	<xsl:call-template name="generated_step"/>
	        </comm:comment>
	        </properties>
	      	<visual-constraints layout="vertical">
				<xsl:attribute name="bounds">
					<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,360,-1,-1</xsl:text>
				</xsl:attribute>
			</visual-constraints>	        
		</step>		
    </xsl:if>       
       
	<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
        <properties>
            <requiredColumns>
                <requiredColumn name="source_id" type="STRING"/>
                <requiredColumn name="origin" type="STRING"/>
                <requiredColumn name="source_timestamp" type="DATETIME" />
                <xsl:for-each select="columns/column[@origin='source']">
                	<xsl:call-template name="column_required"/>
                </xsl:for-each>
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
	
	<xsl:variable name="def_origin">
		<xsl:value-of select="$origin_system"/><xsl:text>#</xsl:text><xsl:value-of select="$instanceTable"/><xsl:text>#</xsl:text><xsl:value-of select="@name"/>
	</xsl:variable>	
	
	<step id="map_internal_columns_from_{$instanceTable}_to_{@name}" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
        <properties>
            <addedColumns>
            <!-- origin -->
                <addedColumn expression="'{sf:nvl(@customOrigin,$def_origin)}'" name="origin" type="STRING"/>
            <!-- compound key -->
				<xsl:for-each select="$instanceTables/*[@name=lower-case($entityName)]/columns/column[@artificial='true']">
					<addedColumn name="{@name}" type="STRING">
						<xsl:attribute name="expression">
							<xsl:for-each select="compoundDefinition/column" >
								<xsl:text>toString(</xsl:text><xsl:value-of select="@name"/>
								<xsl:choose>
									<xsl:when test="@type='datetime'"><xsl:text>,'yyyy-MM-dd HH:mm:ss')</xsl:text></xsl:when>
									<xsl:when test="@type='day'"><xsl:text>,'yyyy-MM-dd')</xsl:text></xsl:when>
									<xsl:otherwise><xsl:text>)</xsl:text></xsl:otherwise>
								</xsl:choose>
								<xsl:if test="position() != last()"><xsl:text>+'#'+</xsl:text></xsl:if>
							</xsl:for-each>   
						</xsl:attribute>
					</addedColumn>			
				</xsl:for-each>
			<!-- source system for lookup -->	
				<xsl:if test="$instanceTables/*[@name=lower-case($entityName)]/columns/column[@origin='source' and @dic != '']">
					<addedColumn expression="'{fn:upper-case($origin_system)}'" name="source_system" type="STRING"/>
				</xsl:if>
            </addedColumns>
            <removedColumns/>
             <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
       <visual-constraints layout="vertical">
			<xsl:attribute name="bounds">
				<xsl:value-of select="((position()-1)*336)+48"/><xsl:text>,120,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>  
	
    <!-- CONNECTIONS -->
    <xsl:if test="$settings/@enableRC='true'">
		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
			<source step="map_{@name}_source_columns" endpoint="out"/>
			<target step="SRC_{@name}" endpoint="in"/>
			<visual-constraints>
				<bendpoints/>
			</visual-constraints>
		</connection> 
		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
			<source step="SRC_{@name}" endpoint="out"/>
			<target step="{@name}" endpoint="in"/>
			<visual-constraints>
				<bendpoints/>
			</visual-constraints>
		</connection> 
	</xsl:if>
	<xsl:if test="$settings/@enableRC='false'">	
		<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
			<source step="map_{@name}_source_columns" endpoint="out"/>
			<target step="{@name}" endpoint="in"/>
			<visual-constraints>
				<bendpoints/>
			</visual-constraints>
		</connection> 
	</xsl:if> 

</xsl:template>


</xsl:stylesheet>