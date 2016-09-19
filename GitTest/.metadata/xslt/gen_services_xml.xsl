<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="settings" select="document('param:settings')/*"/> <!--/settings -->

<!-- Bound to (/services)/nativeServices -->
<xsl:template match="/*">
<serviceConfig>
	<services>
		<xsl:if test="basicServices/@getInstance='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.GetInstanceByIdServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@getInstance='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.GetMasterByIdServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@genTraversal='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.GenericTraversalMasterService" />
		</xsl:if>
		<xsl:if test="basicServices/@listInstance='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.ListInstancesServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@listMaster='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.ListMastersServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@searchInstance='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.SearchInstancesServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@searchMaster='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.SearchMastersServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@processDelta='true'">
			<service class="com.ataccama.nme.internal.engine.services.handlers.ProcessDeltaService" />
		</xsl:if>
				
		<xsl:for-each select="configurableServices/processDeltaAdv[@enable='true']">
			<service class="com.ataccama.nme.internal.engine.services.handlers.ProcessDeltaService" name="{@name}"> 
				<xsl:choose>
					<xsl:when test="count(dependencySettings/tableSettings/table)>0">
						<xsl:attribute name="sourceDeletionStrategy">
						<xsl:choose>
							<xsl:when test="dependencySettings/@deletionStrategy='use global setting (from Preferences)'">
								<xsl:value-of select="$settings/@deletionStrategy"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="dependencySettings/@deletionStrategy"/>  
							</xsl:otherwise>
						</xsl:choose>
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<entities>
					<xsl:for-each select="partialTables/partialTable">
						<entity name="{@name}" class="com.ataccama.nme.internal.engine.services.handlers.rw.AutonomousEntity" >
							<xsl:choose>
								<xsl:when test="partialColumns/partialColumn">
									<columns>
										<xsl:for-each select="partialColumns/partialColumn">
					                		<column><xsl:value-of select="@name"/></column>
					                	</xsl:for-each>
					            	</columns>
			            		</xsl:when>
			            		<xsl:otherwise></xsl:otherwise>
			            	</xsl:choose>
	           			</entity>	
					</xsl:for-each>
					
					<xsl:for-each select="dependencySettings/tableSettings/table[@mode='central']">
						<entity name="{@name}" class="com.ataccama.nme.internal.engine.services.handlers.rw.CentralEntity" keyColumn="{@keyColumn}" >
							<xsl:choose>
								<xsl:when test="partialColumns/partialColumn">
									<columns>
										<xsl:for-each select="partialColumns/partialColumn">
					                		<column><xsl:value-of select="@name"/></column>
					                	</xsl:for-each>
					            	</columns>
					            </xsl:when>
					            <xsl:otherwise></xsl:otherwise>
					        </xsl:choose>
	           			</entity>	
					</xsl:for-each>
					<xsl:for-each select="dependencySettings/tableSettings/table[not(@mode='central' or @mode='autonomous')]">
						<entity name="{@name}" class="com.ataccama.nme.internal.engine.services.handlers.rw.DependentEntity" keyColumn="{@keyColumn}" centralEntity="{@mode}">
							<xsl:choose>
								<xsl:when test="partialColumns/partialColumn">
									<columns>
										<xsl:for-each select="partialColumns/partialColumn">
					                		<column><xsl:value-of select="@name"/></column>
					                	</xsl:for-each>
					            	</columns>
					            </xsl:when>
					            <xsl:otherwise></xsl:otherwise>
					    	</xsl:choose>
	           			</entity>	
					</xsl:for-each>
					<xsl:for-each select="dependencySettings/tableSettings/table[@mode='autonomous']">
						<entity name="{@name}" class="com.ataccama.nme.internal.engine.services.handlers.rw.AutonomousEntity" >
							<xsl:choose>
								<xsl:when test="partialColumns/partialColumn">	
									<columns>
										<xsl:for-each select="partialColumns/partialColumn">
					                		<column><xsl:value-of select="@name"/></column>
					                	</xsl:for-each>
					            	</columns>
					            </xsl:when>
					            <xsl:otherwise></xsl:otherwise>
					        </xsl:choose>
		           		</entity>	
					</xsl:for-each>
				 </entities>
			</service>
		</xsl:for-each>
		
		
		<xsl:for-each select="configurableServices/processUpsert[@enable='true']">
			<!-- WARNING: system has to be configured in Connected Systems -->
			<service class="com.ataccama.nme.internal.engine.services.handlers.ProcessUpsertService" system="{@system}" entity="{@entity}" > 
			<xsl:choose>
				<xsl:when test="@requiredRole!=''">
				<xsl:attribute name="requiredRole">
					<xsl:value-of select="@requiredRole"/>
				</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			</service>
		</xsl:for-each>
		
		<!-- preparation for processMatch as configurable service 
		<xsl:for-each select="configurableServices/processMatch[@enable='true']">
			<service class="com.ataccama.nme.internal.engine.services.handlers.ProcessMatchService" />
		</xsl:for-each>
		 -->
		 <xsl:if test="basicServices/@processMatch='true'">	
			<service class="com.ataccama.nme.internal.engine.services.handlers.ProcessMatchService" />
		</xsl:if>
		
		<xsl:for-each select="configurableServices/identify[@enable='true']">
			<!-- WARNING: don't forget to enable Identify Web Service for appropriate entity (Instance Layer/<entity>/Matching tab) -->  
			<service class="com.ataccama.nme.internal.engine.services.handlers.IdentifyMasterService" entity="{@entity}" masterLayer='{@masterLayer}' >
			<xsl:choose>
				<xsl:when test="@name!=''">
				<xsl:attribute name="name">
					<xsl:value-of select="@name"/>
				</xsl:attribute>
				</xsl:when>
			</xsl:choose> 
			<xsl:choose>
				<xsl:when test="@requiredRole!=''">
				<xsl:attribute name="requiredRole">
					<xsl:value-of select="@requiredRole"/>
				</xsl:attribute>
				</xsl:when>
			</xsl:choose>  
			</service>
		</xsl:for-each>
		
		<xsl:for-each select="configurableServices/cleanseService[@enable='true']">
			<service class="com.ataccama.nme.internal.engine.services.handlers.CleanseService" entity="{@entity}">
			<xsl:choose>
				<xsl:when test="@name!=''">
				<xsl:attribute name="name">
					<xsl:value-of select="@name"/>
				</xsl:attribute>
				</xsl:when>
			</xsl:choose>  
			</service>
		</xsl:for-each>
				
		<xsl:if test="basicServices/@batchControl='true'">	
			<service class="com.ataccama.nme.internal.engine.services.handlers.BatchControlServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@modelStat='true'">	
			<service class="com.ataccama.nme.internal.engine.services.handlers.ModelStatisticsServiceBundle" />
		</xsl:if>
		<xsl:if test="basicServices/@getModel='true'">	
			<service class="com.ataccama.nme.internal.engine.services.handlers.ModelServiceBundle" />
	   </xsl:if> 
	   	<xsl:if test="basicServices/@rwControl='true'">	
			<service class="com.ataccama.nme.internal.engine.services.handlers.ReadWriteControlServiceBundle" />
	   </xsl:if> 
	</services>
	<endpoints>
		<xsl:for-each select="endpointsDefinition/httpEndpoint[@enable='true']">
			<endpoint class="com.ataccama.nme.internal.engine.services.endpoints.HttpEndpoint" pathPrefix="/{@pathPrefix}">
            	<xsl:choose>
            		<xsl:when test="@listenerNames!=''">	
            			<xsl:attribute name="listenerNames">
							<xsl:value-of select="@listenerNames"/>
						</xsl:attribute>
            		</xsl:when>
            		<xsl:otherwise>
            			<xsl:attribute name="listenerNames">
							<xsl:text>all</xsl:text>
						</xsl:attribute>
            		</xsl:otherwise>
            	</xsl:choose>
            	<xsl:choose>
            		<xsl:when test="@format='SOAP'">	
            			 <format class="com.ataccama.nme.internal.engine.services.endpoints.SoapFormat"/>
            		</xsl:when>
            		<xsl:when test="@format='XML RPC'">
            			<format class="com.ataccama.nme.internal.engine.services.endpoints.XmlRpcFormat"/>
            		</xsl:when>
            	</xsl:choose>
            	
        	</endpoint>	
		</xsl:for-each>
		<xsl:for-each select="endpointsDefinition/jmsEndpoint[@enable='true']">
			<endpoint class="com.ataccama.nme.internal.engine.services.endpoints.JmsEndpoint" pathPrefix="/{@pathPrefix}">
            	<xsl:choose>
            		<xsl:when test="@listenerNames!=''">	
            			<xsl:attribute name="listenerNames">
							<xsl:value-of select="@listenerNames"/>
						</xsl:attribute>
            		</xsl:when>
            		<xsl:otherwise>
            			<xsl:attribute name="listenerNames">
							<xsl:text>all</xsl:text>
						</xsl:attribute>
            		</xsl:otherwise>
            	</xsl:choose>
            	<xsl:choose>
            		<xsl:when test="@format='SOAP'">	
            			 <format class="com.ataccama.nme.internal.engine.services.endpoints.SoapFormat"/>
            		</xsl:when>
            		<xsl:when test="@format='XML RPC'">
            			<format class="com.ataccama.nme.internal.engine.services.endpoints.XmlRpcFormat"/>
            		</xsl:when>
            	</xsl:choose>
            	<connectionName><xsl:value-of select="@connectionName"/></connectionName>
            	<inputDestination><xsl:value-of select="@inputDestination"/></inputDestination>
            	<outputDestination><xsl:value-of select="@outputDestination"/></outputDestination>
            	<activityByReadWriteMode><xsl:value-of select="@activityByReadWriteMode"/></activityByReadWriteMode>
            	<outputParameters>
	            	<xsl:for-each select="outputParameters/outputParameter">
	            		<outputParameter name="{@name}" value="{@value}" type="{@type}"/>
	            	</xsl:for-each>
            	</outputParameters>
        	</endpoint>	
		</xsl:for-each>
  	</endpoints>
	<accessControlHandlers>
		<!--
		<handler class="sample.nme.ExampleAccessControlHandler" />
		-->
	</accessControlHandlers>
</serviceConfig>
</xsl:template></xsl:stylesheet>