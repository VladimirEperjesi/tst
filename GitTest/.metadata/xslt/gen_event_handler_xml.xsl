<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!-- Bound to /outputOperations/eventHandler -->
<xsl:template match="/*">
	<handlers>
		<xsl:apply-templates select="handlers/handler[@enable='true']"/>
	</handlers>
</xsl:template>

<xsl:template match="handler">
	<handler>
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="@class='EventHandlerAsync'">com.ataccama.nme.engine.event.handler.EventHandlerAsync</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		<persistenceDir><xsl:value-of select="@persistenceDir"/></persistenceDir>
		<xsl:call-template name="filter"/>
		<publishers>	
			<xsl:apply-templates select="publishers/*[@enable='true']" />
       </publishers>
    </handler>
</xsl:template>

<!-- FILTER -->
<xsl:template name="filter">
	<filter>
		<filterExpression><xsl:value-of select="filter/@expression|filter/expression|advanced/filteringPublisher/@expression|advanced/filteringPublisher/expression|planAdvancedSettings/planFilteringPublisher/@expression|planAdvancedSettings/planFilteringPublisher/expression"/></filterExpression>
		<xsl:if test="filter/entities/entity">
			<entities>
				<xsl:apply-templates select="filter/entities/entity"/>
			</entities>
		</xsl:if>
		<xsl:if test="advanced/filteringPublisher/filteredEntities/entity">
			<entities>
				<xsl:apply-templates select="advanced/filteringPublisher/filteredEntities/entity"/>
			</entities>
		</xsl:if>	
	</filter>
</xsl:template>

<!-- FILTER ENTITY -->
<xsl:template match="entity">
	<xsl:variable name="name" select="fn:replace(@name,'(.+) [(]([\p{L}_]+)[)]','$1')"/>
	<xsl:variable name="type">
		<xsl:choose>
			<xsl:when test="fn:matches($name,'rd_.+')">instance</xsl:when>
			<xsl:otherwise><xsl:value-of select="fn:replace(@name,'(.+) [(]([\p{L}_]+)[)]','$2')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
		<entity name="{$name}" >
			<!-- modified -->
			<xsl:attribute name="layer">
				<xsl:choose>
					<xsl:when test="$type='instance' or $type='dictionary'">instance</xsl:when>
					<xsl:otherwise>master</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$type='instance' or $type='dictionary'">
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="masterView">
						<xsl:value-of select="$type"/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@expression|expression !=''">
				<filterExpression><xsl:value-of select="@expression|expression"/></filterExpression>
			</xsl:if>
		</entity>
</xsl:template>

<!-- EVENT SQL PUBLISHER -->
<xsl:template match="eventSqlPublisher" >
	<!-- filter events incoming into publisher -->
	<xsl:if test="advanced/filteringPublisher/@filter='true' and advanced/retryingPublisher/@retry='false'">
		<xsl:call-template name="filteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventSqlPublisher'"/>
			<xsl:with-param name="template" select="'sql'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='false' ">
		<xsl:call-template name="retryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventSqlPublisher'"/>
			<xsl:with-param name="template" select="'sql'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='true' ">
		<xsl:call-template name="complexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventSqlPublisher'"/>
			<xsl:with-param name="template" select="'sql'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="advanced/retryingPublisher/@retry='false' and advanced/filteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.engine.event.handler.publishers.EventSqlPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'sql'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- EVENT HTTP SOAP PUBLISHER -->
<xsl:template match="httpSoapPublisher">
		<!-- filter events incoming into publisher -->
	<xsl:if test="advanced/filteringPublisher/@filter='true' and advanced/retryingPublisher/@retry='false'">
		<xsl:call-template name="filteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventHttpSoapPublisher'"/>
			<xsl:with-param name="template" select="'soap'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='false'">
		<xsl:call-template name="retryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventHttpSoapPublisher'"/>
			<xsl:with-param name="template" select="'soap'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='true' ">
		<xsl:call-template name="complexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventHttpSoapPublisher'"/>
			<xsl:with-param name="template" select="'soap'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="advanced/retryingPublisher/@retry='false' and advanced/filteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.engine.event.handler.publishers.EventHttpSoapPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'soap'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- EVENT JMS PUBLISHER -->
