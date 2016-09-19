<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="databaseModel" select="document('param:databaseModel')/*"/>
<xsl:param name="exportModel" select="document('param:exportModel')/*"/>
<xsl:param name="settings" select="document('param:settings')/*"/>
<xsl:param name="advancedSettings" select="document('param:advancedSettings')/*"/>
<xsl:param name="logicalModel" select="document('param:logicalModel')/*"/>

<xsl:variable name="global_deletion_strategy" select="$settings/@deletionStrategy"/>
<xsl:variable name="global_export_scope" select="$settings/@scope"/>
<xsl:variable name="not_default" select="'deactivate delete'"/>
<xsl:variable name="not_default_export" select="'active existing'"/>
<!-- Bound to /systems -->
<xsl:template match="/*">
<batch>
	<loadOperations>
		<xsl:for-each select="system/loadOperations/*">
			<xsl:apply-templates mode="load" select=".">
				<xsl:with-param name="mappings" select="../../sourceMappings"/>
			</xsl:apply-templates>
			<!-- <xsl:if test="advanced[@initialloadOperation='true']">
				<xsl:apply-templates mode="initial" select="."/>
			</xsl:if> -->	
		</xsl:for-each>
		
	<!-- reprocessings -->
		<xsl:apply-templates select="$advancedSettings/reprocessSettings/reprocess/*"/>
	
	<!--dictionaries-->
		<xsl:apply-templates select="$databaseModel/refData[physicalTable]">

		</xsl:apply-templates>
	<!-- GUI Config/Batch -->
		<xsl:for-each select="$logicalModel/masterModels/masterModel/guiConfig[@enableGui='true' and @guiMode='Read-Write']">
			<xsl:variable name="guiConfig" select="."/>
			<xsl:variable name="guiModelName" select="ancestor::masterModel/@name"/>
			<!-- full load -->
			<xsl:if test="$guiConfig/batchOperations/@guiFullLoad='true'">
				<op name="{$guiConfig/@guiSystem}_full" class="com.ataccama.nme.engine.batch.FullLoadBatchOperation">  					
    				<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
						planFileName="../engine/load/{$guiConfig/@guiSystem}_full.comp" >										
					</dataProvider>		
    				<sourceSystem><xsl:value-of select="$guiConfig/@guiSystem"/></sourceSystem>
    				<!-- all entities -->
    				<xsl:choose>
	    				<xsl:when test="$guiConfig/batchOperations/@guiLoadAllEntities='true'">	
		    				<importedEntities>
		    					<xsl:for-each select="$logicalModel/masterModels/masterModel[@name=$guiModelName]/masterTables/masterTable[guiEdit/@guiReadOnly='use global setting (from GUI Configuration)']">
		        					<entity name="{lower-case(@instanceTable)}" />
		        				</xsl:for-each>
		    				</importedEntities>
	    				</xsl:when>
	    				<!-- some entities -->
	    				<xsl:otherwise>	
		    				<importedEntities>
		    					<xsl:for-each select="$guiConfig/batchOperations/loadedEntities/loadedEntity">		    						
		        					<entity name="{lower-case(@name)}" />
		        				</xsl:for-each>
		    				</importedEntities>
	    				</xsl:otherwise>
    				</xsl:choose>
				</op>
			</xsl:if>
			<!-- initial load -->
			<xsl:if test="$guiConfig/batchOperations/@guiInitialLoad='true'">
				<op name="{$guiConfig/@guiSystem}_initial" class="com.ataccama.nme.engine.batch.InitialLoadBatchOperation">  					
    				<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
						planFileName="../engine/load/{$guiConfig/@guiSystem}_initial.comp" >					
					</dataProvider>		
    				<sourceSystem><xsl:value-of select="$guiConfig/@guiSystem"/></sourceSystem>    			
    				<!-- 
    				<xsl:choose>
	    				<xsl:when test="$guiConfig/batchOperations/@guiLoadAllEntities='true'">	
		    				<importedEntities>
		    					<xsl:for-each select="$logicalModel/masterModels/masterModel[@name=$guiModelName]/masterTables/masterTable[guiEdit/@guiReadOnly='use global setting (from GUI Configuration)']">
		        					<entity name="{@instanceTable}" />
		        				</xsl:for-each>
		    				</importedEntities>
	    				</xsl:when>
	    				<xsl:otherwise>	
		    				<importedEntities>
		    					<xsl:for-each select="$guiConfig/batchOperations/loadedEntities/loadedEntity">
		    						<entity name="{@name}"/>
		        				</xsl:for-each>
		    				</importedEntities>
	    				</xsl:otherwise>
    				</xsl:choose>
    				-->
				</op>
			</xsl:if>	    		
		</xsl:for-each>
		<!-- migration -->
		<xsl:if test="$advancedSettings/migration/migrationLoad/@migLoad='true'">
			<op name="migration_load" class="com.ataccama.nme.engine.batch.InitialLoadBatchOperation">  					
		  		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
						planFileName="../engine/migration/migration_load.comp" >
				</dataProvider>	
				<ignorePersistence><xsl:value-of select="'true'"/></ignorePersistence>	
				<xsl:if test="$advancedSettings/migration/migrationLoad/@loadId='true'">
					<preserveIds>true</preserveIds>                         <!-- default is false -->
				</xsl:if>
				<xsl:if test="$advancedSettings/migration/migrationLoad/@loadEng='true'">
					<preserveMetadataColumns>true</preserveMetadataColumns> <!-- default is false -->
				</xsl:if>
				<xsl:if test="$advancedSettings/migration/migrationLoad/@loadHist='true'">
					<!--  No configuration needed - just provide values in records sent to IntegrationOutput in the column with the same name as history collector. Values will be combined from provided historical values and current value.  -->
				</xsl:if>
				<xsl:if test="$advancedSettings/migration/migrationLoad/@loadMatch='true'">
					<preserveColumns>
						<!-- todo / complete it - only selected columns should be added -->        				
        				
        				<xsl:for-each-group select="$databaseModel/instanceTables/physicalTable/columns/column" group-by="@name">
        					<xsl:if test="@origin='internal_match'">
        						<column entities="*" names="{@name}"/>
        					</xsl:if>
        				</xsl:for-each-group>
						
						<!-- <column entities="*" names="mat_*" /> Similar concept as in ignoredComparisonColumns -->        				
        				
        				<xsl:for-each select="$advancedSettings/migration/migrationLoad/selectedMatchingColumns/selectedMatchingColumn">
        					<xsl:variable name="columnName" select="@name"/>
        					<xsl:choose>
								<xsl:when test="@allEntities='true'">
        							<column entities="*" names="{@name}"/>
        						</xsl:when>
        						<xsl:otherwise>
        							<xsl:for-each select="selectedEntities/selectedEntity">
        								<column entities="{@name}" names="{$columnName}" />
        							</xsl:for-each>
        						</xsl:otherwise>
        					</xsl:choose>
        				</xsl:for-each>
    				</preserveColumns>
				</xsl:if>				
		  	</op>    	
		</xsl:if>	
		
		<xsl:for-each select="$advancedSettings/manualMatch/manualMatchOperations/*">
			<op name="manual_match_{@name}" class="com.ataccama.nme.engine.batch.ManualMatchBatchOperation">
			    <dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" planFileName="../engine/load/manual_match_{@name}.comp" />
			    <xsl:if test="matchings/matching">
				    <matchings>
				    	<xsl:for-each select="matchings/matching">
				    		<matching><xsl:value-of select="@name"/></matching>		        					        	
				        </xsl:for-each>
				    </matchings>
				</xsl:if>
			</op>
		</xsl:for-each>
		
	</loadOperations>
	<exportOperations>
		<xsl:for-each select="$exportModel/*">
			<xsl:apply-templates mode="export" select="."/>
		</xsl:for-each>
		<xsl:apply-templates select="$advancedSettings/taskInfoExport/plans/plan"/>
		<!-- migration -->
		<xsl:if test="$advancedSettings/migration/migrationExport/@migExport='true'">			
			<op name="migration_export" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
  				<dataProviders>
    				<dataProvider prefix="" class="com.ataccama.nme.engine.batch.InstanceLayerDataSource"/>
  				</dataProviders>				
				<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/migration/migration_export.comp">
  				</publisher>
			</op>			
		</xsl:if>
	</exportOperations>	
