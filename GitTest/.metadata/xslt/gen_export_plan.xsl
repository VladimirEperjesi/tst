<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn comm">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:param name="databaseModel" select="document('param:databaseModel')/*"/>
<xsl:param name="historyPlugin" select="document('param:historyPlugin')/*"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>

<!--bound to /outputOperations/exportModel/*  -->
<xsl:template match="/*">
	<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
		<xsl:choose>
			<!--<xsl:when test="local-name(.)='fullInstanceExport' or local-name(.)='deltaInstanceExport'">-->
			<xsl:when test="local-name(.)='fullInstanceExport'">						
				<xsl:call-template name="instanceSteps" >
					<xsl:with-param name="mode" select="'full'"/>
				</xsl:call-template>
			</xsl:when>
			<!--<xsl:when test="local-name(.)='fullMasterExport' or local-name(.)='deltaMasterExport'">-->
			<xsl:when test="local-name(.)='fullMasterExport'">
				<xsl:call-template name="masterSteps" >
					<xsl:with-param name="mode" select="'full'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="local-name(.)='complexExport'">
				<xsl:variable name="instanceCount" select="count(dataSources/instanceDataSource/selectedTables/*)"/>
				<xsl:variable name="instanceAllEntities" select="dataSources/instanceDataSource/@allEntities"/>
				<xsl:variable name="advanced" select="advanced"/>
				
				<xsl:for-each select="dataSources/*">
					<xsl:choose>					
						<xsl:when test="local-name(.)='instanceDataSource' or local-name(.)='conditionalInstanceDataSource'">
							<xsl:call-template name="instanceSteps" >
								<!--<xsl:with-param name="mode" select="'delta'"/>-->
								<xsl:with-param name="mode" select="@mode"/>							
							</xsl:call-template>
						</xsl:when>
						
						<xsl:when test="local-name(.)='masterDataSource' or local-name(.)='conditionalMasterDataSource'">
							<xsl:call-template name="masterSteps" >
								<!--	<xsl:with-param name="mode" select="'delta'"/> -->
								<xsl:with-param name="mode" select="@mode"/>
								<xsl:with-param name="instanceCount" select="$instanceCount"/>
								<xsl:with-param name="instanceAllEntities" select="$instanceAllEntities"/>													
							</xsl:call-template>
						</xsl:when>
						
						<xsl:when test="local-name(.)='historyInstanceEntityDataSource'">
							<xsl:call-template name="historyInstanceSteps" >
								<xsl:with-param name="mode" select="@mode"/>
								<xsl:with-param name="instanceCount" select="$instanceCount"/>
								<xsl:with-param name="instanceAllEntities" select="$instanceAllEntities"/>	
								<xsl:with-param name="advanced" select="$advanced"/>																				
							</xsl:call-template>
						</xsl:when>
						
						<xsl:when test="local-name(.)='historyMasterEntityDataSource'">
							<xsl:call-template name="historyMasterSteps" >
								<xsl:with-param name="mode" select="@mode"/>
								<xsl:with-param name="instanceCount" select="$instanceCount"/>
								<xsl:with-param name="instanceAllEntities" select="$instanceAllEntities"/>
								<xsl:with-param name="advanced" select="$advanced"/>															
							</xsl:call-template>
						</xsl:when>												
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</purity-config>
</xsl:template>

<xsl:template name="historyInstanceSteps">
	<xsl:param name="mode"/>
	<xsl:param name="instanceCount" select="0"/>
	<xsl:param name="instanceAllEntities" />
	<xsl:param name="advanced" />
	
	<xsl:variable name="prefix"><xsl:if test="@prefix !=''"><xsl:value-of select="@prefix"/>.</xsl:if></xsl:variable>
	<xsl:variable name="layerName" select="@layerName" />
	<xsl:variable name="entityName" select="@entity" />
	<xsl:variable name="startPosition">
		<xsl:choose>
			<xsl:when test="$instanceAllEntities='true'">
				<xsl:value-of select="count($databaseModel/instanceTables/*)+count($databaseModel/refData/*)"/>
			</xsl:when>
			<!-- <xsl:when test="$instanceCount>0">-->
			<xsl:when test="number($instanceCount)>0">
				<xsl:value-of select="$instanceCount"/>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<step id="{$prefix}{@entity}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>
            	<xsl:if test="@allColumns='true'">
            		<xsl:for-each select="$historyPlugin/metaColumns/metaColumn">
            			<xsl:choose>
							<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
							<xsl:when test="@type='date'"><columnDef name="{lower-case(@name)}" type="DATETIME"/></xsl:when>
							<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
						</xsl:choose>            	
                    </xsl:for-each>	        		
            		<xsl:choose>     	                          	
	            		<xsl:when test="$historyPlugin/instanceTables/instanceTable[@entityName=lower-case($entityName) and @allColumns='true']">
		            		<xsl:for-each select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entityName)]/columns/column[not(@name=preceding-sibling::column/@name) and not(@name=$historyPlugin/metaColumns/metaColumn/@name) and not(substring(@name,1,4)='eng_')]">
								<xsl:choose>
									<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
									<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
								</xsl:choose>    	
		                    </xsl:for-each>	   		                    		                      
			            </xsl:when>
	            		<xsl:otherwise>	             			            	
		            		<xsl:for-each select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entityName)]/columns/column[@name=$historyPlugin/instanceTables/instanceTable[@entityName=lower-case($entityName)]/instanceColumns/instanceColumn/@name and not(@name=preceding-sibling::column/@name) and not(@name=$historyPlugin/metaColumns/metaColumn/@name)]">
								<xsl:choose>
									<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
									<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
								</xsl:choose>    	
		                    </xsl:for-each>			                    		                       			            	 			           
			            </xsl:otherwise>			           			           
		            </xsl:choose>              		         
            	</xsl:if>
            	<xsl:if test="@allColumns='false'">
                	<xsl:for-each select="$historyPlugin/metaColumns/metaColumn">
            			<xsl:choose>
							<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
							<xsl:when test="@type='date'"><columnDef name="{lower-case(@name)}" type="DATETIME"/></xsl:when>
							<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
						</xsl:choose>            	
                    </xsl:for-each>              		
            		<xsl:for-each select="historyInstanceColumns/historyInstanceColumn">
            			<xsl:variable name="colName" select="@name" />	            		
	            		<xsl:for-each select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entityName)]/columns/column[@name=lower-case($colName) and not(@name=preceding-sibling::column/@name) and not(@name=$historyPlugin/metaColumns/metaColumn/@name)]">
							<xsl:choose>
								<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
								<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
							</xsl:choose>    	
	                    </xsl:for-each>		                     
                    </xsl:for-each>                              
            	</xsl:if> 
				<xsl:if test="$advanced/@enableTID='true'">
					<columnDef name="eng_creation_tid" type="LONG"/>
					<columnDef name="eng_deletion_tid" type="LONG"/>
					<columnDef name="eng_last_update_tid" type="LONG"/>
					<columnDef name="eng_activation_tid" type="LONG"/>
					<columnDef name="eng_deactivation_tid" type="LONG"/>
				</xsl:if>	            	   
			</columns>
			<shadowColumns/>
			<comm:comment>
          			<xsl:call-template name="generated_step"/>
          		</comm:comment>
        </properties>
    </step>

</xsl:template>

<xsl:template name="historyMasterSteps">

	<xsl:param name="mode"/>
	<xsl:param name="instanceCount" select="0"/>
	<xsl:param name="instanceAllEntities" />
	<xsl:param name="advanced" />
	
	<xsl:variable name="prefix"><xsl:if test="@prefix !=''"><xsl:value-of select="@prefix"/>.</xsl:if></xsl:variable>
	<xsl:variable name="entityName" select="cc/@entityName" />
	<xsl:variable name="layerName" select="cc/@layerName" />
	<xsl:variable name="startPosition">
	
	<xsl:choose>
		<xsl:when test="$instanceAllEntities='true'">
			<xsl:value-of select="count($databaseModel/instanceTables/*)+count($databaseModel/refData/*)"/>
		</xsl:when>
		<!-- <xsl:when test="$instanceCount>0">-->
		<xsl:when test="number($instanceCount)>0">
			<xsl:value-of select="$instanceCount"/>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

	<step id="{$prefix}{cc/@entityName}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
	<!-- master layer is not allowed in step name: _{cc/@layerName} -->
        <properties>
            <columns>
            	<xsl:if test="@allColumns='true'">
            		<xsl:for-each select="$historyPlugin/metaColumns/metaColumn[@layer='master']">
            			<xsl:choose>
							<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
							<xsl:when test="@type='date'"><columnDef name="{lower-case(@name)}" type="DATETIME"/></xsl:when>
							<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
						</xsl:choose>            	
                    </xsl:for-each>	                 		
            		<xsl:choose>
	            		<xsl:when test="$historyPlugin/masterTables/masterTable[cc/@entity=$entityName and cc/@layer=$layerName and @allColumns='true']">
		            		<xsl:for-each select="$databaseModel/masterTables/physicalTable[@name=$entityName and @layerName=$layerName]/columns/column[not(@name=preceding-sibling::column/@name) and not(@name=$historyPlugin/metaColumns/metaColumn/@name) and not(substring(@name,1,4)='eng_')]">
								<xsl:choose>
									<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
									<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
								</xsl:choose>    	
		                    </xsl:for-each>	    
			            </xsl:when>
	            		<xsl:otherwise>	 
		            		<xsl:for-each select="$databaseModel/masterTables/physicalTable[@name=$entityName and @layerName=$layerName]/columns/column[@name=$historyPlugin/masterTables/masterTable[cc/@entity=$entityName and cc/@layer=$layerName]/masterColumns/masterColumn[not(@name=$historyPlugin/metaColumns/metaColumn/@name)]/@name and not(@name=preceding-sibling::column/@name)]">
								<xsl:choose>
									<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
									<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
								</xsl:choose>    	
		                    </xsl:for-each>	    
			            </xsl:otherwise>   
		            </xsl:choose>              		            	                
            	</xsl:if>            	
            	<xsl:if test="@allColumns='false'">
                    <xsl:for-each select="$historyPlugin/metaColumns/metaColumn[@layer='master']">
            			<xsl:choose>
							<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
							<xsl:when test="@type='date'"><columnDef name="{lower-case(@name)}" type="DATETIME"/></xsl:when>
							<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
						</xsl:choose>            	
                    </xsl:for-each>	            		            		
            		<xsl:for-each select="historyMasterColumns/historyMasterColumn[not(@name=$historyPlugin/metaColumns/metaColumn/@name)]">
            			<xsl:variable name="colName" select="@name" />	            
	            		<xsl:for-each select="$databaseModel/masterTables/physicalTable[@name=lower-case($entityName) and @layerName=lower-case($layerName)]/columns/column[@name=lower-case($colName)]">
							<xsl:choose>
								<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
								<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
							</xsl:choose>    	
	                    </xsl:for-each>		                   	                   
                    </xsl:for-each>    
            	</xsl:if>
				<xsl:if test="$advanced/@enableTID='true'">
					<columnDef name="eng_creation_tid" type="LONG"/>
					<columnDef name="eng_deletion_tid" type="LONG"/>
					<columnDef name="eng_last_update_tid" type="LONG"/>
					<columnDef name="eng_activation_tid" type="LONG"/>
					<columnDef name="eng_deactivation_tid" type="LONG"/>
				</xsl:if>	            	   
			</columns>
			<shadowColumns/>
			<comm:comment>
          			<xsl:call-template name="generated_step"/>
          		</comm:comment>
        </properties>
    </step> 
    
</xsl:template>

<xsl:template name="masterSteps">
	<xsl:param name="mode"/>
	<xsl:param name="instanceCount" select="0"/>
	<xsl:param name="instanceAllEntities" />
	
	<xsl:variable name="prefix"><xsl:if test="@prefix !=''"><xsl:value-of select="@prefix"/>.</xsl:if></xsl:variable>
	<xsl:variable name="layerName" select="@layerName" />
	<xsl:variable name="startPosition">	
		<xsl:choose>
			<xsl:when test="$instanceAllEntities='true'">
				<xsl:value-of select="count($databaseModel/instanceTables/*)+count($databaseModel/refData/*)"/>
			</xsl:when>
			<!-- <xsl:when test="$instanceCount>0">-->
			<xsl:when test="number($instanceCount)>0">
				<xsl:value-of select="$instanceCount"/>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="enableEngTid"><xsl:value-of select="advanced/@enableTID"/></xsl:variable>		

	<xsl:if test="@allEntities='true'">
		<xsl:for-each select="$databaseModel/masterTables/*[@layerName=lower-case($layerName)]">
			
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		        <properties>
		            <columns>
						<!-- <xsl:call-template name="masColumns"/> -->
						<xsl:for-each select="columns/column">
							<xsl:call-template name="column"/>
						</xsl:for-each>
						<xsl:if test="$mode='delta'">       
							  <columnDef name="eng_change_type" type="STRING"/>
							<columnDef name="eng_activity_change_type" type="STRING"/>
						</xsl:if>
						
						<xsl:if test="$enableEngTid='true'">
							<columnDef name="eng_creation_tid" type="LONG"/>
							<columnDef name="eng_deletion_tid" type="LONG"/>
							<columnDef name="eng_last_update_tid" type="LONG"/>
							<columnDef name="eng_activation_tid" type="LONG"/>
							<columnDef name="eng_deactivation_tid" type="LONG"/>
						</xsl:if>						
						
					</columns>
					<shadowColumns/>
					<comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>
		</xsl:for-each>
	</xsl:if>
	<xsl:if test="@allEntities='false'">
	<xsl:for-each select="selectedTables/*">
		<xsl:variable name="allColumns" select="@allColumns"/>
		<xsl:variable name="tableName" select="@name" />
		<xsl:variable name="selectedColumns" select="columns"/>
		<xsl:variable name="position" select="$startPosition+position()-1"/>
		<xsl:for-each select="$databaseModel/masterTables/*[@name=lower-case($tableName) and @layerName=lower-case($layerName)]">
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		        <properties>
		            <columns>
		              <!-- <xsl:call-template name="masColumns"/> -->
		            <xsl:if test="$allColumns='true'">  
		                <xsl:for-each select="columns/column">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <xsl:if test="$mode='delta'">       
			                 <columnDef name="eng_change_type" type="STRING"/>
			                <columnDef name="eng_activity_change_type" type="STRING"/> 
						</xsl:if>
		            </xsl:if> 
		            <xsl:if test="$allColumns='false'">
						<xsl:for-each select="columns/column[@name=$selectedColumns/column/@name]">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                 <xsl:if test="$selectedColumns/column/@name='eng_change_type'">
		                	<columnDef name="eng_change_type" type="STRING"/>
		                </xsl:if>
		                <xsl:if test="$selectedColumns/column/@name='eng_activity_change_type'">
		                	<columnDef name="eng_activity_change_type" type="STRING"/>
		                </xsl:if>
		            </xsl:if>
		            
					<xsl:if test="$enableEngTid='true'">
						<columnDef name="eng_creation_tid" type="LONG"/>
						<columnDef name="eng_deletion_tid" type="LONG"/>
						<columnDef name="eng_last_update_tid" type="LONG"/>
						<columnDef name="eng_activation_tid" type="LONG"/>
						<columnDef name="eng_deactivation_tid" type="LONG"/>
					</xsl:if>		            
		            
		            </columns>
		            <shadowColumns/>
		            <comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>
		</xsl:for-each>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="local-name(.)='conditionalMasterDataSource'">
		<xsl:variable name="allColumns" select="@allColumns"/>
		<xsl:variable name="selectedColumns" select="columns"/>
		<xsl:for-each select="$databaseModel/masterTables/*[@name=current()/@entityName and @layerName=current()/@layerName]">
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		        <properties>
		            <columns>
		              <!-- <xsl:call-template name="masColumns"/> -->
		              <!--<xsl:if test="$mode='delta'">       
		                 <columnDef name="eng_change_type" type="STRING"/>
		                <columnDef name="eng_activity_change_type" type="STRING"/> 
					</xsl:if>-->
		            <xsl:if test="$allColumns='true'">  
		                <xsl:for-each select="columns/column">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <xsl:if test="$mode='delta'">
		                	<columnDef name="eng_change_type" type="STRING"/>
		                	<columnDef name="eng_activity_change_type" type="STRING"/>
		                </xsl:if>
		            </xsl:if> 
		            <xsl:if test="$allColumns='false'">
						<xsl:for-each select="columns/column[@name=$selectedColumns/column/@name]">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <xsl:if test="$selectedColumns/column/@name='eng_change_type'">
		                	<columnDef name="eng_change_type" type="STRING"/>
		                </xsl:if>
		                <xsl:if test="$selectedColumns/column/@name='eng_activity_change_type'">
		                	<columnDef name="eng_activity_change_type" type="STRING"/>
		                </xsl:if>
		            </xsl:if>
		            
					<xsl:if test="$enableEngTid='true'">
						<columnDef name="eng_creation_tid" type="LONG"/>
						<columnDef name="eng_deletion_tid" type="LONG"/>
						<columnDef name="eng_last_update_tid" type="LONG"/>
						<columnDef name="eng_activation_tid" type="LONG"/>
						<columnDef name="eng_deactivation_tid" type="LONG"/>
					</xsl:if>		            
		            
		            </columns>
		            <shadowColumns/>
		            <comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>
		</xsl:for-each>
	</xsl:if>
</xsl:template>

<xsl:template name="instanceSteps">
	<xsl:param name="mode"/>
	<xsl:variable name="prefix"><xsl:if test="@prefix !=''"><xsl:value-of select="@prefix"/>.</xsl:if></xsl:variable>
	<xsl:variable name="enableEngTid"><xsl:value-of select="advanced/@enableTID"/></xsl:variable>
	
	<xsl:if test="@allEntities='true'">
		<xsl:for-each select="$databaseModel/instanceTables/*|$databaseModel/refData/*">
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
				<properties>
		            <columns>
						<!-- <xsl:call-template name="instanceColumns"/> -->
						
						<xsl:for-each select="columns/column">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <!-- added by TVY -->
		                 <xsl:if test="$mode='delta'">   
							 <columnDef name="eng_change_type" type="STRING"/>
							<columnDef name="eng_activity_change_type" type="STRING"/> 
						</xsl:if>

						<xsl:if test="$enableEngTid='true'">
							<columnDef name="eng_creation_tid" type="LONG"/>
							<columnDef name="eng_deletion_tid" type="LONG"/>
							<columnDef name="eng_last_update_tid" type="LONG"/>
							<columnDef name="eng_activation_tid" type="LONG"/>
							<columnDef name="eng_deactivation_tid" type="LONG"/>
						</xsl:if>	
						 
		            </columns>
		            <shadowColumns/>
		            <comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>   
		</xsl:for-each>
	</xsl:if>
	<xsl:if test="@allEntities='false'">
	<xsl:for-each select="selectedTables/*">
		<xsl:variable name="tableName" select="@name" />
		<xsl:variable name="allColumns" select="@allColumns"/>
		<xsl:variable name="selectedColumns" select="columns"/>
		<xsl:variable name="position" select="position()-1"/>		
		
		<xsl:for-each select="$databaseModel/instanceTables/*[@name=lower-case($tableName)]|$databaseModel/refData/*[@name=lower-case($tableName)]">
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		        <properties>
		            <columns>
						<!-- <xsl:call-template name="instanceColumns"/> -->
						<xsl:if test="$allColumns='true'">  
		                	<xsl:for-each select="columns/column">
		                		<xsl:call-template name="column"/>
		                	</xsl:for-each>
		                	<!-- added by TVY-->
		                	<xsl:if test="$mode='delta'">   
								<columnDef name="eng_change_type" type="STRING"/>
								<columnDef name="eng_activity_change_type" type="STRING"/>  					
							</xsl:if> 						
		            	</xsl:if> 
		            	<xsl:if test="$allColumns='false'">
							<xsl:for-each select="columns/column[@name=$selectedColumns/column/@name]">
		                		<xsl:call-template name="column"/>
		                	</xsl:for-each>
		                	 <xsl:if test="$selectedColumns/column/@name='eng_change_type'">
		                	<columnDef name="eng_change_type" type="STRING"/>
			                </xsl:if>
			                <xsl:if test="$selectedColumns/column/@name='eng_activity_change_type'">
			                	<columnDef name="eng_activity_change_type" type="STRING"/>
			                </xsl:if>
		            	</xsl:if>
		            	
						<xsl:if test="$enableEngTid='true'">
							<columnDef name="eng_creation_tid" type="LONG"/>
							<columnDef name="eng_deletion_tid" type="LONG"/>
							<columnDef name="eng_last_update_tid" type="LONG"/>
							<columnDef name="eng_activation_tid" type="LONG"/>
							<columnDef name="eng_deactivation_tid" type="LONG"/>
						</xsl:if>		            	
		            	
		            </columns>
		            <shadowColumns/>
		            <comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>
		</xsl:for-each>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="local-name(.)='conditionalInstanceDataSource'">
	<xsl:variable name="allColumns" select="@allColumns"/>
		<xsl:variable name="selectedColumns" select="columns"/>
		<xsl:for-each select="$databaseModel/instanceTables/*[@name=current()/@entityName]|$databaseModel/refData/*[@name=current()/@entityName]">
			<step id="{$prefix}{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
		        <properties>
		            <columns>
						<!--  <xsl:call-template name="instanceColumns"/> -->
		                <!--<xsl:if test="$mode='delta'">   
							 <columnDef name="eng_change_type" type="STRING"/> 
							<columnDef name="eng_activity_change_type" type="STRING"/>
						</xsl:if>  -->
					<xsl:if test="$allColumns='true'">  
		                <xsl:for-each select="columns/column">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <xsl:if test="$mode='delta'">
		                	<columnDef name="eng_change_type" type="STRING"/> 
							<columnDef name="eng_activity_change_type" type="STRING"/>
						</xsl:if>
		            </xsl:if> 
		            <xsl:if test="$allColumns='false'">
						<xsl:for-each select="columns/column[@name=$selectedColumns/column/@name]">
		                	<xsl:call-template name="column"/>
		                </xsl:for-each>
		                <xsl:if test="$selectedColumns/column/@name='eng_change_type'">
		                	<columnDef name="eng_change_type" type="STRING"/>
		                </xsl:if>
		                <xsl:if test="$selectedColumns/column/@name='eng_activity_change_type'">
		                	<columnDef name="eng_activity_change_type" type="STRING"/>
		                </xsl:if>
		            </xsl:if>
		            
					<xsl:if test="$enableEngTid='true'">
						<columnDef name="eng_creation_tid" type="LONG"/>
						<columnDef name="eng_deletion_tid" type="LONG"/>
						<columnDef name="eng_last_update_tid" type="LONG"/>
						<columnDef name="eng_activation_tid" type="LONG"/>
						<columnDef name="eng_deactivation_tid" type="LONG"/>
					</xsl:if>			            
		            
		            </columns>
		            <shadowColumns/>
		            <comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
		        </properties>
		    </step>
		</xsl:for-each>
	</xsl:if>
</xsl:template>

<xsl:template name="column">
	<xsl:choose>
		<xsl:when test="@type='long_int'"><columnDef name="{@name}" type="LONG"/></xsl:when>
		<xsl:otherwise><columnDef name="{@name}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- 
<xsl:template name="masColumns">
	<columnDef name="eng_active" type="BOOLEAN"/>
	<columnDef name="eng_last_update_date" type="DATETIME"/>
	<columnDef name="eng_creation_date" type="DATETIME"/>
	<columnDef name="eng_deletion_date" type="DATETIME"/>
	<columnDef name="eng_activation_date" type="DATETIME"/>
	<columnDef name="eng_deactivation_date" type="DATETIME"/>
</xsl:template> 

<xsl:template name="instanceColumns">
	<columnDef name="id" type="LONG"/>
	<columnDef name="eng_active" type="BOOLEAN"/>
	<columnDef name="eng_origin" type="STRING"/>
	<columnDef name="source_id" type="STRING"/>
	<columnDef name="eng_source_system" type="STRING"/>
	<columnDef name="eng_last_update_date" type="DATETIME"/>
	<columnDef name="eng_last_source_update_date" type="DATETIME"/>
	<columnDef name="eng_creation_date" type="DATETIME"/>
	<columnDef name="eng_deletion_date" type="DATETIME"/>
	<columnDef name="eng_activation_date" type="DATETIME"/>
	<columnDef name="eng_deactivation_date" type="DATETIME"/>
	<columnDef name="eng_source_timestamp" type="DATETIME"/> 
</xsl:template>
-->
</xsl:stylesheet>