<xsl:template match="jmsPublisher">
	<!-- filter events incoming into publisher -->
	<xsl:if test="advanced/filteringPublisher/@filter='true' and advanced/retryingPublisher/@retry='false' ">
		<xsl:call-template name="filteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventJmsPublisher'"/>
			<xsl:with-param name="template" select="'jms'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='false'">
		<xsl:call-template name="retryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventJmsPublisher'"/>
			<xsl:with-param name="template" select="'jms'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='true' ">
		<xsl:call-template name="complexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.EventJmsPublisher'"/>
			<xsl:with-param name="template" select="'jms'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="advanced/retryingPublisher/@retry='false' and advanced/filteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.engine.event.handler.publishers.EventJmsPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'jms'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- iSM PUBLISHER -->
<xsl:template match="ismPublisher">
	<!-- filter events incoming into publisher -->
	<xsl:if test="advanced/filteringPublisher/@filter='true' and advanced/retryingPublisher/@retry='false' ">
		<xsl:call-template name="filteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.IsmPublisher'"/>
			<xsl:with-param name="template" select="'ism'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='false'">
		<xsl:call-template name="retryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.IsmPublisher'"/>
			<xsl:with-param name="template" select="'ism'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='true' ">
		<xsl:call-template name="complexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.IsmPublisher'"/>
			<xsl:with-param name="template" select="'ism'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="advanced/retryingPublisher/@retry='false' and advanced/filteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.engine.event.handler.publishers.IsmPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'ism'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- STD OUT PUBLISHER -->
<xsl:template match="stdOutPublisher" >
	<!-- filter events incoming into publisher -->
	<xsl:if test="advanced/filteringPublisher/@filter='true' and advanced/retryingPublisher/@retry='false'">
		<xsl:call-template name="filteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.StdOutPublisher'"/>
			<xsl:with-param name="template" select="'stdOut'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='false' ">
		<xsl:call-template name="retryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.StdOutPublisher'"/>
			<xsl:with-param name="template" select="'stdOut'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="advanced/retryingPublisher/@retry='true' and advanced/filteringPublisher/@filter='true' ">
		<xsl:call-template name="complexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.engine.event.handler.publishers.StdOutPublisher'"/>
			<xsl:with-param name="template" select="'stdOut'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="advanced/retryingPublisher/@retry='false' and advanced/filteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.engine.event.handler.publishers.StdOutPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'stdOut'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- EVENT PLAN PUBLISHER -->
<xsl:template match="eventPlanPublisher">
	<!-- filter events incoming into publisher -->
	<xsl:if test="planAdvancedSettings/planFilteringPublisher/@filter='true' and planAdvancedSettings/retryingPublisher/@retry='false'">
		<xsl:call-template name="planFilteringPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.dqc.event.EventPlanPublisher'"/>
			<xsl:with-param name="template" select="'eventPlan'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- retry publishing event -->
	<xsl:if test="planAdvancedSettings/retryingPublisher/@retry='true' and planAdvancedSettings/planFilteringPublisher/@filter='false' ">
		<xsl:call-template name="planRetryingPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.dqc.event.EventPlanPublisher'"/>
			<xsl:with-param name="template" select="'eventPlan'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- both filter and retry -->
	<xsl:if test="planAdvancedSettings/retryingPublisher/@retry='true' and planAdvancedSettings/planFilteringPublisher/@filter='true' ">
		<xsl:call-template name="planComplexPublisher">
			<xsl:with-param name="class" select="'com.ataccama.nme.dqc.event.EventPlanPublisher'"/>
			<xsl:with-param name="template" select="'eventPlan'"/>
		</xsl:call-template>
	</xsl:if>
	<!-- simple publisher -->
	<xsl:if test="planAdvancedSettings/retryingPublisher/@retry='false' and planAdvancedSettings/planFilteringPublisher/@filter='false'">
		<publisher class="com.ataccama.nme.dqc.event.EventPlanPublisher">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="'eventPlan'"/>
			</xsl:call-template>
		</publisher>
	</xsl:if>
</xsl:template>

<!-- PLAN RETRYING PUBLISHER -->
<xsl:template name="planRetryingPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.RetryingPublisher">
		<globalRetries><xsl:value-of select="planAdvancedSettings/retryingPublisher/@globalRetries"/></globalRetries>
		<retryDelay><xsl:value-of select="planAdvancedSettings/retryingPublisher/@retryDelay"/></retryDelay>
		<numberOfConsecutiveSuccessesGrantingRetry><xsl:value-of select="planAdvancedSettings/retryingPublisher/@consecutiveSuccess"/></numberOfConsecutiveSuccessesGrantingRetry>
		<maximumRetries><xsl:value-of select="planAdvancedSettings/retryingPublisher/@maxRetries"/></maximumRetries>
		<delegate class="{$class}"> 
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="$template"/>
			</xsl:call-template>
		</delegate>
	</publisher>