</batch>
</xsl:template>

<xsl:template match="initialLoad" mode="load">
	<xsl:variable name="sysName" select="ancestor::system/@name" />
	<op name="{$sysName}_{@nameSuffix}" sourceSystem="{$sysName}" class="com.ataccama.nme.engine.batch.InitialLoadBatchOperation">
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
			planFileName="../engine/load/{$sysName}_{@nameSuffix}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>							
		</dataProvider>	
		<xsl:if test="@ignorePersistence!=''">	
			<ignorePersistence><xsl:value-of select="@ignorePersistence"/></ignorePersistence>
		</xsl:if>
	</op>
</xsl:template>

<xsl:template match="fullLoad" mode="load">
	<xsl:variable name="sysName" select="ancestor::system/@name" />
	<op name="{$sysName}_{@nameSuffix}" sourceSystem="{$sysName}" class="com.ataccama.nme.engine.batch.FullLoadBatchOperation">
		<xsl:attribute name="sourceDeletionStrategy">	
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default, ' '), concat(' ', advanced/@deletionStrategy, ' '))">
					<xsl:value-of select="advanced/@deletionStrategy"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$global_deletion_strategy"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
			planFileName="../engine/load/{$sysName}_{@nameSuffix}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>				
		</dataProvider>
		
		<!-- ignored comparison columns -->
		<xsl:if test="$settings/advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn|advanced/ignoredComparisonColumns/ignoredComparisonColumn">
			<xsl:call-template name="ignoredComparisonCols"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="@allTables='true'">
				<importAllEntities>true</importAllEntities>
			</xsl:when>
			<xsl:otherwise>
				<importedEntities>
					<xsl:for-each select="selectedTables/*">
						<entity name="{lower-case(@name)}" />
					</xsl:for-each>
				</importedEntities>
			</xsl:otherwise>
		</xsl:choose> 
	</op>
