<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl sf"> -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/metadata">
		<metadata>
			<settings scope="{settings/@scope}" enableRC="{settings/@enableRC}" deletionStrategy="{settings/@deletionStrategy}">
				<lengthValidation databaseType="{settings/lengthValidation/@databaseType}" nmePrefixLength="{settings/lengthValidation/@nmePrefixLength}"/>
				<advancedSettings expStringLength="{settings/advancedSettings/@expStringLength}" srcStringLength="{settings/advancedSettings/@srcStringLength}" alternativeKeys="{settings/advancedSettings/@alternativeKeys}" matchingCompatibility="{settings/advancedSettings/@matchingCompatibility}">
					<ignoredComparisonColumns>
						<xsl:for-each select="settings/advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn">
							<ignoredComparisonColumn allEntities="{@allEntities}" names="{@names}">
								<entities>
									<xsl:for-each select="entities/entity">
										<entity name="{@name}"/>
									</xsl:for-each>
								</entities>
							</ignoredComparisonColumn>
						</xsl:for-each>
					</ignoredComparisonColumns>
				</advancedSettings>
			</settings>
			<systems>
				<xsl:for-each select="systems/system">
					<system name="{@name}">
						<description><xsl:value-of select="description|@description"/></description>
						<model>
							<relationships>
								<xsl:for-each select="model/relationships/relationship">
									<relationship name="{@name}" parentTable="{lower-case(@parentTable)}" childTable="{lower-case(@childTable)}">
										<foreignKey>
											<xsl:for-each select="foreignKey/column">
												<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
											</xsl:for-each>
										</foreignKey>
									</relationship>
								</xsl:for-each>
							</relationships>
							<tables>
								<xsl:for-each select="model/tables/table">
									<table name="{@name}">
										<description><xsl:value-of select="description|@description"/></description>
										<columns>
											<xsl:for-each select="columns/column">
												<column description="{@description}" name="{@name}" type="{@type}"/>
											</xsl:for-each>									
										</columns>
									</table>
								</xsl:for-each>						
							</tables>
						</model>
						<sourceMappings>
							<xsl:for-each select="sourceMappings/mapping">
								<mapping entity="{lower-case(@entity)}" table="{lower-case(@table)}" customOrigin="{@customOrigin}">
									<description><xsl:value-of select="description|@description"/></description>
									<viewOrigin origin="{viewOrigin/@origin}"/>
								</mapping>
							</xsl:for-each>						
						</sourceMappings>
						<loadOperations>
							<xsl:for-each select="loadOperations/fullLoad">
								<fullLoad nameSuffix="{@nameSuffix}" allTables="{@allTables}">
									<selectedTables>
										<xsl:for-each select="selectedTables/table">
											<table name="{lower-case(@name)}"/>
										</xsl:for-each>
									</selectedTables>
									<advanced deletionStrategy="{advanced/@deletionStrategy}">
										<ignoredComparisonColumns>
											<xsl:for-each select="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
												<ignoredComparisonColumn allEntities="{@allEntities}" names="{@names}">
													<entities>
														<xsl:for-each select="entities/entity">
															<entity name="{lower-case(@name)}"/>
														</xsl:for-each>
													</entities>
												</ignoredComparisonColumn>
											</xsl:for-each>
										</ignoredComparisonColumns>
									</advanced>
								</fullLoad>
							</xsl:for-each>
							<xsl:for-each select="loadOperations/initialLoad">
								<initialLoad nameSuffix="{@nameSuffix}" allowLoad="{@allowLoad}" ignorePersistence="{@ignorePersistence}"/>
							</xsl:for-each>
							<xsl:for-each select="loadOperations/complexDeltaLoad">
								<complexDeltaLoad nameSuffix="{@nameSuffix}">
									<tableSettings>	
										<xsl:for-each select="tableSettings/table">
											<table keyColumn="{lower-case(@keyColumn)}" name="{lower-case(@name)}" mode="{lower-case(@mode)}"/>
										</xsl:for-each>
									</tableSettings>
									<advanced deletionStrategy="{advanced/@deletionStrategy}">
										<partitionedEntities>
											<xsl:for-each select="advanced/partitionedEntities/entity">
												<entity keyColumn="{@keyColumn}" name="{lower-case(@name)}" origin="{lower-case(@origin)}" mode="{lower-case(@mode)}"/>
											</xsl:for-each>
										</partitionedEntities>
										<ignoredComparisonColumns>
											<xsl:for-each select="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
												<ignoredComparisonColumn allEntities="{@ignoredComparisonColumn}" names="{@names}">
													<entities>
														<xsl:for-each select="entities/entity">
															<entity name="{lower-case(@name)}"/>
														</xsl:for-each>
													</entities>
												</ignoredComparisonColumn>
											</xsl:for-each>
										</ignoredComparisonColumns>
									</advanced>
								</complexDeltaLoad>
							</xsl:for-each>
							<xsl:for-each select="loadOperations/deltaLoad">
								<deltaLoad nameSuffix="{@nameSuffix}" allTables="{@allTables}">
									<selectedTables>
										<xsl:for-each select="selectedTables/table">
											<table name="{lower-case(@name)}"/>
										</xsl:for-each>
									</selectedTables>
									<advanced deletionStrategy="{advanced/@deletionStrategy}">
										<ignoredComparisonColumns>
											<xsl:for-each select="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
												<ignoredComparisonColumn allEntities="{@allEntities}" names="{@names}">
													<entities>
														<xsl:for-each select="entities/entity">
															<entity name="{lower-case(@name)}"/>
														</xsl:for-each>
													</entities>
												</ignoredComparisonColumn>
											</xsl:for-each>
										</ignoredComparisonColumns>
									</advanced>
								</deltaLoad>
							</xsl:for-each>
							<xsl:for-each select="loadOperations/directLoad">	
								<directLoad nameSuffix="{@nameSuffix}" allTables="{@allTables}">
									<advanced deletionStrategy="{advanced/@deletionStrategy}">
										<ignoredComparisonColumns>
											<xsl:for-each select="advanced/ignoredComparisonColumns/ignoredComparisonColumn">
												<ignoredComparisonColumn allEntities="{@allEntities}" names="{@names}">
													<entities>
														<xsl:for-each select="entities/entity">
															<entity name="{lower-case(@name)}"/>
														</xsl:for-each>
													</entities>
												</ignoredComparisonColumn>
											</xsl:for-each>
										</ignoredComparisonColumns>
									</advanced>								
								</directLoad>
							</xsl:for-each>
						</loadOperations>
					</system>
				</xsl:for-each>				
			</systems>
			<logicalModel>
				<instanceModel>
					<xsl:for-each select="logicalModel/instanceModel">
						<relationships>
							<xsl:for-each select="relationships/relationship">
								<relationship parentRole="{@parentRole}" name="{@name}" childRole="{@childRole}" type="{@type}" parentTable="{lower-case(@parentTable)}" childTable="{lower-case(@childTable)}">
									<description><xsl:value-of select="description|@description"/></description>
									<foreignKey>
										<xsl:for-each select="foreignKey/column">
											<column parentColumn="{lower-case(@parentColumn)}" childColumn="{lower-case(@childColumn)}"/>
										</xsl:for-each>
									</foreignKey>
									<parentToChild>
										<xsl:for-each select="parentToChild/column">
											<column source="{@source}" name="{@name}" type="{@type}" size="{@size}" createInto="{lower-case(@createInto)}">
												<filterExpression></filterExpression>
											</column>
										</xsl:for-each>
									</parentToChild>
									<childToParent>
										<xsl:for-each select="childToParent/column">
											<column source="{@source}" name="{@name}" method="{@method}" type="{@type}" separator="{@separator}" size="{@size}" createInto="{lower-case(@createInto)}">
												<filterExpression></filterExpression>
											</column>
										</xsl:for-each>
									</childToParent>
									<advanced>
										<alternativeKey alternativePk="{@alternativePk}" alternativeFk="{@alternativeFk}"/>
										<extendedSameSystem parentColumn="{@parentColumn}" enable="{@enable}" childColumn="{@childColumn}"/>
									</advanced>
								</relationship>
							</xsl:for-each>
						</relationships>
						<tables>
							<xsl:for-each select="tables/table">
								<table name="{@name}" type="{@type}">
									<description><xsl:value-of select="description|@description"/></description>
									<columns>
										<xsl:for-each select="columns/column">
											<column isPk="{@isPk}" label="{@label}" isSco="{@isSco}" type="{@type}" size="{@size}" isFk="{@isFk}" refData="{lower-case(@refData)}" isSrc="{@isSrc}" isExp="{@isExp}" name="{@name}" isStd="{@isStd}" isCio="{@isCio}">
												<description><xsl:value-of select="description|@description"/></description>
											</column>
										</xsl:for-each>
									</columns>
									<xsl:copy-of select="matchingTab"/>
									<aggregationTab aggregation="{aggregationTab/@aggregation}" groupingColumn="{aggregationTab/@groupingColumn}">
										<aggregationTabColumns>
											<xsl:for-each select="aggregationTab/aggregationTabColumns/aggregationTabColumn">
												<aggregationTabColumn name="{@name}" type="{@type}" size="{@size}">
													<description><xsl:value-of select="description|@description"/></description>
												</aggregationTabColumn>
											</xsl:for-each>
										</aggregationTabColumns>
									</aggregationTab>
									<advanced>
										<specialColumns>
											<xsl:for-each select="advanced/specialColumns/column">
												<column name="{@name}" type="{@type}" size="{@size}" createInto="{lower-case(@createInto)}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</specialColumns>
										<historicalColumns>
											<xsl:for-each select="advanced/historicalColumns/column">
												<column maxCnt="{@maxCnt}" name="{@name}" srcColumn="{lower-case(@srcColumn)}" separator="{@separator}" size="{@size}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</historicalColumns>
										<oldValueColumns>
											<xsl:for-each select="advanced/oldValueColumns/column">
												<column name="{@name}" srcColumn="{lower-case(@srcColumn)}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</oldValueColumns>
									</advanced>
								</table>							
							</xsl:for-each>
						</tables>
						<dicTables>
							<xsl:for-each select="dicTables/table">
								<table name="{@name}" type="{@type}">
									<description><xsl:value-of select="description|@description"/></description>
									<columns>
										<xsl:for-each select="columns/column">
											<column isFk="{@isFk}" isPk="{@isPk}" label="{@label}" type="{@type}" size="{@size}" name="{@name}">
												<description><xsl:value-of select="description|@description"/></description>
											</column>
										</xsl:for-each>
									</columns>
									<advanced>
										<specialColumns>
											<xsl:for-each select="advanced/specialColumns/column">
												<column name="{@name}" type="{@type}" size="{@size}" createInto="{@createInto}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</specialColumns>
										<historicalColumns>
											<xsl:for-each select="advanced/historicalColumns/column">
												<column maxCnt="{@maxCnt}" name="{@name}" srcColumn="{lower-case(@srcColumn)}" separator="{@separator}" size="{@size}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</historicalColumns>
										<oldValueColumns>
											<xsl:for-each select="advanced/oldValueColumns/column">
												<column name="{@name}" srcColumn="{lower-case(@srcColumn)}">
													<description><xsl:value-of select="description|@description"/></description>
												</column>
											</xsl:for-each>
										</oldValueColumns>
									</advanced>
								</table>	
							</xsl:for-each>
						</dicTables>	
					</xsl:for-each>						
				</instanceModel>
				<masterModels>
					<xsl:for-each select="logicalModel/masterModels/masterModel">
						<masterModel name="{@name}">
							<description><xsl:value-of select="description|@description"/></description>
							<relationships>
								<xsl:for-each select="relationships/relationship">	
									<relationship parentRole="{@parentRole}" name="{@name}" childRole="{@childRole}" label="{@label}" type="{@type}" parentTable="{lower-case(@parentTable)}" childTable="{lower-case(@childTable)}">
										<description><xsl:value-of select="description|@description"/></description>
										<foreignKey>
											<xsl:for-each select="foreignKey/column">
												<column parentColumn="{lower-case(@parentColumn)}" childColumn="{lower-case(@childColumn)}"/>
											</xsl:for-each>
										</foreignKey>
										<advanced ignoreRelGui="{@ignoreRelGui}">
											<extendedSameSystem parentColumn="{lower-case(@parentColumn)}" childColumn="{lower-case(@childColumn)}"/>
										</advanced>
									</relationship>
								</xsl:for-each>			
							</relationships>
							<masterTables>
								<xsl:for-each select="masterTables/masterTable">
									<masterTable name="{@name}" label="{@label}" entityRole="{@entityRole}" instanceTable="{lower-case(@instanceTable)}" topLevel="{@topLevel}">
										<description><xsl:value-of select="description|@description"/></description>
										<columns>
											<xsl:for-each select="columns/column">
												<column isCmo="{@isCmo}" refData="{lower-case(@refData)}" isPk="{@isPk}" isFk="{@isFk}" description="{@description}" name="{@name}" label="{@label}" type="{@type}" size="{@size}">
												</column>
											</xsl:for-each>
										</columns>
										<guiTab>
											<views>
												<xsl:for-each select="guiTab/views/detailView">
													<detailView>
														<groups>
															<xsl:for-each select="groups/labeledGroup">
																<labeledGroup templatePosition="{@templatePosition}" name="{@name}" label="{@label}">
																	<columns>
																		<xsl:for-each select="columns/column">
																			<column lookupType="{@lookupType}" name="{lower-case(@name)}" format="{@format}"/>
																		</xsl:for-each>
																	</columns>
																</labeledGroup>
															</xsl:for-each>
															<xsl:for-each select="groups/labeledRelatedList">
																<labeledRelatedList relationship="{lower-case(@relationship)}" templatePosition="{@templatePosition}" name="{lower-case(@name)}" label="{@label}">
																	<linkedRecordParams>
																		<firstColumnFormat><xsl:value-of select="linkedRecordParams/firstColumnFormat|linkedRecordParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="linkedRecordParams/secondColumnFormat|linkedRecordParams/@secondColumnFormat"/></secondColumnFormat>
																	</linkedRecordParams>
																</labeledRelatedList>
															</xsl:for-each>
															<xsl:for-each select="groups/labeledRelatedMNList">
																<labeledRelatedMNList relationship="{lower-case(@relationship)}" entity_out="{lower-case(@entity_out)}" templatePosition="{@templatePosition}" name="{@name}" relationship_out="{lower-case(@relationship_out)}" label="{@label}">
																	<MNrelationParams>
																		<firstColumnFormat><xsl:value-of select="MNrelationParams/firstColumnFormat|MNrelationParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="MNrelationParams/secondColumnFormat|MNrelationParams/@secondColumnFormat"/></secondColumnFormat>
																	</MNrelationParams>
																	<MNlinkedRecordsParams>
																		<firstColumnFormat><xsl:value-of select="MNrelationParams/firstColumnFormat|MNrelationParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="MNrelationParams/secondColumnFormat|MNrelationParams/@secondColumnFormat"/></secondColumnFormat>
																	</MNlinkedRecordsParams>
																</labeledRelatedMNList>	
															</xsl:for-each>		
															<xsl:for-each select="groups/listGrid">											
																<listGrid relationship="{lower-case(@relationship)}" templatePosition="{@templatePosition}" name="{@name}" label="{@label}">
																	<lists>
																		<xsl:for-each select="lists/list">
																			<list name="{lower-case(@name)}" label="{@label}" columnMask="{@columnMask}">
																				<columns>
																					<xsl:for-each select="columns/column">
																						<column name="{lower-case(@name)}"/>
																					</xsl:for-each>
																				</columns>
																			</list>
																		</xsl:for-each>
																	</lists>
																</listGrid>
															</xsl:for-each>
														</groups>
													</detailView>
												</xsl:for-each>
												<xsl:for-each select="guiTab/views/breadcrumbView">
													<breadcrumbView allColumns="{@allColumns}">
														<columns>
															<xsl:for-each select="columns/column">
																<column name="{lower-case(@name)}"/>
															</xsl:for-each>
														</columns>
													</breadcrumbView>
												</xsl:for-each>
											</views>
											<computedColumns>
												<xsl:for-each select="guiTab/computedColumns/column">
													<column dataType="{@dataType}" description="{@description}" name="{@name}" label="{@label}" searchable="{@searchable}">
														<producer><xsl:value-of select="producer|@producer"/></producer>
													</column>
												</xsl:for-each>
											</computedColumns>
										</guiTab>
										<advanced groupColumn="{lower-case(@groupColumn)}" customActivity="{@customActivity}">
											<xsl:copy-of select="advanced/inputFilterExpression"/>
											<xsl:copy-of select="advanced/specialColumns"/>
										</advanced>
										<guiEdit guiReadOnly="{guiEdit/@guiReadOnly}">
											<parentColumns>
												<xsl:for-each select="guiEdit/parentColumns/parentColumn">
													<parentColumn relationship="{lower-case(@relationship)}" name="{lower-case(@name)}"/>
												</xsl:for-each>
											</parentColumns>
											<editColumns>
												<xsl:for-each select="guiEdit/editColumns/column">
													<column nmeMapping="{lower-case(@nmeMapping)}" name="{lower-case(@name)}"/>
												</xsl:for-each>
											</editColumns>
										</guiEdit>
									</masterTable>
								</xsl:for-each>
							</masterTables>
							<instanceTables>
								<xsl:for-each select="instanceTables/instanceTable">
									<instanceTable name="{@name}" label="{@label}" instanceTable="{lower-case(@instanceTable)}" topLevel="{@topLevel}">
										<columns>
											<xsl:for-each select="columns/column">
												<column name="{@name}" customLabel="{@customLabel}">
												</column>
											</xsl:for-each>
										</columns>
										<guiTab>
											<views>
												<xsl:for-each select="guiTab/views/detailView">
													<detailView>
														<groups>
															<xsl:for-each select="groups/labeledGroup">
																<labeledGroup templatePosition="{@templatePosition}" name="{@name}" label="{@label}">
																	<columns>
																		<xsl:for-each select="columns/column">
																			<column lookupType="{@lookupType}" name="{lower-case(@name)}" format="{@format}"/>
																		</xsl:for-each>
																	</columns>
																</labeledGroup>
															</xsl:for-each>
															<xsl:for-each select="groups/labeledRelatedList">
																<labeledRelatedList relationship="{lower-case(@relationship)}" templatePosition="{@templatePosition}" name="{lower-case(@name)}" label="{@label}">
																	<linkedRecordParams>
																		<firstColumnFormat><xsl:value-of select="linkedRecordParams/firstColumnFormat|linkedRecordParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="linkedRecordParams/secondColumnFormat|linkedRecordParams/@secondColumnFormat"/></secondColumnFormat>
																	</linkedRecordParams>
																</labeledRelatedList>
															</xsl:for-each>
															<xsl:for-each select="groups/labeledRelatedMNList">
																<labeledRelatedMNList relationship="{lower-case(@relationship)}" entity_out="{lower-case(@entity_out)}" templatePosition="{@templatePosition}" name="{@name}" relationship_out="{lower-case(@relationship_out)}" label="{@label}">
																	<MNrelationParams>
																		<firstColumnFormat><xsl:value-of select="MNrelationParams/firstColumnFormat|MNrelationParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="MNrelationParams/secondColumnFormat|MNrelationParams/@secondColumnFormat"/></secondColumnFormat>
																	</MNrelationParams>
																	<MNlinkedRecordsParams>
																		<firstColumnFormat><xsl:value-of select="MNrelationParams/firstColumnFormat|MNrelationParams/@firstColumnFormat"/></firstColumnFormat>
																		<secondColumnFormat><xsl:value-of select="MNrelationParams/secondColumnFormat|MNrelationParams/@secondColumnFormat"/></secondColumnFormat>
																	</MNlinkedRecordsParams>
																</labeledRelatedMNList>	
															</xsl:for-each>		
															<xsl:for-each select="groups/listGrid">											
																<listGrid relationship="{lower-case(@relationship)}" templatePosition="{@templatePosition}" name="{@name}" label="{@label}">
																	<lists>
																		<xsl:for-each select="lists/list">
																			<list name="{lower-case(@name)}" label="{@label}" columnMask="{@columnMask}">
																				<columns>
																					<xsl:for-each select="columns/column">
																						<column name="{lower-case(@name)}"/>
																					</xsl:for-each>
																				</columns>
																			</list>
																		</xsl:for-each>
																	</lists>
																</listGrid>
															</xsl:for-each>
														</groups>
													</detailView>
												</xsl:for-each>
												<xsl:for-each select="guiTab/views/breadcrumbView">
													<breadcrumbView allColumns="{@allColumns}">
														<columns>
															<xsl:for-each select="columns/column">
																<column name="{lower-case(@name)}"/>
															</xsl:for-each>
														</columns>
													</breadcrumbView>
												</xsl:for-each>
											</views>
											<computedColumns>
												<xsl:for-each select="computedColumns/column">
													<column dataType="{@dataType}" description="{@description}" name="{@name}" label="{@label}" searchable="{@searchable}">
														<producer><xsl:value-of select="producer|@producer"/></producer>
													</column>
												</xsl:for-each>
											</computedColumns>
										</guiTab>				
									</instanceTable>
								</xsl:for-each>
							</instanceTables>
							<xsl:copy-of select="guiConfig"/>
						</masterModel>
					</xsl:for-each>
				</masterModels>
				<dictionary>
					<tables>
						<xsl:for-each select="logicalModel/dictionary/tables/table">
							<table instUse="{@instUse}" sourceCodeType="{@sourceCodeType}" masterCodeType="{@masterCodeType}" usageValidation="{@usageValidation}" name="{@name}" loadInst="{@loadInst}" label="{@label}" loadMas="{@loadMas}">
								<description><xsl:value-of select="description|@description"/></description>
								<columns>
									<xsl:for-each select="columns/column">
										<column name="{@name}" label="{@label}" type="{@type}" instance="{@instance}" master="{@master}" size="{@size}">
											<comment><xsl:value-of select="comment|@comment"/></comment>
										</column>
									</xsl:for-each>
								</columns>
								<lookupSettings substituteWith="{lookupSettings/@substituteWith}" removeRepeatedChars="{lookupSettings/@removeRepeatedChars}" duplicities="{lookupSettings/@duplicities}" supportedChars="{lookupSettings/@supportedChars}" squeezeWS="{lookupSettings/@squeezeWS}" bestDistanceIndex="{lookupSettings/@bestDistanceIndex}" upperCase="{lookupSettings/@upperCase}" removeAccents="{lookupSettings/@removeAccents}" bidirectApproxIndex="{lookupSettings/@bidirectApproxIndex}" approxIndex="{lookupSettings/@approxIndex}"/>
							</table>
						</xsl:for-each>						
					</tables>
				</dictionary>			
			</logicalModel>
			<outputOperations>
				<exportModel>
					<xsl:for-each select="outputOperations/exportModel/fullInstanceExport">
						<fullInstanceExport scope="{@scope}" allEntities="{@allEntities}" sourceSystem="{lower-case(@sourceSystem)}" name="{@name}">
							<description><xsl:value-of select="description|@description"/></description>
							<selectedTables>
								<xsl:for-each select="selectedTables/instanceTable">
									<instanceTable allColumns="{@allColumns}" name="{lower-case(@name)}">
										<columns>
											<xsl:for-each select="columns/column">
												<column name="{lower-case(@name)}"/>
											</xsl:for-each>
										</columns>
									</instanceTable>
								</xsl:for-each>
							</selectedTables>
						</fullInstanceExport>
					</xsl:for-each>
					<xsl:for-each select="outputOperations/exportModel/fullMasterExport">
						<fullMasterExport scope="{@scope}" allEntities="{@allEntities}" name="{@name}" layerName="{lower-case(@layerName)}">
							<description><xsl:value-of select="description|@description"/></description>
							<selectedTables>
								<xsl:for-each select="selectedTables/table">
									<table allColumns="{@allColumns}" name="{lower-case(@name)}">
										<columns>
											<xsl:for-each select="columns/column">
												<column name="{lower-case(@name)}"/>
											</xsl:for-each>
										</columns>
									</table>
								</xsl:for-each>
							</selectedTables>
						</fullMasterExport>					
					</xsl:for-each>
					<xsl:for-each select="outputOperations/exportModel/complexExport">
						<complexExport scope="{@scope}" name="{@name}">
							<description><xsl:value-of select="description|@description"/></description>
							<dataSources>
								<xsl:for-each select="dataSources/instanceDataSource">
									<instanceDataSource scope="{@scope}" allEntities="{@allEntities}" sourceSystem="{lower-case(@sourceSystem)}" prefix="{@prefix}" mode="{@mode}">
										<selectedTables>
											<xsl:for-each select="selectedTables/instanceTable">
												<instanceTable allColumns="{@allColumns}" name="{lower-case(@name)}">
													<columns>
														<xsl:for-each select="columns/column">
															<column name="{lower-case(@name)}"/>
														</xsl:for-each>														
													</columns>
												</instanceTable>
											</xsl:for-each>
										</selectedTables>
									</instanceDataSource>
								</xsl:for-each>
								<xsl:for-each select="dataSources/masterDataSource">
									<masterDataSource scope="{@scope}" allEntities="{@allEntities}" prefix="{@prefix}" layerName="{lower-case(@layerName)}" mode="{@mode}">
										<selectedTables>
											<xsl:for-each select="selectedTables/table">
												<table allColumns="{@allColumns}" name="{lower-case(@name)}">
													<columns>
														<xsl:for-each select="columns/column">
															<column name="{lower-case(@name)}"/>
														</xsl:for-each>													
													</columns>
												</table>
											</xsl:for-each>
										</selectedTables>
									</masterDataSource>
								</xsl:for-each>
								<xsl:for-each select="dataSources/conditionalInstanceDataSource">
									<conditionalInstanceDataSource scope="{@scope}" sourceSystem="{lower-case(@sourceSystem)}" allColumns="{@allColumns}" prefix="{@prefix}" mode="{@mode}" entityName="{lower-case(@entityName)}">
										<conditions>
											<xsl:for-each select="conditions/condition">
												<condition value="{@value}" column="{lower-case(@column)}" operator="{@operator}">
													<description><xsl:value-of select="description|@description"/></description>
												</condition>
											</xsl:for-each>
										</conditions>
										<columns>
											<xsl:for-each select="columns/column">
												<column name="{lower-case(@name)}"/>
											</xsl:for-each>
										</columns>
									</conditionalInstanceDataSource>
								</xsl:for-each>
								<xsl:for-each select="dataSources/conditionalMasterDataSource">
									<conditionalMasterDataSource scope="{@scope}" layerName="{lower-case(@layerName)}" allColumns="{@allColumns}" prefix="{@prefix}" mode="{@mode}" entityName="{lower-case(@entityName)}">
										<conditions>
											<xsl:for-each select="conditions/condition">
												<condition value="{@value}" column="{lower-case(@column)}" operator="{@operator}">
													<description><xsl:value-of select="description|@description"/></description>
												</condition>
											</xsl:for-each>
										</conditions>
										<columns>
											<xsl:for-each select="columns/column">
												<column name="{lower-case(@name)}"/>
											</xsl:for-each>
										</columns>
									</conditionalMasterDataSource>
								</xsl:for-each>
								<xsl:for-each select="dataSources/historyInstanceEntityDataSource">		
									<historyInstanceEntityDataSource sourceSystem="{lower-case(@sourceSystem)}" allColumns="{@allColumns}" prefix="{@prefix}" entity="{lower-case(@entity)}">
										<historyInstanceColumns>
											<xsl:for-each select="historyInstanceColumns/historyInstanceColumn">
												<historyInstanceColumn name="{lower-case(@name)}"/>
											</xsl:for-each>
										</historyInstanceColumns>										
									</historyInstanceEntityDataSource>
								</xsl:for-each>
								<xsl:for-each select="dataSources/historyMasterEntityDataSource">
									<historyMasterEntityDataSource allColumns="{@allColumns}" prefix="{@prefix}" entity="{lower-case(@entity)}">
										<historyMasterColumns>
											<xsl:for-each select="historyMasterColumns/historyMasterColumn">
												<historyMasterColumn name="{lower-case(@name)}"/>
											</xsl:for-each>
										</historyMasterColumns>
									</historyMasterEntityDataSource>
								</xsl:for-each>
							</dataSources>
						</complexExport>
					</xsl:for-each>
				</exportModel>
				<eventHandler>
					<handlers>
						<xsl:for-each select="outputOperations/eventHandler/handlers/handler">
							<handler desc="{@desc}" persistenceDir="{@persistenceDir}" enable="{@enable}" class="{@class}">
								<publishers>
									<xsl:for-each select="publishers/stdOutPublisher">
										<stdOutPublisher enable="{@enable}">
											<description><xsl:value-of select="description|@description"/></description>
											<transformers>
												<simpleXmlTransformer includeOldValues="{transformers/simpleXmlTransformer/@includeOldValues}" indent="{transformers/simpleXmlTransformer/@indent}" name="{transformers/simpleXmlTransformer/@name}"/>
											</transformers>
											<advanced>
												<filteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/@expression|advanced/filteringPublisher/expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{lower-case(@name)}">
																<expression><xsl:value-of select="expression|@expression"/></expression>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
										</stdOutPublisher>
									</xsl:for-each>
									<xsl:for-each select="publishers/jmsPublisher">
										<jmsPublisher enable="{@enable}" contentType="{@contentType}" connectionName="{@connectionName}" destination="{@destination}">
											<description><xsl:value-of select="description|@description"/></description>
											<headers>
												<xsl:for-each select="headers/header">
													<header name="{@name}" value="{@value}" type="{@type}"/>
												</xsl:for-each>
											</headers>
											<transformers>
												<xsl:for-each select="transformers/expressionTemplateTransformer">
													<expressionTemplateTransformer name="{@name}" entityName="{lower-case(@entityName)}">
														<template><xsl:value-of select="template"/></template>
													</expressionTemplateTransformer>
												</xsl:for-each>
											</transformers>
											<advanced>
												<filteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{lower-case(@name)}">
																<expression><xsl:value-of select="expression|@expression"/></expression>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
										</jmsPublisher>										
									</xsl:for-each>			
									<xsl:for-each select="publishers/httpSoapPublisher">
										<httpSoapPublisher urlResourceName="{@urlResourceName}" soapAction="{@soapAction}" encoding="{@encoding}" enable="{@enable}" soapVersion="{@soapVersion}" delay="{@delay}" timeout="{@timeout}">
											<description><xsl:value-of select="description|@description"/></description>
											<advanced>
												<filteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{lower-case(@name)}">
																<expression><xsl:value-of select="expression|@expression"/></expression>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
											<transformers>
												<xsl:for-each select="transformers/expressionTemplateTransformer">
													<expressionTemplateTransformer name="{@name}" entityName="{lower-case(@entityName)}">
														<template><xsl:value-of select="template"/></template>
													</expressionTemplateTransformer>
												</xsl:for-each>
											</transformers>
										</httpSoapPublisher>
									</xsl:for-each>		
									<xsl:for-each select="publishers/eventSqlPublisher">
										<eventSqlPublisher dataSource="{@dataSource}" enable="{@enable}">
											<description><xsl:value-of select="description|@description"/></description>
											<sqlTemplates>
												<xsl:for-each select="sqlTemplates/template">
													<template name="{lower-case(@name)}">
														<template><xsl:value-of select="template|@template"/></template>
													</template>
												</xsl:for-each>
											</sqlTemplates>
											<advanced>
												<filteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{lower-case(@name)}">
																<expression><xsl:value-of select="expression|@expression"/></expression>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
										</eventSqlPublisher>										
									</xsl:for-each>		
									<xsl:for-each select="publishers/ismPublisher">
										<ismPublisher port="{@port}" host="{@host}" targetSystem="{@targetSystem}" enable="{@enable}">
											<description><xsl:value-of select="description|@description"/></description>
											<advanced>
												<filteringPublisher filter="advanced/filteringPublisher/@filter">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{lower-case(@name)}">
																<expression><xsl:value-of select="expression|@expression"/></expression>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
										</ismPublisher>
									</xsl:for-each>		
									<xsl:for-each select="publishers/eventPlanPublisher">
										<eventPlanPublisher enable="{@enable}" layerName="{lower-case(@layerName)}">
											<description><xsl:value-of select="description|@description"/></description>
											<planAdvancedSettings>
												<planFilteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression|advanced/filteringPublisher/@expression"/></expression>
												</planFilteringPublisher>
												<retryingPublisher maxRetries="{@maxRetries}" consecutiveSuccess="{@consecutiveSuccess}" retryDelay="{@retryDelay}" retry="{@retry}" globalRetries="{@globalRetries}"/>
											</planAdvancedSettings>
											<entityName allColumns="{entityName/@allColumns}" entity="{lower-case(entityName/@entity)}"/>
											<columnsMeta>
												<xsl:for-each select="columnsMeta/columnMeta">
													<columnMeta name="{@name}"/>
												</xsl:for-each>
											</columnsMeta>
											<columns>
												<xsl:for-each select="columns/column">
													<column old="{lower-case(@old)}" new="{lower-case(@new)}" name="{lower-case(@name)}"/>
												</xsl:for-each>
											</columns>
										</eventPlanPublisher>									
									</xsl:for-each>
								</publishers>	
								<filter>
									<expression><xsl:value-of select="filter/expression|filter/@expression"/></expression>
									<entities>
										<xsl:for-each select="filter/entities/entity">
											<entity name="{lower-case(@name)}">
												<expression><xsl:value-of select="expression|@expression"/></expression>
											</entity>
										</xsl:for-each>
									</entities>
								</filter>						
							</handler>
						</xsl:for-each>
					</handlers>				
				</eventHandler>
			</outputOperations>
			<nativeServices>
				<xsl:copy-of select="//nativeServices/basicServices"/>
				<configurableServices>
					<xsl:for-each select="nativeServices/configurableServices/identify">
						<identify desc="{@desc}" name="{@name}" masterLayer="{lower-case(@masterLayer)}" entity="{lower-case(@entity)}" enable="{@enable}"/>
					</xsl:for-each>					
					<xsl:for-each select="nativeServices/configurableServices/processUpsert">
						<processUpsert system="{lower-case(@system)}" desc="{@desc}" entity="{lower-case(@entity)}" enable="{@enable}"/>
					</xsl:for-each>
					<xsl:for-each select="nativeServices/configurableServices/processDeltaAdv">
						<processDeltaAdv desc="{@desc}" name="{@name}" enable="{@enable}">
							<partialTables>
								<xsl:for-each select="partialTables/partialTable">
									<partialTable name="{lower-case(@name)}">
										<partialColumns>
											<xsl:for-each select="partialColumns/partialColumn">
												<partialColumn name="{lower-case(@name)}"/>
											</xsl:for-each>
										</partialColumns>
									</partialTable>
								</xsl:for-each>
							</partialTables>
							<dependencySettings deletionStrategy="{dependencySettings/@deletionStrategy}">
								<tableSettings>
									<xsl:for-each select="dependencySettings/tableSettings/table">
										<table keyColumn="{lower-case(@keyColumn)}" name="{lower-case(@name)}" mode="{@mode}">
											<partialColumns>
												<xsl:for-each select="partialColumns/partialColumn">
													<partialColumn name="{lower-case(@name)}"/>
												</xsl:for-each>
											</partialColumns>
										</table>
									</xsl:for-each>									
								</tableSettings>
							</dependencySettings>
						</processDeltaAdv>
					</xsl:for-each>
				</configurableServices>
				<xsl:copy-of select="nativeServices/endpointsDefinition"/>
			</nativeServices>
			<advancedSettings>
				<xsl:copy-of select="advancedSettings/taskInfoExport"/>
				<reprocessSettings>
					<reprocess>
						<xsl:for-each select="advancedSettings/reprocessSettings/reprocess/full">
							<full plan="{@plan}" rematchAll="{@rematchAll}" ignorePersistence="{@ignorePersistence}" allTables="{@allTables}">
								<description><xsl:value-of select="description|@description"/></description>
								<entities>
									<xsl:for-each select="entities/entity">
										<entity name="{lower-case(@name)}"/>
									</xsl:for-each>
								</entities>
							</full>
						</xsl:for-each>
						<xsl:for-each select="advancedSettings/reprocessSettings/reprocess/partial">
							<partial recordId="{@recordId}" plan="{@plan}" enableRematch="{@enableRematch}" allTables="{@allTables}">
								<description><xsl:value-of select="description|@description"/></description>
								<entities>
									<xsl:for-each select="entities/entity">
										<entity name="{lower-case(@name)}" enableRematch="{@enableRematch}" />
									</xsl:for-each>
								</entities>
							</partial>
						</xsl:for-each>
					</reprocess>
				</reprocessSettings>
				<historyPlugin enable="{advancedSettings/historyPlugin/@enable}">
					<instanceTables>
						<xsl:for-each select="advancedSettings/historyPlugin/instanceTables/instanceTable">
							<instanceTable allColumns="{@allColumns}" entityName="{lower-case(@entityName)}">
								<instanceColumns>
									<xsl:for-each select="instanceColumns/instanceColumn[@name!='id']">
										<instanceColumn trace="{@trace}" name="{lower-case(@name)}" searchable="{@searchable}"/>
									</xsl:for-each>
								</instanceColumns>
							</instanceTable>
						</xsl:for-each>
					</instanceTables>
					<masterTables>
						<xsl:for-each select="advancedSettings/historyPlugin/masterTables/masterTable">
							<masterTable allColumns="{@allColumns}" entityName="{lower-case(@entityName)}">
								<masterColumns>
									<xsl:for-each select="masterColumns/masterColumn[@name!='id']">
										<masterColumn trace="{@trace}" name="{lower-case(@name)}" searchable="{@searchable}"/>
									</xsl:for-each>								
								</masterColumns>
							</masterTable>
						</xsl:for-each>
					</masterTables>
					<referenceDataTables>
						<xsl:for-each select="advancedSettings/historyPlugin/referenceDataTables/referenceDataTable">
							<referenceDataTable allColumns="{@allColumns}" entityName="{lower-case(@entityName)}">
								<referenceDataColumns>
									<xsl:for-each select="referenceDataColumns/referenceDataColumn[@name!='id']">
										<referenceDataColumn trace="{@trace}" name="{lower-case(@name)}" searchable="{@searchable}"/>
									</xsl:for-each>								
								</referenceDataColumns>
							</referenceDataTable>
						</xsl:for-each>
					</referenceDataTables>
				</historyPlugin>
				<migration>
					<migrationExport migExport="{advancedSettings/migration/migrationExport/@migExport}"/>
					<migrationLoad loadMatch="{advancedSettings/migration/migrationLoad/@loadMatch}" loadId="{advancedSettings/migration/migrationLoad/@loadId}" migLoad="{advancedSettings/migration/migrationLoad/@migLoad}" loadEng="{advancedSettings/migration/migrationLoad/@loadEng}" loadHist="{advancedSettings/migration/migrationLoad/@loadHist}">
						<selectedMatchingColumns>
							<xsl:for-each select="advancedSettings/migration/migrationLoad/selectedMatchingColumns/selectedMatchingColumn">
								<selectedMatchingColumn allEntities="{@allEntities}" name="{lower-case(@name)}">
									<selectedEntities>
										<xsl:for-each select="selectedEntities/selectedEntity">
											<selectedEntity name="{lower-case(@name)}"/>
										</xsl:for-each>
									</selectedEntities>
								</selectedMatchingColumn>
							</xsl:for-each>
						</selectedMatchingColumns>
					</migrationLoad>
				</migration>
			</advancedSettings>
		</metadata>
	</xsl:template>
</xsl:stylesheet>
