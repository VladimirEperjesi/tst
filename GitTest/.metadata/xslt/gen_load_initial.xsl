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
<xsl:param name="initialLoad" select="document('param:initialLoad')/*"/>
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
		<!-- allTables -->
		<xsl:apply-templates select="$instanceTables/physicalTable[@name=$system/sourceMappings/mapping/lower-case(@entity)]">
			<xsl:with-param name="allowLoad" select="@allowLoad"/>
		</xsl:apply-templates>
</purity-config>
</xsl:template>

<xsl:template match="physicalTable"> 
	<xsl:param name="allowLoad"/>
	<xsl:variable name="columns" select="columns"/>
	<xsl:variable name="tableName" select="@name"/>
	<xsl:variable name="dic" select="@dic"/>	
	
	<xsl:if test="$allowLoad='false'">
		<step id="map_{$tableName}_source_columns" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
	        <properties>
	            <addedColumns>
	            <mrg:mergeChildren key="@name">
					 <xsl:for-each select="columns/column[(@origin='source' and @artificial='false' and @load='true') or (@name='source_id' and @originalPk='true')]">
	                	<xsl:call-template name="column_af"/>
	                </xsl:for-each>
	                <!-- <xsl:for-each select="columns/column[@isSrc='false']">
	                	<columnDef name="{replace(@name,'dic_','')}" type="{@type}"/>
	            	</xsl:for-each>-->
	            	<addedColumn name="change_type" type="STRING" mrg:retainNodes="expression"/>
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
	</xsl:if>     
     
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
                
                <xsl:if test="$allowLoad='false'">
                	<!-- change type is expected only for fully defiend initial load plan - for full load mode, the attribute is pointless -->
                	<requiredColumn name="change_type" type="STRING" />
                </xsl:if>
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
    
    <xsl:if test="$allowLoad='false'">
	    <!-- LOOKUP VALID -->
	    <xsl:for-each select="$instanceTables/physicalTable[@name=lower-case($tableName)]/columns/column[@refData!='']">	
	    	<xsl:variable name="dic" select="@refData"/>	
			<xsl:variable name="valid" select="$dictionary/tables/table[@name=$dic and @usageValidation='load']/@name"/>
			<xsl:variable name="isSrc" select="$instanceModel/tables/table[lower-case(@name)=lower-case($tableName)]/columns/column[@refData=$dic]/@isSrc"/>		
		
			<xsl:choose>
				<xsl:when test="@isSrc='true'">			
					<xsl:if test="$valid">
					    <step id="Validate_{@name}" className="com.ataccama.dqc.tasks.clean.LookupAlgorithm">		  			
							<properties maxDifference="0" tableFileName="pathvar://HUB_RD_LKP/{$valid}_valid.lkp" prefix="false" foreignKeyColumn="{@name}">
								<columns>						
									<columnAssign expression="lookup.master_code" name="{replace(@name,'src_','dic_')}"/>						
								</columns>
								<scorer>
									<scoringEntries>
										<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
										<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
										<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
										<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
										<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
									</scoringEntries>
								</scorer>
								<selectBestMatch/>
								<comm:comment>
            						<xsl:call-template name="generated_step"/>
            					</comm:comment>
							</properties>
						</step>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>		
					<xsl:if test="$valid">
					    <step id="Validate_{@name}" className="com.ataccama.dqc.tasks.clean.LookupAlgorithm">		  			
							<properties maxDifference="0" tableFileName="pathvar://HUB_RD_LKP/{$valid}_valid.lkp" prefix="false" foreignKeyColumn="{@name}">
								<columns>						
									<columnAssign expression="lookup.master_code" name="dic_{@name}"/>						
								</columns>
								<scorer>
									<scoringEntries>
										<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
										<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
										<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
										<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
										<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
									</scoringEntries>
								</scorer>
								<selectBestMatch/>
								<comm:comment>
            						<xsl:call-template name="generated_step"/>
            					</comm:comment>
							</properties>
						</step>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:if>

	<xsl:if test="$allowLoad='false'">
	    <!--lookups -->
	    <xsl:apply-templates select="$instanceTables/*[@name=lower-case($tableName)]/columns/column[@instUse='load']" mode="lookup">
			<xsl:with-param name="position" select="position()-1"/>
			<xsl:with-param name="system" select="$system"/>
	    </xsl:apply-templates>    
	
	     <!-- generate AF with mapping -->
		 <xsl:variable name="lookup" select="if($instanceTables/*[@name=lower-case($tableName)]/columns/column[@origin='source' and @dic != '']/@isSrc='false') then replace($instanceTables/*[@name=lower-case($tableName)]/columns/column[@origin='source' and @dic != '']/@name,'dic_','') else replace($instanceTables/*[@name=lower-case($tableName)]/columns/column[@origin='source' and @dic != '']/@name,'dic_','src_')"/>
		 <xsl:apply-templates select="$system/sourceMappings/mapping[lower-case(@entity)=lower-case($tableName)]">
				<xsl:with-param name="position" select="position()-1"/>
				<xsl:with-param name="lookup" select="$lookup"/>
		 </xsl:apply-templates>
	</xsl:if>