</xsl:template>

<!-- DIRECT LOAD -->
<xsl:template match="directLoad" mode="load">
	<xsl:variable name="sysName" select="ancestor::system/@name" />
	<op name="{$sysName}_{@nameSuffix}" class="com.ataccama.nme.engine.batch.DirectLoadBatchOperation"> <!-- sourceSystem="{$sysName}" is not allowed -->
		
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
			planFileName="../engine/load/{$sysName}_{@nameSuffix}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>				
		</dataProvider>
		<!-- <xsl:choose>
			<xsl:when test="@allTables='true'">
				<importAllEntities>true</importAllEntities>
			</xsl:when>
			<xsl:otherwise>
				<importedEntities>
					<xsl:for-each select="selectedTables/*">
						<entity name="{@name}" />
					</xsl:for-each>
				</importedEntities>
			</xsl:otherwise>
		</xsl:choose>  -->
	</op>
</xsl:template>



<xsl:template match="deltaLoad" mode="load">
	<xsl:variable name="sysName" select="ancestor::system/@name" />
	<op name="{$sysName}_{@nameSuffix}" sourceSystem="{$sysName}" class="com.ataccama.nme.engine.batch.DeltaLoadBatchOperation">
			<xsl:attribute name="sourceDeletionStrategy">	
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default, ' '), concat(' ', advanced/@deletionStrategy, ' '))">
					<xsl:value-of select="advanced/@deletionStrategy"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$global_deletion_strategy"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
			planFileName="../engine/load/{$sysName}_{@nameSuffix}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>				
		</dataProvider>
		
		<!-- ignored comparison columns -->
		<xsl:if test="$settings/advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn|advanced/ignoredComparisonColumns/ignoredComparisonColumn">
			<xsl:call-template name="ignoredComparisonCols"/>
		</xsl:if>
		
		<descriptors>
			
			<xsl:choose>
			<xsl:when test="@allTables='true'">
				<xsl:for-each select="ancestor::system/sourceMappings/mapping">
					<xsl:if test="preceding-sibling::mapping/@entity != @entity or count(preceding-sibling::mapping)=0">
						<descriptor class="com.ataccama.nme.engine.batch.load.AutonomousEntity"	name="{lower-case(@entity)}" />
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="selectedTables/*">
					<descriptor class="com.ataccama.nme.engine.batch.load.AutonomousEntity"	name="{lower-case(@name)}" />
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose> 
		</descriptors>
	</op>
