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
			<logicalModel>
				<xsl:copy-of select="//logicalModel/instanceModel"/>
				<masterModels>
					<xsl:for-each select="//logicalModel/masterModels/masterModel">
						<masterModel name="{@name}">
							<xsl:copy-of select="description"/>
							<xsl:copy-of select="relationships"/>
							<xsl:copy-of select="masterTables"/>
							<xsl:copy-of select="instanceTables"/>
							<guiConfig enableGui="{guiConfig/@enableGui}" guiSystem="{guiConfig/@guiSystem}" guiMode="{if(guiConfig/@guiReadOnly = 'true') then 'Read-Only' else 'Read-Write'}">
								<hierarchies>
									<xsl:for-each select="guiConfig/hierarchies/hierarchy1N">
										<hierarchy1N relationship="{@relationship}" label="{@label}">
											<startPoint position="endpoints/endpoint[@type='Start']/@possition" label="{endpoints/endpoint[@type='Start']/@label}"/>
											<endPoint position="endpoints/endpoint[@type='End']/@possition" label="{endpoints/endpoint[@type='End']/@label}"/>
											<connection connectionShape="{connection/@connectionShape}" connectionColour="{connection/@connectionColour}">
											</connection>
										</hierarchy1N>
									</xsl:for-each>
									<xsl:for-each select="guiConfig/hierarchies/hierarchyMN">
										<hierarchyMN tableMN="{@tableMN}" label="{@label}">
											<startPoint position="endpoints/endpoint[@type='Start']/@possition" label="{endpoints/endpoint[@type='Start']/@label}"/>
											<endPoint position="endpoints/endpoint[@type='End']/@possition" label="{endpoints/endpoint[@type='End']/@label}"/>
											<connection connectionShape="{connection/@connectionShape}" connectionColour="{connection/@connectionColour}">
											</connection>
										</hierarchyMN>
									</xsl:for-each>
								</hierarchies>
								<xsl:copy-of select="actions"/>
								<xsl:copy-of select="indicators"/>	
								<xsl:copy-of select="batchOperations"/>																
							</guiConfig>							
						</masterModel>
					</xsl:for-each>
				</masterModels>
				<xsl:copy-of select="//logicalModel/dictionary"/>
			</logicalModel>
			<xsl:copy-of select="//outputOperations"/>		
			<nativeServices>
				<xsl:for-each select="//nativeServices/basicServices">
					<xsl:copy-of select="basicServices"/>					
				</xsl:for-each>				
				<configurableServices>
					<xsl:for-each select="//nativeServices/configurableServices/identify">
						<identify desc="{@desc}" name="{@name}" masterLayer="{@masterLayer}" entity="{@entity}" enable="{@enable}"/>
					</xsl:for-each>
					<xsl:for-each select="//nativeServices/configurableServices/processUpsert">
						<processUpsert system="{@system}" desc="{@desc}" entity="{@entity}" enable="{@enable}"/>
					</xsl:for-each>
					<xsl:for-each select="//nativeServices/configurableServices/processDelta">						
						<processDeltaAdv desc="{@desc}" enable="{@enable}">							
						</processDeltaAdv>
					</xsl:for-each>									
				</configurableServices>
				<xsl:copy-of select="//nativeServices/endpointsDefinition"/>	
			</nativeServices>
			<xsl:copy-of select="//transformations"/>
			<xsl:copy-of select="//preview"/>
			<xsl:copy-of select="//documentationRoot"/>
			<xsl:copy-of select="//advancedSettings"/>			
		</metadata>
	</xsl:template>
</xsl:stylesheet>