</xsl:template>

<!-- RETRYING PUBLISHER -->
<xsl:template name="retryingPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.RetryingPublisher">
		<globalRetries><xsl:value-of select="advanced/retryingPublisher/@globalRetries"/></globalRetries>
		<retryDelay><xsl:value-of select="advanced/retryingPublisher/@retryDelay"/></retryDelay>
		<numberOfConsecutiveSuccessesGrantingRetry><xsl:value-of select="advanced/retryingPublisher/@consecutiveSuccess"/></numberOfConsecutiveSuccessesGrantingRetry>
		<maximumRetries><xsl:value-of select="advanced/retryingPublisher/@maxRetries"/></maximumRetries>
		<delegate class="{$class}"> 
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="$template"/>
			</xsl:call-template>
		</delegate>
	</publisher>
</xsl:template>

<!-- PLAN FILTERING PUBLISHER -->
<xsl:template name="planFilteringPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.FilteringPublisher">
		<filter>
			<!-- <filterExpression><xsl:value-of select="planAdvancedSettings/planFilteringPublisher/@expression|planAdvancedSettings/planFilteringPublisher/expression"/></filterExpression>-->
			<entities>
				<xsl:choose>
					<xsl:when test="@layerName='instance'">
						<entity name="{entityName/@entity}" layer="instance">
							<filterExpression><xsl:value-of select="planAdvancedSettings/planFilteringPublisher/@expression|planAdvancedSettings/planFilteringPublisher/expression"/></filterExpression>
						</entity>
					</xsl:when>
					<xsl:otherwise>
						<entity name="{entityName/@entity}" layer="master" masterView="{@layerName}">
							<filterExpression><xsl:value-of select="planAdvancedSettings/planFilteringPublisher/@expression|planAdvancedSettings/planFilteringPublisher/expression"/></filterExpression>
						</entity>					
					</xsl:otherwise>
				</xsl:choose>
			</entities>	
		</filter>
		<delegate class="{$class}">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="$template"/>
			</xsl:call-template>
		</delegate>
	</publisher>
</xsl:template>

<!-- FILTERING PUBLISHER -->
<xsl:template name="filteringPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.FilteringPublisher">
		<xsl:call-template name="filter"/>
		<delegate class="{$class}">
			<xsl:call-template name="publisher">
				<xsl:with-param name="template" select="$template"/>
			</xsl:call-template>
		</delegate>
	</publisher>
</xsl:template>

<!-- PLAN COMPLEX PUBLISHER -->
<xsl:template name="planComplexPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.FilteringPublisher">
		
		<xsl:call-template name="filter"/>
		<delegate class="com.ataccama.nme.engine.event.handler.publishers.RetryingPublisher">
			<globalRetries><xsl:value-of select="planAdvancedSettings/retryingPublisher/@globalRetries"/></globalRetries>
			<retryDelay><xsl:value-of select="planAdvancedSettings/retryingPublisher/@retryDelay"/></retryDelay>
			<numberOfConsecutiveSuccessesGrantingRetry><xsl:value-of select="planAdvancedSettings/retryingPublisher/@consecutiveSuccess"/></numberOfConsecutiveSuccessesGrantingRetry>
			<maximumRetries><xsl:value-of select="planAdvancedSettings/retryingPublisher/@maxRetries"/></maximumRetries>
			<delegate class="{$class}"> 
				<xsl:call-template name="publisher">
					<xsl:with-param name="template" select="$template"/>
				</xsl:call-template>
			</delegate>
		</delegate>
	</publisher>
</xsl:template>

<!-- COMPLEX PUBLISHER -->
<xsl:template name="complexPublisher">
	<xsl:param name="class"/>
	<xsl:param name="template"/>
	
	<publisher class="com.ataccama.nme.engine.event.handler.publishers.FilteringPublisher">
		
		<xsl:call-template name="filter"/>
		<delegate class="com.ataccama.nme.engine.event.handler.publishers.RetryingPublisher">
			<globalRetries><xsl:value-of select="advanced/retryingPublisher/@globalRetries"/></globalRetries>
			<retryDelay><xsl:value-of select="advanced/retryingPublisher/@retryDelay"/></retryDelay>
			<numberOfConsecutiveSuccessesGrantingRetry><xsl:value-of select="advanced/retryingPublisher/@consecutiveSuccess"/></numberOfConsecutiveSuccessesGrantingRetry>
			<maximumRetries><xsl:value-of select="advanced/retryingPublisher/@maxRetries"/></maximumRetries>
			<delegate class="{$class}"> 
				<xsl:call-template name="publisher">
					<xsl:with-param name="template" select="$template"/>
				</xsl:call-template>
			</delegate>
		</delegate>
	</publisher>