</xsl:template>

<xsl:template match="complexDeltaLoad" mode="load">
<xsl:param name="mappings"/>
	<xsl:variable name="sysName" select="ancestor::system/@name" />
	<op name="{$sysName}_{@nameSuffix}" sourceSystem="{$sysName}" class="com.ataccama.nme.engine.batch.DeltaLoadBatchOperation">
			<xsl:attribute name="sourceDeletionStrategy">	
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default, ' '), concat(' ', advanced/@deletionStrategy, ' '))">
					<xsl:value-of select="advanced/@deletionStrategy"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$global_deletion_strategy"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" 
			planFileName="../engine/load/{$sysName}_{@nameSuffix}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>				
		</dataProvider>
		
		<!-- ignored comparison columns -->
		<xsl:if test="$settings/advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn|advanced/ignoredComparisonColumns/ignoredComparisonColumn">
			<xsl:call-template name="ignoredComparisonCols"/>
		</xsl:if>
		
		<descriptors>
		<xsl:variable name="tableSet" select="tableSettings"/>
		<xsl:variable name="partitionedtableSet" select="advanced/partitionedEntities"/>
			<xsl:for-each select="tableSettings/table">
			<xsl:variable name="table_name" select="@name"/>
			<xsl:variable name="count_dependent" select="count(preceding-sibling::table[@name=$table_name and @mode!='central' and @mode!='autonomous' ])+count(following-sibling::table[@name=$table_name and @mode!='central' and @mode!='autonomous' ])"/>
				<xsl:choose>
					<xsl:when test="@mode='autonomous'">
						<descriptor class="com.ataccama.nme.engine.batch.load.AutonomousEntity"	name="{lower-case(@name)}" />
					</xsl:when>
					<xsl:when test="@mode='central'">
						<descriptor class="com.ataccama.nme.engine.batch.load.CentralEntity" name="{lower-case(@name)}"
							 keyColumn="{@keyColumn}"/>
					</xsl:when>
					<xsl:otherwise>
						<!--<xsl:if test="count(preceding-sibling::table[@name=current()/@name])=0 and count(following-sibling::table[@name=current()/@name])=0">-->
							<descriptor class="com.ataccama.nme.engine.batch.load.DependentEntity" name="{lower-case(@name)}" keyColumn="{@keyColumn}" centralEntity="{@mode}"/>
						<!--</xsl:if>-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			
			<xsl:for-each select="advanced/partitionedEntities/entity">
				<xsl:variable name="table_name" select="@name"/>
				<xsl:variable name="cnt_prec" select="count(preceding-sibling::entity[@name=current()/@name])"/>
				<xsl:variable name="cnt_foll" select="count(following-sibling::entity[@name=current()/@name])"/>
				
				<xsl:if test="$cnt_prec =0 and $cnt_foll>0">	
					<descriptor class="com.ataccama.nme.engine.batch.load.PartitionedDependentEntity" name="{@name}" >
						<partitions>
							<xsl:for-each select="$partitionedtableSet/entity[@name=$table_name]">
								<partition originId="{@origin}" keyColumn="{@keyColumn}" centralEntity="{@mode}" />
							</xsl:for-each>
						</partitions>
					</descriptor>
				</xsl:if>
			</xsl:for-each>
		</descriptors>
		
	</op>
</xsl:template>


<xsl:template match="fullMasterExport" mode="export">
	<op name="{lower-case(@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
		<dataProviders>
			<dataProvider class="com.ataccama.nme.engine.batch.MasterLayerDataSource" viewName="{lower-case(@layerName)}" >
				<xsl:attribute name="scope">
					<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
					<xsl:value-of select="fn:upper-case(@scope)"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
			</xsl:choose>
				</xsl:attribute>
			</dataProvider>
		</dataProviders>
		<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{@name}.comp">
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>
		</publisher>
	</op>
