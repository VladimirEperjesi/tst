<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl sf"> -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/metadata">
		<metadata>
			<xsl:copy-of select="settings"/>
			<xsl:copy-of select="systems"/>
			<logicalModel>
				<xsl:copy-of select="logicalModel/instanceModel"/>
				<masterModels>
					<xsl:for-each select="logicalModel/masterModels/masterModel">
						<masterModel name="{@name}">
							<description><xsl:value-of select="description|@description"/></description>
							<xsl:copy-of select="relationships"/>
							<masterTables>
								<xsl:for-each select="masterTables/masterTable">
									<masterTable name="{@name}" label="{@label}" entityRole="{@entityRole}" instanceTable="{lower-case(@instanceTable)}" topLevel="{@topLevel}">
										<description><xsl:value-of select="description|@description"/></description>
										<xsl:copy-of select="columns"/>								
										<guiTab>
											<xsl:copy-of select="guiTab/views"/>																					
											<computedColumns>
												<xsl:for-each select="guiTab/computedColumns/column">
													<column dataType="{@dataType}" description="{@description}" name="{@name}" label="{@label}" indexType="{if(@searchable='false') then 'NONE' else 'BOTH'}">
														<producer><xsl:value-of select="producer|@producer"/></producer>
													</column>
												</xsl:for-each>
											</computedColumns>
											<xsl:copy-of select="guiTab/reduceES"/>
										</guiTab>
										<xsl:copy-of select="advanced"/>
										<xsl:copy-of select="guiEdit"/>	
									</masterTable>
								</xsl:for-each>
							</masterTables>
							<instanceTables>
								<xsl:for-each select="instanceTables/instanceTable">
									<instanceTable name="{@name}" label="{@label}" instanceTable="{@instanceTable}" topLevel="{@topLevel}">
										<guiTab>
											<xsl:copy-of select="guiTab/views"/>
											<computedColumns>
												<xsl:for-each select="guiTab/computedColumns/column">
													<column dataType="{@dataType}" description="{@description}" name="{@name}" label="{@label}" indexType="{if(@searchable='false') then 'NONE' else 'BOTH'}">
														<producer><xsl:value-of select="producer|@producer"/></producer>
													</column>
												</xsl:for-each>
											</computedColumns>
											<xsl:copy-of select="guiTab/reduceES"/>										
										</guiTab>
										<xsl:copy-of select="columns"/>
									</instanceTable>
								</xsl:for-each>
							</instanceTables>							
							<xsl:copy-of select="guiConfig"/>
						</masterModel>
					</xsl:for-each>
				</masterModels>
				<xsl:copy-of select="logicalModel/dictionary"/>
			</logicalModel>
			<outputOperations>
				<exportModel>
					<xsl:for-each select="outputOperations/exportModel/complexExport">					
						<complexExport scope="{@scope}" name="{@name}">
							<xsl:copy-of select="description"/>
							<dataSources>
								<xsl:for-each select="dataSources/conditionalInstanceDataSource">
									<xsl:variable name="systemName" select="@sourceSystem"/>
									<xsl:variable name="UpperSystemName" select="//systems/system[lower-case(@name)=$systemName]/@name"/>
									<conditionalInstanceDataSource scope="{@scope}" sourceSystem="{$UpperSystemName}" allColumns="{@allColumns}" prefix="{@prefix}" mode="{@mode}" entityName="{@entityName}">
										<xsl:copy-of select="conditions"/>
										<xsl:copy-of select="columns"/>
									</conditionalInstanceDataSource>
								</xsl:for-each>
								<xsl:copy-of select="dataSources/conditionalMasterDataSource"/>		
								<xsl:for-each select="dataSources/historyInstanceEntityDataSource">		
									<xsl:variable name="systemName" select="@sourceSystem"/>
									<xsl:variable name="UpperSystemName" select="//systems/system[lower-case(@name)=$systemName]/@name"/>	
									<historyInstanceEntityDataSource sourceSystem="{$UpperSystemName}" allColumns="{@allColumns}" prefix="{@prefix}" entity="{@entity}">
										<xsl:copy-of select="historyInstanceColumns"/>
									</historyInstanceEntityDataSource>
								</xsl:for-each>
								<xsl:copy-of select="dataSources/historyMasterEntityDataSource"/>		
								<xsl:for-each select="dataSources/instanceDataSource">
									<xsl:variable name="systemName" select="@sourceSystem"/>
									<xsl:variable name="UpperSystemName" select="//systems/system[lower-case(@name)=$systemName]/@name"/>
									<instanceDataSource scope="{@scope}" allEntities="{@allEntities}" sourceSystem="{$UpperSystemName}" prefix="{@prefix}" mode="{@mode}">
										<xsl:copy-of select="selectedTables"/>										
									</instanceDataSource>
								</xsl:for-each>
								<xsl:copy-of select="dataSources/masterDataSource"/>	
							</dataSources>
							<xsl:copy-of select="advanced"/>
						</complexExport>
					</xsl:for-each>
					<xsl:for-each select="outputOperations/exportModel/fullInstanceExport">
						<xsl:variable name="systemName" select="@sourceSystem"/>
						<xsl:variable name="UpperSystemName" select="//systems/system[lower-case(@name)=$systemName]/@name"/>
						<fullInstanceExport scope="{@scope}" allEntities="{@allEntities}" sourceSystem="{$UpperSystemName}" name="{@name}">
							<xsl:copy-of select="description"/>
							<xsl:copy-of select="selectedTables"/>
							<xsl:copy-of select="advanced"/>
						</fullInstanceExport>
					</xsl:for-each>
					<xsl:copy-of select="outputOperations/exportModel/fullMasterExport"/>					
				</exportModel>
				<xsl:copy-of select="outputOperations/eventHandler"/>				
			</outputOperations>
			<xsl:copy-of select="nativeServices"/>
			<xsl:copy-of select="advancedSettings"/>		
		</metadata>
	</xsl:template>
</xsl:stylesheet>