</xsl:template>

<!--ALL PUBLISHERS -->
<xsl:template name="publisher">
	<xsl:param name="template"/>
	<!-- SQL publisher -->
	<xsl:if test="$template='sql'">
		<dataSource><xsl:value-of select="@dataSource"/></dataSource>
			<templates>
				<xsl:for-each select="sqlTemplates/template">
					<xsl:variable name="name" select="fn:replace(@name,'(.+) [(]([\p{L}_]+)[)]','$1')"/>
					<xsl:variable name="type">
						<xsl:choose>
							<xsl:when test="fn:matches($name,'rd_.+')">instance</xsl:when>
							<xsl:otherwise><xsl:value-of select="fn:replace(@name,'(.+) [(]([\p{L}_]+)[)]','$2')"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<t>
					<entity name="{$name}" >
						<xsl:attribute name="layer">
							<xsl:choose>
								<xsl:when test="$type='instance' or $type='dictionary'">instance</xsl:when>
								<xsl:otherwise>master</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$type='instance' or $type='dictionary'">
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="masterView">
									<xsl:value-of select="$type"/>
								</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</entity>
					<template><xsl:value-of select="@template|template"/></template>
					</t>
				</xsl:for-each>
			</templates>
	</xsl:if>
	<!-- SOAP publisher -->
	<xsl:if test="$template='soap'">
		<url><xsl:value-of select="@urlResourceName"/></url>
		<soapAction><xsl:value-of select="@soapAction"/></soapAction>
		<xsl:if test="@userName !=''"><username><xsl:value-of select="@userName"/></username></xsl:if>
		<xsl:if test="@password !=''"><password><xsl:value-of select="@password"/></password></xsl:if>
		<xsl:if test="@soapVersion !=''"><soapVersion><xsl:value-of select="@soapVersion"/></soapVersion></xsl:if>
		<xsl:if test="@timeout !=''"><timeout><xsl:value-of select="@timeout"/></timeout></xsl:if>
		<xsl:if test="@encoding !=''"><encoding><xsl:value-of select="@encoding"/></encoding></xsl:if>
		<xsl:if test="@delay !=''"><delayBetweenRequestsMs><xsl:value-of select="@delay"/></delayBetweenRequestsMs></xsl:if>
		<!-- TRANSFORMERS -->	
			<xsl:apply-templates select="transformers" />
	</xsl:if>
	<!-- JMS publisher -->
	<xsl:if test="$template='jms'">
		<connectionName><xsl:value-of select="@connectionName"/></connectionName>
		<destination><xsl:value-of select="@destination"/></destination>
		<contentType><xsl:value-of select="@contentType"/></contentType>
		<headers>
			<xsl:apply-templates select="headers/header"/>
		</headers>
		<!-- TRANSFORMERS -->	
		<xsl:apply-templates select="transformers" />

	</xsl:if>
	<!-- iSM publisher -->
	<xsl:if test="$template='ism'">
		<host><xsl:value-of select="@host"/></host>
		<port><xsl:value-of select="@port"/></port>
		<targetSystem><xsl:value-of select="@targetSystem"/></targetSystem>
	</xsl:if>
	
	<!-- Std Out publisher -->
	<xsl:if test="$template='stdOut'">
		<xsl:apply-templates select="transformers" />
		<!-- <publisher class="com.ataccama.nme.engine.event.handler.publishers.StdOutPublisher">
			<xsl:apply-templates select="transformers" />
		</publisher> -->
	</xsl:if>
	
	<!-- Event Plan Publisher -->
	<xsl:if test="$template='eventPlan'">
			<entity>
				<xsl:choose>
					<xsl:when test="@layerName='instance'">
						<xsl:attribute name="layer">
							<xsl:value-of select="'instance'" />
						</xsl:attribute>			
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="layer">
							<xsl:value-of select="'master'" />
						</xsl:attribute>
						<xsl:attribute name="masterView">
							<xsl:value-of select="@layerName" />
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
    		
    			<xsl:attribute name="name">
    				<xsl:value-of select="entityName/@entity" />
    			</xsl:attribute>
    		</entity>
    		
   	 	<xsl:variable name="filename">
   	 		<xsl:value-of select="'../engine/events/ep_'"/>
   	 		<xsl:value-of select="@layerName"/>
   	 		<xsl:value-of select="'_'"/>
   	 		<xsl:value-of select="entityName/@entity"/>
  	 		<xsl:value-of select="@suffix"/>
  	 		<xsl:value-of select="'.comp'"/>
   	 	</xsl:variable>
   	 		    		
    	<xsl:choose>	
    		<xsl:when test="document($filename)">
                The file exists!
			</xsl:when>	
			<xsl:otherwise>
		   	 	<planFileName>
		   	 		<xsl:value-of select="'../engine/events/ep_'"/>
		   	 		<xsl:value-of select="@layerName"/>
		   	 		<xsl:value-of select="'_'"/>
		   	 		<xsl:value-of select="entityName/@entity"/>		   	 	
		   	 		<xsl:value-of select="@suffix"/>
		   	 		<xsl:value-of select="'.comp'"/>
		   	 	</planFileName>				
			</xsl:otherwise>
		</xsl:choose>
    			
	</xsl:if>	