</xsl:template>

<xsl:template match="fullInstanceExport" mode="export">
	<op name="{lower-case(@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
		<dataProviders>
			<dataProvider class="com.ataccama.nme.engine.batch.InstanceLayerDataSource">
				<xsl:attribute name="scope">
					<xsl:choose>
						<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
							<xsl:value-of select="fn:upper-case(@scope)"/>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:if test="@sourceSystem != ''"><sourceSystem><xsl:value-of select="@sourceSystem"/></sourceSystem></xsl:if>
			</dataProvider>
		</dataProviders>
		<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{@name}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>
		</publisher>
	</op>
</xsl:template>

<xsl:template match="deltaMasterExport" mode="export">
	<op name="{lower-case(@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
		<dataProviders>
			<dataProvider class="com.ataccama.nme.engine.batch.MasterLayerDeltaDataSource" viewName="{@layerName}">
				<xsl:attribute name="scope">
					<xsl:choose>
						<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
							<xsl:value-of select="fn:upper-case(@scope)"/>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</dataProvider>
		</dataProviders>
		<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{@name}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>
		</publisher>
	</op>
</xsl:template>

<xsl:template match="deltaInstanceExport" mode="export">
	<op name="{lower-case(@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
		<dataProviders>
			<dataProvider class="com.ataccama.nme.engine.batch.InstanceLayerDeltaDataSource" >
				<xsl:attribute name="scope">
					<xsl:choose>
						<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
							<xsl:value-of select="fn:upper-case(@scope)"/>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
					<xsl:if test="@sourceSystem != ''"><sourceSystem><xsl:value-of select="@sourceSystem"/></sourceSystem></xsl:if>
			</dataProvider>
		</dataProviders>
		<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{@name}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>
		</publisher>
	</op>
</xsl:template>

<xsl:template match="complexExport" mode="export">
	<op name="{lower-case(@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
		<dataProviders>
			<xsl:apply-templates mode="exportSource" select="dataSources/*" />
		</dataProviders>
		<publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{@name}.comp" >
			<xsl:if test="advanced/pathVariables/pathVariable">
				<pathVariables>
					<xsl:for-each select="advanced/pathVariables/pathVariable">
	        			<pathVariable name="{@name}" value="{@value}"/>
	    			</xsl:for-each>
	    		</pathVariables>
	    	</xsl:if>
	    	<xsl:if test="advanced/additionalParameters/additionalParameter">
			    <additionalParameters>
			    	<xsl:for-each select="advanced/additionalParameters/additionalParameter">
			        	<additionalParameter name="{@name}" value="{@value}"/>
			        </xsl:for-each>
			    </additionalParameters>
			</xsl:if>	
		</publisher>
	</op>
</xsl:template>

<xsl:template match="instanceDataSource" mode="exportSource">
	<xsl:variable name="clazz">InstanceLayer<xsl:if test="@mode='delta'">Delta</xsl:if>DataSource</xsl:variable>
	<dataProvider class="com.ataccama.nme.engine.batch.{$clazz}">
		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
					<xsl:value-of select="fn:upper-case(@scope)"/>
				</xsl:when>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', ancestor::complexExport/@scope, ' '))">
						<xsl:value-of select="fn:upper-case(ancestor::complexExport/@scope)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="fn:upper-case($global_export_scope)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="@sourceSystem != ''"><sourceSystem><xsl:value-of select="@sourceSystem"/></sourceSystem></xsl:if>
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
	</dataProvider>
</xsl:template>

<xsl:template match="masterDataSource" mode="exportSource">
	<xsl:variable name="clazz">MasterLayer<xsl:if test="@mode='delta'">Delta</xsl:if>DataSource</xsl:variable>
	<dataProvider class="com.ataccama.nme.engine.batch.{$clazz}" viewName="{@layerName}">
		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
					<xsl:value-of select="fn:upper-case(@scope)"/>
				</xsl:when>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', ancestor::complexExport/@scope, ' '))">
						<xsl:value-of select="fn:upper-case(ancestor::complexExport/@scope)"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
	</dataProvider>
</xsl:template>