</xsl:template>

<xsl:template match="mapping">	
	<xsl:param name="position"/>
	<xsl:param name="lookup"/>
	<xsl:variable name="tableName" select="@name"/>
	<xsl:variable name="origin_entity" select="@entity"/>
	<xsl:variable name="origin_table" select="@table"/>
	<xsl:variable name="origin_system" select="$system/@name"/>
	<xsl:variable name="single" select="(count(preceding-sibling::mapping[@entity=$origin_entity])+count(following-sibling::mapping[@entity=$origin_entity]))=0"/>
	<xsl:variable name="def_origin">
		<xsl:value-of select="$origin_system"/><xsl:text>#</xsl:text><xsl:value-of select="$origin_table"/><xsl:text>#</xsl:text><xsl:value-of select="$origin_entity"/>
	</xsl:variable>
		
	<step id="map_internal_columns_from_{$origin_table}_to_{$origin_entity}" className="com.ataccama.dqc.tasks.flow.AlterFormat" disabled="false" mode="NORMAL">
        <properties>
            <addedColumns>
            <!-- origin -->
                <addedColumn expression="'{sf:nvl(@customOrigin,$def_origin)}'" name="origin" type="STRING"/>
            <!-- compound key -->
				<xsl:for-each select="$instanceTables/*[@name=lower-case($origin_entity)]/columns/column[@artificial='true']">
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
				<xsl:if test="$instanceTables/*[@name=lower-case($origin_entity)]/columns/column[@origin='source' and @dic != '']">
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
				<xsl:value-of select="(($position)*336)+48"/><xsl:text>,120,-1,-1</xsl:text>
			</xsl:attribute>
		</visual-constraints>
    </step>  
    
    <!-- CONNECTIONS -->
    <xsl:if test="$settings/@enableRC='true'">
	    <xsl:choose>
			<xsl:when test="$lookup!=''">
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="map_{$origin_entity}_source_columns" endpoint="out"/>
					<target step="Translate {$lookup}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="Translate {$lookup}" endpoint="out"/>
					<target step="SRC_{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="SRC_{$origin_entity}" endpoint="out"/>
					<target step="{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
			</xsl:when>		
			<xsl:otherwise>
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="map_{$origin_entity}_source_columns" endpoint="out"/>
					<target step="SRC_{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
				
				<!-- <connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="map_internal_columns_from_{$origin_table}_to_{$origin_entity}" endpoint="out"/>
					<target step="rd_{$valid}_valid" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> -->
				
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="SRC_{$origin_entity}" endpoint="out"/>
					<target step="{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<xsl:if test="$settings/@enableRC='false'">
		<xsl:choose>	
			<xsl:when test="$lookup!=''">
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="map_{$origin_entity}_source_columns" endpoint="out"/>
					<target step="Translate {$lookup}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="Translate {$lookup}" endpoint="out"/>
					<target step="{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
			</xsl:when>		
			<xsl:otherwise>			
				<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection" disabled="false">
					<source step="map_{$origin_entity}_source_columns" endpoint="out"/>
					<target step="{$origin_entity}" endpoint="in"/>
					<visual-constraints>
						<bendpoints/>
					</visual-constraints>
				</connection> 
			</xsl:otherwise>		
		</xsl:choose> 	
	</xsl:if>
	
</xsl:template>

</xsl:stylesheet>