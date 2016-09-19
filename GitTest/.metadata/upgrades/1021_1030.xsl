<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl sf"> -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/metadata">
		<metadata>
			<xsl:copy-of select="//settings"/>
			<xsl:copy-of select="//systems"/>
			<xsl:copy-of select="//logicalModel"/>
			<outputOperations>
				<xsl:copy-of select="//outputOperations/exportModel"/>
				<eventHandler>
					<handlers>
						<xsl:for-each select="outputOperations/eventHandler/handlers/handler">
							<handler desc="{@desc}" persistenceDir="{@persistenceDir}" enable="{@enable}" class="{@class}">
								<publishers>
									<xsl:for-each select="publishers/stdOutPublisher">
										<xsl:copy-of select="//stdOutPublisher"/>
									</xsl:for-each>
									<xsl:for-each select="publishers/jmsPublisher">
										<xsl:copy-of select="//jmsPublisher"/>
									</xsl:for-each>			
									<xsl:for-each select="publishers/httpSoapPublisher">
										<xsl:copy-of select="//httpSoapPublisher"/>
									</xsl:for-each>		
									<xsl:for-each select="publishers/eventSqlPublisher">
										<xsl:copy-of select="//eventSqlPublisher"/>
									</xsl:for-each>		
									<xsl:for-each select="publishers/ismPublisher">
										<xsl:copy-of select="//ismPublisher"/>
									</xsl:for-each>		
									<xsl:for-each select="publishers/eventPlanPublisher">
										<eventPlanPublisher enable="{@enable}" layerName="{@layerName}">
											<description><xsl:value-of select="description|@description"/></description>
											<planAdvancedSettings>
												<planFilteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
												</planFilteringPublisher>
												<retryingPublisher maxRetries="{@maxRetries}" consecutiveSuccess="{@consecutiveSuccess}" retryDelay="{@retryDelay}" retry="{@retry}" globalRetries="{@globalRetries}"/>
											</planAdvancedSettings>
											<entityName allColumns="{entityName/@allColumns}" entity="{entityName/@entity}"/>
											<columnsMeta>
												<xsl:for-each select="columnsMeta/columnMeta">
													<columnMeta name="{@name}"/>
												</xsl:for-each>
											</columnsMeta>
											<columns>
												<xsl:for-each select="columns/column">
													<column old="{@old}" new="{@new}" name="{@name}"/>
												</xsl:for-each>
											</columns>
										</eventPlanPublisher>									
									</xsl:for-each>
								</publishers>	
								<xsl:copy-of select="//filter"/>						
							</handler>
						</xsl:for-each>
					</handlers>				
				</eventHandler>
			</outputOperations>
			<xsl:copy-of select="//nativeServices"/>
			<xsl:copy-of select="//transformations"/>
			<xsl:copy-of select="//preview"/>
			<xsl:copy-of select="//documentationRoot"/>
			<advancedSettings>
				<xsl:copy-of select="//taskInfoExport"/>
				<xsl:copy-of select="//reprocessSettings"/>
				<xsl:copy-of select="//historyPlugin"/>
				<migration>
					<migrationExport migExport="{migration/migrationExport/@migExport}"/>
					<migrationLoad loadMatch="{@loadMatch}" loadId="false" migLoad="{@migLoad}" loadEng="{@loadEng}" loadHist="{@loadHist}">
					</migrationLoad>
				</migration>
			</advancedSettings>
		</metadata>
	</xsl:template>
</xsl:stylesheet>