<xsl:template match="historyInstanceEntityDataSource" mode="exportSource">
	<dataProvider class="com.ataccama.nme.history.batch.HistoryInstanceEntityDataSource">
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
		<entity><xsl:value-of select="lower-case(@entity)"/></entity>
		<xsl:choose>
			<xsl:when test="@sourceSystem!=''">
				<sourceSystem><xsl:value-of select="@sourceSystem"/></sourceSystem>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</dataProvider>
</xsl:template>

<xsl:template match="historyMasterEntityDataSource" mode="exportSource">
	<dataProvider class="com.ataccama.nme.history.batch.HistoryMasterEntityDataSource">
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
  		<entity><xsl:value-of select="lower-case(cc/@entityName)"/></entity>
    	<viewName><xsl:value-of select="cc/@layerName"/></viewName>
	</dataProvider>
</xsl:template>

<xsl:template match="conditionalInstanceDataSource" mode="exportSource">
	<xsl:variable name="clazz">InstanceEntity<xsl:if test="@mode='delta'">Delta</xsl:if>DataSource</xsl:variable>
	<dataProvider class="com.ataccama.nme.engine.batch.export.{$clazz}" entity="{lower-case(@entityName)}">
		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
					<xsl:value-of select="fn:upper-case(@scope)"/>
				</xsl:when>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', ancestor::complexExport/@scope, ' '))">
						<xsl:value-of select="fn:upper-case(ancestor::complexExport/@scope)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="fn:upper-case($global_export_scope)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="@sourceSystem != ''"><sourceSystem><xsl:value-of select="@sourceSystem"/></sourceSystem></xsl:if>
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
		<conditions>
			<xsl:apply-templates select="conditions/condition"/>
		</conditions>
	</dataProvider>
</xsl:template>

<xsl:template match="conditionalMasterDataSource" mode="exportSource">
	<xsl:variable name="clazz">MasterEntity<xsl:if test="@mode='delta'">Delta</xsl:if>DataSource</xsl:variable>
	<dataProvider class="com.ataccama.nme.engine.batch.export.{$clazz}" viewName="{@layerName}" entity="{lower-case(@entityName)}">
		<xsl:attribute name="scope">
			<xsl:choose>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', @scope, ' '))">
					<xsl:value-of select="fn:upper-case(@scope)"/>
				</xsl:when>
				<xsl:when test="contains( concat(' ', $not_default_export, ' '), concat(' ', ancestor::complexExport/@scope, ' '))">
						<xsl:value-of select="fn:upper-case(ancestor::complexExport/@scope)"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:upper-case($global_export_scope)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="@prefix != ''"><prefix><xsl:value-of select="@prefix"/>.</prefix></xsl:if>
		<conditions>
			<xsl:apply-templates select="conditions/condition"/>
		</conditions>
	</dataProvider>
</xsl:template>

<xsl:template match="condition">
	 <condition column="{@column}" value="{@value}">
		<xsl:attribute name="operator">	
			<xsl:choose>
				<xsl:when test="@operator = '='">EQ</xsl:when>
				<xsl:when test="@operator = '&gt;'">GT</xsl:when>
				<xsl:when test="@operator = '&lt;'">LT</xsl:when>
				<xsl:when test="@operator = '&gt;='">GE</xsl:when>
				<xsl:when test="@operator = '&lt;='">LE</xsl:when>
				<xsl:when test="@operator = '&lt;&gt;'">NE</xsl:when>
				<xsl:otherwise><xsl:value-of select="@operator"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</condition>
</xsl:template>

<xsl:template match="*" mode="load">
	<xsl:comment>Cannot build definition for load <xsl:value-of select="@nameSuffix"/> (<xsl:value-of select="local-name(.)"/>).</xsl:comment>
</xsl:template>

<xsl:template match="*" mode="export">
	<xsl:comment>Cannot build definition for export <xsl:value-of select="@name"/> (<xsl:value-of select="local-name(.)"/>).</xsl:comment>
</xsl:template>

<xsl:template match="*" mode="exportSource">
	<xsl:comment>Cannot build definition for export source <xsl:value-of select="@prefix"/> (<xsl:value-of select="local-name(.)"/>).</xsl:comment>