</xsl:template>

<!-- TRANSFORMERS -->
<xsl:template match="transformers">
	<xsl:if test="count(./*)>1">
		<transformer class="com.ataccama.nme.engine.event.handler.publishers.transformers.MultiTransformer">
			<transformers>
				<xsl:apply-templates select="*" mode="transformer"/>
			</transformers>
		</transformer>
	</xsl:if>
	<xsl:if test="count(./*)=1">
		<xsl:apply-templates select="*" mode="transformer"/>
	</xsl:if>
</xsl:template>
<!--
<xsl:template match="multiTransformer" mode="transformer">
	<transformer class="com.ataccama.nme.engine.event.handler.publishers.transformers.MultiTransformer">
		<transformers>
			<xsl:apply-templates select="nestedTransformers/transformers/*" mode="nested"/>
		</transformers>
    </transformer>
</xsl:template>
-->
<xsl:template match="expressionTemplateTransformer" mode="transformer">
	<transformer class="com.ataccama.nme.engine.event.handler.publishers.transformers.ExpressionTemplateTransformer">
		<xsl:variable name="name" select="fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$1')"/>
		<xsl:variable name="type">
			<xsl:choose>
				<xsl:when test="fn:matches($name,'rd_.+')">instance</xsl:when>
				<xsl:otherwise><xsl:value-of select="fn:replace(@entityName,'(.+) [(]([\p{L}_]+)[)]','$2')"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		<xsl:if test="@entityName!=''">
		<entity name="{$name}" >
			<xsl:attribute name="layer">
				<xsl:choose>
					<xsl:when test="$type='instance' or $type='dictionary'">instance</xsl:when>
					<xsl:otherwise>master</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$type='instance' or $type='dictionary'">
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="masterView">
						<xsl:value-of select="$type"/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</entity>
		</xsl:if>
		<template><xsl:value-of select="@template|template"/></template>
		
	</transformer>
</xsl:template>

<xsl:template match="simpleXmlTransformer" mode="transformer">
	<transformer class="com.ataccama.nme.engine.event.handler.publishers.transformers.SimpleXmlTransformer">
		<indent><xsl:value-of select="@indent"/></indent>
		<includeOldValues><xsl:value-of select="@includeOldValues"/></includeOldValues>
	</transformer>
</xsl:template>
<!--
<xsl:template match="multiTransformer" mode="nested">
	<t class="com.ataccama.nme.engine.event.handler.publishers.transformers.MultiTransformer">
		<transformers>
			<xsl:apply-templates select="nestedTransformers/transformers/*" mode="nested"/>
		</transformers>
    </t>
</xsl:template>

<xsl:template match="expressionTemplateTransformer" mode="nested">
	<t class="com.ataccama.nme.engine.event.handler.publishers.transformers.ExpressionTemplateTransformer">
		<xsl:variable name="name" select="fn:replace(@entityName,'(.+) [(]([a-z]+)[)]','$1')"/>
		<xsl:variable name="type" select="fn:replace(@entityName,'(.+) [(]([a-z]+)[)]','$2')"/>	
		<xsl:if test="@entityName!=''">
		<entity name="{$name}" >
			<xsl:attribute name="layer">
				<xsl:choose>
					<xsl:when test="$type='instance'">instance</xsl:when>
					<xsl:otherwise>master</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="$type !='instance'">
				<xsl:attribute name="masterView"><xsl:value-of select="$type"/></xsl:attribute>
			</xsl:if>
		</entity>
		</xsl:if>
		<template><xsl:value-of select="@template|template"/></template>
    </t>
</xsl:template>
-->
<xsl:template match="header">
	<header name="{@name}" value="{@value}" type="{@type}" />
</xsl:template>

</xsl:stylesheet>