</xsl:template>

<xsl:template name="ignoredComparisonCols">
	<ignoredComparisonColumns>	
	<!--if there is a local setting of ignored columns then it overrides the global settings -->
	<xsl:if test="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
			<xsl:for-each select="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
				<xsl:choose>
					<xsl:when test="@allEntities='true'">
							<column names="{@names}" entities="*"/>
					</xsl:when>
					<xsl:when test="@allEntities='false' and entities/entity">
						<column names="{@names}" >
							<xsl:attribute name="entities">
								<xsl:for-each select="entities/entity">
									<xsl:value-of select="lower-case(@name)"/>
									<xsl:if test="following-sibling::entity/@name!=''">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:attribute>
						</column>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
	</xsl:if>
	<!-- Check if there is no local settings of ignored columns, then global is used -->
	<xsl:if test="not(advanced/ignoredComparisonColumns/ignoredComparisonColumn)">
		<xsl:for-each select="$settings/advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn">
			<xsl:choose>
				<xsl:when test="@allEntities='true'">
					<column names="{@names}" entities="*"/>
				</xsl:when>
				<xsl:when test="@allEntities='false' and entities/entity">
					<column names="{@names}" >
						<xsl:attribute name="entities">
							<xsl:for-each select="entities/entity">
								<xsl:value-of select="lower-case(@name)"/>
								<xsl:if test="following-sibling::entity/@name!=''">
								    <xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</column>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:if>
	</ignoredComparisonColumns>
</xsl:template>

<xsl:template match="full">
	<op name="{@plan}" class="com.ataccama.nme.engine.batch.FullReprocessBatchOperation">
	   <processAllEntities><xsl:value-of select="@allTables"/></processAllEntities>
		<xsl:if test="@allTables='false'">
		<processedEntities>
			<xsl:for-each select="entities/entity">
				<entity name="{lower-case(@name)}" />
			</xsl:for-each>
		</processedEntities>
		</xsl:if>
		<rematchAll><xsl:value-of select="@rematchAll"/></rematchAll>
		<ignorePersistence><xsl:value-of select="@ignorePersistence"/></ignorePersistence>
	</op>
</xsl:template>

<xsl:template match="partial">
	<op name="{@plan}" class="com.ataccama.nme.engine.batch.ReprocessBatchOperation">
		<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" planFileName="../engine/load/reprocess/{@plan}.comp" />
		<recordIdentification>
			<xsl:choose>
				<xsl:when test="@recordId='SOURCE_ID + ORIGIN'">SOURCE_ID</xsl:when>
				<xsl:otherwise>ID</xsl:otherwise>
			</xsl:choose>
		</recordIdentification>
	</op>
</xsl:template>

<xsl:template match="refData">

	<op name="hub_reference_data_full" class="com.ataccama.nme.engine.batch.FullLoadBatchOperation" sourceDeletionStrategy="{fn:upper-case($global_deletion_strategy)}">
			<dataProvider class="com.ataccama.nme.dqc.batch.PlanBatchDataSource" planFileName="../engine/load/referenceData/hub_reference_data.comp"/>
			<sourceSystem>hub_reference_data</sourceSystem>
			<importedEntities>
				<xsl:for-each select="physicalTable[@layerName='Loaded_master' or @layerName='Loaded_translation']">
					<entity name="{lower-case(@name)}"/>
				</xsl:for-each>
			</importedEntities>
		</op>
</xsl:template>

<xsl:template match="plan">
	<op name="{lower-case(../../@name)}" class="com.ataccama.nme.engine.batch.StandardBatchExportOperation">
        <dataProviders>
            <dataProvider class="com.ataccama.nme.engine.batch.TaskInfoDataSource"/>
            <xsl:if test="../../@ehStatus='true'">
            	<dataProvider class="com.ataccama.nme.engine.batch.TaskEventHandlerInfoDataSource" prefix="eh_" />
            </xsl:if>
        </dataProviders>
        <publisher class="com.ataccama.nme.dqc.batch.PlanBatchExportPublisher" planFileName="../engine/export/{../../@name}.comp"/>
    </op>
</xsl:template>

</xsl:stylesheet>