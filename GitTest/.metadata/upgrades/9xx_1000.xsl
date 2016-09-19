<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/metadata">
		<!-- <xsl:copy-of select="//metadata"/> -->
		<metadata>	
			<!--  <xsl:copy-of select="/metadata/settings"/> -->
			<xsl:for-each select="/metadata/settings">			
				<settings scope="{@scope}" deletionStrategy="{@deletionStrategy}" enableRC="false">
					<advancedSettings expStringLength="{advancedSettings/@expStringLength}" srcStringLength="{advancedSettings/@srcStringLength}" alternativeKeys="{advancedSettings/@alternativeKeys}" matchingCompatibility="true" >
						<ignoredComparisonColumns>
							<xsl:for-each select="advancedSettings/ignoredComparisonColumns/ignoredComparisonColumn">
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
					<lengthValidation nmePrefixLength="{lengthValidation/@nmePrefixLength}">
						<xsl:attribute name="databaseType">
							<xsl:choose>
								<xsl:when test="lengthValidation/@databaseType='Oracle'"> 
									<xsl:text>Oracle R9+</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="lengthValidation/@databaseType"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>					
					</lengthValidation>					
				</settings>	
			</xsl:for-each>
			<xsl:copy-of select="//systems"/>
			<logicalModel>
			 	<instanceModel>
					<relationships>
						<xsl:for-each select="logicalModel/instanceModel/relationships/relationship">
							<relationship parentRole="{@parentRole}" name="{@name}"  childRole="{@childRole}" parentTable="{@parentTable}" childTable="{@childTable}">
								<description><xsl:value-of select="description|@description"/></description>
								<foreignKey>
								<xsl:for-each select="foreignKey/column">
									<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
								</xsl:for-each>
								</foreignKey>
								<parentToChild>
									<xsl:for-each select="parentToChild/column">
									<column source="{@source}" name="{@name}" type="{@type}" size="{@size}" createInto="{@createInto}">
										<filterExpression><xsl:value-of select="filterExpression|@filterExpression"/></filterExpression>
									</column>
									</xsl:for-each>
								</parentToChild>
								<childToParent>
									<xsl:for-each select="childToParent/column">
									<column source="{@source}" name="{@name}" method="{@method}" type="{@type}" separator="{@separator}" size="{@size}" createInto="{@createInto}">
										<filterExpression><xsl:value-of select="filterExpression|@filterExpression"/></filterExpression>
									</column>
									</xsl:for-each>
								</childToParent>	
								<advanced>
									<alternativeKey alternativePk="{alternativeKey/@alternativePk}" alternativeFk="{alternativeKey/@alternativeFk}"/>
								</advanced>
							</relationship>
						</xsl:for-each>
					</relationships>
					<tables>
						<xsl:for-each select="logicalModel/instanceModel/tables/table">
							<table name="{@name}" type="{@type}">
								<description><xsl:value-of select="description|@description"/></description>
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" label="{@label}" isSco="{@isSco}" type="{@type}" size="{@size}" isFk="{@isFk}" refData="{@refData}" isSrc="{@isSrc}" isExp="{@isExp}" name="{@name}" isStd="{@isStd}" isCio="{@isCio}">
											<description><xsl:value-of select="description|@description"/></description>
											<!--  <generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/> -->
										</column>
									</xsl:for-each>
								</columns>
								<matchingTab enableIdentify="{matchingTab/@enableIdentify}" matching="{matchingTab/@matching}">
									<matchingTabColumns>
										<xsl:for-each select="matchingTab/matchingTabColumns/column">
											<column name="{@name}" type="{@type}" size="{@size}">
												<description><xsl:value-of select="description|@description"/></description>
												<!--  <generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/> -->
											</column>
										</xsl:for-each>
									</matchingTabColumns>
								</matchingTab>
								<advanced>
									<specialColumns>
										<xsl:for-each select="advanced/specialColumns/column">
											<column name="{@name}" type="{@type}" size="{@size}" createInto="{@createInto}">
												<description><xsl:value-of select="description|@description"/></description>
												<!-- <generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/>  -->
											</column>
										</xsl:for-each>
									</specialColumns>
									<historicalColumns>
										<xsl:for-each select="advanced/historicalColumns/column">
											<column maxCnt="{@maxCnt}" name="{@name}" srcColumn="{@srcColumn}" separator="{@separator}" size="{@size}">
												<description><xsl:value-of select="description|@description"/></description>
											</column>
										</xsl:for-each>
									</historicalColumns>
									<oldValueColumns>
										<xsl:for-each select="advanced/oldValueColumns/column">
										<column name="{@name}" srcColumn="{@srcColumn}">
											<description><xsl:value-of select="description|@description"/></description>
										</column>
										</xsl:for-each>
									</oldValueColumns>								
								</advanced>
								<!-- <maxLength maxInstTableLength="{@maxInstTableLength}" maxColumnLength="{@maxColumnLength}"/> -->
								<pkValue valuepk="{@valuepk}"/>			
							</table>
						</xsl:for-each>
					</tables>
					<dicTables>
						<xsl:for-each select="logicalModel/instanceModel/dicTables/table">
							<table name="{@name}" type="{@type}">
								<description><xsl:value-of select="description|@description"/></description>
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" isFk="{@isFk}" name="{@name}" label="{@label}" type="{@type}" size="{@size}">
											<description><xsl:value-of select="description|@description"/></description>
											<!-- <generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/> -->
										</column>
									</xsl:for-each>
								</columns>
								<advanced>
									<specialColumns>
										<xsl:for-each select="advanced/specialColumns/column">
											<column name="{@name}" type="{@type}" size="{@size}" createInto="{@createInto}">
												<description><xsl:value-of select="description|@description"/></description>
												 <!-- <generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/> -->
											</column>
										</xsl:for-each>
									</specialColumns>
									<xsl:copy-of select="historicalColumns"/>
									<oldValueColumns>
										<xsl:for-each select="advanced/oldValueColumns/column">
										<column name="{@name}" srcColumn="{@srcColumn}">
											<description><xsl:value-of select="description|@description"/></description>
										</column>
										</xsl:for-each>
									</oldValueColumns>								
								</advanced>	
							</table>
						</xsl:for-each>				
					</dicTables>
			 	</instanceModel>
			 	<masterModels>
			 		<xsl:for-each select="logicalModel/masterModels/masterModel">
						<masterModel name="{@name}" >
							<description><xsl:value-of select="description|@description"/></description>
				 			<relationships>
							<xsl:for-each select="relationships/relationship">
								<relationship parentRole="{@parentRole}" name="{@name}" childRole="{@childRole}" label="{@label}" type="{@type}" parentTable="{@parentTable}" childTable="{@childTable}">
									<description><xsl:value-of select="description|@description"/></description>
									<foreignKey>
										<xsl:for-each select="foreignKey/column">
											<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
										</xsl:for-each>
									</foreignKey>
									<advanced>
										<xsl:for-each select="advanced/extendedSameSystem">
											<extendedSameSystem parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
										</xsl:for-each>
									</advanced>
								</relationship>
							</xsl:for-each>
							</relationships>
							<masterTables>
								<xsl:for-each select="masterTables/masterTable">
								<masterTable name="{@name}" label="{@label}" entityRole="{@entityRole}" instanceTable="{@instanceTable}" topLevel="{@topLevel}" >
									<description><xsl:value-of select="description|@description"/></description>									
									<columns>
										<xsl:for-each select="columns/column">
											<column isCmo="{@isCmo}" refData="{@refData}" isPk="{@isPk}" isFk="{@isFk}" description="{@description}" name="{@name}" label="{@label}" type="{@type}" size="{@size}">
												<!-- <generatedColumnMaxLength maxColumnLength="{generatedColumnMaxLength/@maxColumnLength}"/> -->
											</column>
										</xsl:for-each>	
									</columns>
									<!-- 
									<guiTab>
										<views>
											<xsl:for-each select="guiTab/views/detailView">
												<detailView>
													<groups>
														<xsl:for-each select="groups/labeledRelatedList">
															<labeledRelatedList relationship="address_has_instance" columnLabel="address_single_line" name="sd" elemId="11614148" columnName="address_label" label="sd">
																<relatedEntity bridged="" name="" rel="" debug=""/>
															</labeledRelatedList>														
														</xsl:for-each>
																										
														<xsl:for-each select="groups/listGrid">
															<listGrid relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</listGrid>	
														</xsl:for-each>	
																									
														<xsl:for-each select="groups/labeledGroup">
															<labeledGroup name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
															</labeledGroup>
														</xsl:for-each>
													</groups>
												</detailView>											
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/breadcrumView">
												<breadcrumbView allColumns="{@allColumns}">
													<columns>
														<xsl:for-each select="columns/column">
															<column name="{@name}"/>
														</xsl:for-each>
													</columns>
												</breadcrumbView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/editMnDetailView">
												<editMnDetailView>
													<groups>
														<xsl:for-each select="groups/labeledRelatedList">
															<labeledRelatedList relationship="address_has_instance" columnLabel="address_single_line" name="sd" elemId="11614148" columnName="address_label" label="sd">
																<relatedEntity bridged="" name="" rel="" debug=""/>
															</labeledRelatedList>
														</xsl:for-each>
														
														<xsl:for-each select="groups/listGrid">
															<listGrid relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</listGrid>	
														</xsl:for-each>	
																									
														<xsl:for-each select="groups/labeledGroup">
															<labeledGroup name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
															</labeledGroup>
														</xsl:for-each>
													</groups>
												</editMnDetailView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/editView">	
												<editView>
													<groups>
														<xsl:for-each select="groups/basicForm">
															<basicForm name="{@name}" label="{@label}">
																<columns>
																	<column name="{@name}" defaultValue="{@defaultValue}"/>
																</columns>
															</basicForm>
														</xsl:for-each>
														
														<xsl:for-each select="groups/childRelation">
															<childRelation relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</childRelation>
														</xsl:for-each>
														
														<xsl:for-each select="groups/mnRelation">
															<mnRelation relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</mnRelation>
														</xsl:for-each>
														
													</groups>
												</editView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/cartView">
												<cartView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</cartView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/gridView">
												<gridView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</gridView>
											</xsl:for-each>
												
											<xsl:for-each select="guiTab/views/historyView">	
												<historyView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</historyView>
											</xsl:for-each>	
										</views>
										<computedColumns/>
										<mnRelationships/>
									</guiTab>
									 -->							
									<advanced customActivity="{@customActivity}">
										<inputFilterExpression><xsl:value-of select="inputFilterExpression"/></inputFilterExpression>
										<specialColumns>
											<xsl:for-each select="advanced/specialColumns/column">
											<column name="{@name}" label="{@label}" type="{@type}" size="{@size}">
												<description><xsl:value-of select="description|@description"/></description>
												<generatedColumnMaxLength maxColumnLength="{@maxColumnLength}"/>
											</column>
											</xsl:for-each>
										</specialColumns>
									</advanced>	
								
									
									<!-- <guiEdit>
										<parentColumns>
											<xsl:for-each select="guiEdit/parentColumns/parentColumn">
												<parentColumn relationship="{@relationship}" name="{@name}"/>
											</xsl:for-each>
										</parentColumns>
										<editColumns>
											<xsl:for-each select="guiEdit/editColumns/column">
												<column nmeMapping="{@nmeMapping}" name="{@name}"/>
											</xsl:for-each>
										</editColumns>
									</guiEdit> -->
								</masterTable>
								</xsl:for-each>
							</masterTables>	
							<instanceTables>
								<xsl:for-each select="instanceTables/instanceTable">
								<instanceTable name="{@name}" label="{@label}" instanceTable="{@instanceTable}" topLevel="{@topLevel}">
									<!-- 
									<guiTab>
										<views>
											<xsl:for-each select="guiTab/views/detailView">
												<detailView>
													<groups>
														<xsl:for-each select="groups/labeledRelatedList">
															<labeledRelatedList relationship="address_has_instance" columnLabel="address_single_line" name="sd" elemId="11614148" columnName="address_label" label="sd">
																<relatedEntity bridged="" name="" rel="" debug=""/>
															</labeledRelatedList>														
														</xsl:for-each>
																										
														<xsl:for-each select="groups/listGrid">
															<listGrid relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</listGrid>	
														</xsl:for-each>	
																									
														<xsl:for-each select="groups/labeledGroup">
															<labeledGroup name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
															</labeledGroup>
														</xsl:for-each>
													</groups>
												</detailView>											
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/breadcrumView">
												<breadcrumbView allColumns="{@allColumns}">
													<columns>
														<xsl:for-each select="columns/column">
															<column name="{@name}"/>
														</xsl:for-each>
													</columns>
												</breadcrumbView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/editMnDetailView">
												<editMnDetailView>
													<groups>
														<xsl:for-each select="groups/labeledRelatedList">
															<labeledRelatedList relationship="address_has_instance" columnLabel="address_single_line" name="sd" elemId="11614148" columnName="address_label" label="sd">
																<relatedEntity bridged="" name="" rel="" debug=""/>
															</labeledRelatedList>
														</xsl:for-each>
														
														<xsl:for-each select="groups/listGrid">
															<listGrid relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</listGrid>	
														</xsl:for-each>	
																									
														<xsl:for-each select="groups/labeledGroup">
															<labeledGroup name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
															</labeledGroup>
														</xsl:for-each>
													</groups>
												</editMnDetailView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/editView">	
												<editView>
													<groups>
														<xsl:for-each select="groups/basicForm">
															<basicForm name="{@name}" label="{@label}">
																<columns>
																	<column name="{@name}" defaultValue="{@defaultValue}"/>
																</columns>
															</basicForm>
														</xsl:for-each>
														
														<xsl:for-each select="groups/childRelation">
															<childRelation relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</childRelation>
														</xsl:for-each>
														
														<xsl:for-each select="groups/mnRelation">
															<mnRelation relationship="{@relationship}" name="{@name}" label="{@label}">
																<columns>
																	<xsl:for-each select="columns/column">
																		<column name="{@name}"/>
																	</xsl:for-each>
																</columns>
																<relatedEntity bridged="{@bridged}" name="{@name}" rel="{@rel}" debug="{@debug}"/>
															</mnRelation>
														</xsl:for-each>
														
													</groups>
												</editView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/cartView">
												<cartView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</cartView>
											</xsl:for-each>
											
											<xsl:for-each select="guiTab/views/gridView">
												<gridView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</gridView>
											</xsl:for-each>
												
											<xsl:for-each select="guiTab/views/historyView">	
												<historyView allColumns="{@allColumns}">
													<column name="{@name}"/>
												</historyView>
											</xsl:for-each>	
										</views>
										<computedColumns/>
										<mnRelationships/>
									</guiTab>
									 -->
									<columns>
										<xsl:for-each select="columns/column">
											<column customLabel="{@customLabel}" name="{@name}"/>
										</xsl:for-each>
									</columns>
								</instanceTable>
								</xsl:for-each>
							</instanceTables>
							<guiConfig enableGui="false" guiSystem="mda" guiMode="Read-Only">
				 			</guiConfig>
							<xsl:copy-of select="//maxlenght"/> 											
						</masterModel>
					</xsl:for-each>
			 	</masterModels>		 	
			 	<xsl:copy-of select="//dictionary"/>
			 </logicalModel>
			<!-- <xsl:copy-of select="//nativeServices"/> -->
			<nativeServices>
				<xsl:for-each select="/metadata/nativeServices/basicServices">
					<basicServices getModel="{@getModel}" listInstance="{@listInstance}" listMaster="{@listMaster}" searchInstance="{@searchInstance}" searchMaster="{@searchMaster}" genTraversal="{@genTraversal}" getMaster="{@getMaster}" batchControl="{@batchControl}" getInstance="{@getInstance}" modelStat="{@modelStat}">
						<!-- following two were moved from configurable services  -->
						<xsl:if test="//nativeServices/configurableServices/processDelta[@enable = 'true']">
							<xsl:attribute name="processDelta">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="//nativeServices/configurableServices/rwControl[@enable = 'true']">
							<xsl:attribute name="rwControl">
								<xsl:text>true</xsl:text>
							</xsl:attribute>
						</xsl:if>
					</basicServices>
				</xsl:for-each>				
				<xsl:copy-of select="//nativeServices/configurableServices"/>
				<xsl:copy-of select="//nativeServices/endpointsDefinition"/>
			</nativeServices>
			<preview>
				<xsl:copy-of select="//inputModel"/>
				<databaseModel>
					<instanceTables>
						<xsl:for-each select="preview/databaseModel/instanceTables/physicalTable">
							<physicalTable refData="{@refData}" name="{@name}" layerName="{@layerName}" type="{@type}" customActivity="{@customActivity}">
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" originalPk="{@originalPk}" originalFk="{@originalFk}" dic="{@dic}" origin="{@origin}" extendedSS="{@extendedSS}" type="{@type}" size="{@size}" isFk="{@isFk}" name="{@name}" load="{@load}" artificial="{@artificial}">
											<xsl:for-each select="column/aggregationSource">
												<aggregationSource relationshipName="{@relationshipName}" method="{@method}" sourceColumn="{@sourceColumn}" separator="{@separator}">	
													<xsl:for-each select="aggregationSource/filterExpression">
														<filterExpression>
															<xsl:value-of select="filterExpression|@filterExpression"/>
														</filterExpression>													
													</xsl:for-each>
												</aggregationSource>
											</xsl:for-each>
										</column>
									</xsl:for-each>
								</columns>
								<relationships>
									<xsl:for-each select="relationships/relationship">
										<relationship parentColumn="{@parentColumn}" name="{@name}" parentTable="{@parentTable}" childColumn="{@childColumn}" childTable="{@childTable}"/>
									</xsl:for-each>
								</relationships>
							</physicalTable>
						</xsl:for-each>	
					</instanceTables>
					<masterTables>
						<xsl:for-each select="preview/databaseModel/masterTables/physicalTable">
							<physicalTable refData="{@refData}" name="{@name}" layerName="{@layerName}" type="{@type}" customActivity="{@customActivity}">
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" originalPk="{@originalPk}" originalFk="{@originalFk}" dic="{@dic}" origin="{@origin}" extendedSS="{@extendedSS}" type="{@type}" size="{@size}" isFk="{@isFk}" name="{@name}" load="{@load}" artificial="{@artificial}">
											<xsl:for-each select="column/aggregationSource">
												<aggregationSource relationshipName="{@relationshipName}" method="{@method}" sourceColumn="{@sourceColumn}" separator="{@separator}">	
													<xsl:for-each select="aggregationSource/filterExpression">
														<filterExpression>
															<xsl:value-of select="filterExpression|@filterExpression"/>
														</filterExpression>													
													</xsl:for-each>
												</aggregationSource>
											</xsl:for-each>
										</column>
									</xsl:for-each>
								</columns>
								<relationships>
									<xsl:for-each select="relationships/relationship">
										<relationship parentColumn="{@parentColumn}" name="{@name}" parentTable="{@parentTable}" childColumn="{@childColumn}" childTable="{@childTable}"/>
									</xsl:for-each>
								</relationships>
							</physicalTable>
						</xsl:for-each>	
					</masterTables>
					<refData>
						<xsl:for-each select="preview/databaseModel/refData/physicalTable">
							<physicalTable refData="{@refData}" name="{@name}" layerName="{@layerName}" type="{@type}" customActivity="{@customActivity}">
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" originalPk="{@originalPk}" originalFk="{@originalFk}" dic="{@dic}" origin="{@origin}" extendedSS="{@extendedSS}" type="{@type}" size="{@size}" isFk="{@isFk}" name="{@name}" load="{@load}" artificial="{@artificial}"/>
									</xsl:for-each>
								</columns>
								<relationships>
									<xsl:for-each select="relationships/relationship">
										<relationship parentColumn="{@parentColumn}" name="{@name}" parentTable="{@parentTable}" childColumn="{@childColumn}" childTable="{@childTable}"/>
									</xsl:for-each>
								</relationships>
							</physicalTable>
						</xsl:for-each>	
					</refData>
					<lookups>
						<xsl:for-each select="preview/databaseModel/instanceTables/physicalTable">
							<physicalTable refData="{@refData}" name="{@name}" layerName="{@layerName}" type="{@type}" customActivity="{@customActivity}">
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" originalPk="{@originalPk}" originalFk="{@originalFk}" dic="{@dic}" origin="{@origin}" extendedSS="{@extendedSS}" type="{@type}" size="{@size}" isFk="{@isFk}" name="{@name}" load="{@load}" artificial="{@artificial}"/>
									</xsl:for-each>
								</columns>
								<relationships>
									<xsl:for-each select="relationships/relationship">
										<relationship parentColumn="{@parentColumn}" name="{@name}" parentTable="{@parentTable}" childColumn="{@childColumn}" childTable="{@childTable}"/>
									</xsl:for-each>
								</relationships>
							</physicalTable>
						</xsl:for-each>	
					</lookups>		
				</databaseModel>
				<xsl:copy-of select="//guiPreview"/>	
			</preview>
		    <xsl:copy-of select="//transformations"/>
			<xsl:copy-of select="//documentationRoot"/>
			<advancedSettings>
				<xsl:copy-of select="//taskInfoExport"/>
				<xsl:copy-of select="//reprocessSettings"/>
				<xsl:for-each select="advancedSettings/historyPlugin">
					<historyPlugin enable="@enable">
						<instanceTables>
							<xsl:for-each select="instanceTables/instanceTable">
								<instanceTable allColumns="{@allColumns}" entityName="{@entityName}">
									<instanceColumns>
										<xsl:for-each select="instanceColumn">
											<instanceColumn trace="{@trace}" name="{@name}" searchable="{@searchable}"/>
										</xsl:for-each>
									</instanceColumns>
								</instanceTable> 
							</xsl:for-each>							
						</instanceTables>
						<masterTables>
							<xsl:for-each select="masterTables/masterTable">
								<masterTable allColumns="{@allColumns}" entityName="{@entityName}">
									<masterColumns>
										<xsl:for-each select="masterColumn">
											<masterColumn trace="{@trace}" name="{@name}" searchable="{@searchable}"/>
										</xsl:for-each>
									</masterColumns>
								</masterTable> 
							</xsl:for-each>								
						</masterTables>
						<referenceDataTables>
							<xsl:for-each select="referenceDataTables/referenceDataTable">
								<referenceDataTable allColumns="{@allColumns}" entityName="{@entityName}">
									<referenceDataColumns>
										<xsl:for-each select="referenceDataColumn">
											<referenceDataColumn trace="{@trace}" name="{@name}" searchable="{@searchable}"/>
										</xsl:for-each>
									</referenceDataColumns>
								</referenceDataTable> 
							</xsl:for-each>							
						</referenceDataTables>					
					</historyPlugin>				
				</xsl:for-each>
			</advancedSettings>
			<!-- <xsl:copy-of select="//outputOperations"/>-->
			<outputOperations>
				<xsl:copy-of select="//exportModel"/>
				<eventHandler>
					<handlers>
						<xsl:for-each select="outputOperations/eventHandler/handlers/handler">
							<handler>
								<publishers>
									<xsl:for-each select="publishers/stdOutPublisher">
										<xsl:copy-of select="//stdOutPublisher"/>
									</xsl:for-each>
									<xsl:for-each select="publishers/eventPlanPublisher">
										<xsl:copy-of select="//eventPlanPublisher"/>
									</xsl:for-each>
									<xsl:for-each select="publishers/eventSqlPublisher">
										<!--  <xsl:copy-of select="//eventSqlPublisher"/> -->
										<eventSqlPublisher dataSource="{@dataSource}" enable="{@enable}">
											<description><xsl:value-of select="description|@description"/></description>
											<xsl:copy-of select="sqlTemplates"/>
											<xsl:copy-of select="advanced"/>
										</eventSqlPublisher>
									</xsl:for-each>									
									<xsl:for-each select="publishers/jmsPublisher">
										<xsl:copy-of select="//jmsPublisher"/>
									</xsl:for-each>
									<xsl:for-each select="publishers/ismPublisher">
										<xsl:copy-of select="//ismPublisher"/>
									</xsl:for-each>	
									<xsl:for-each select="publishers/httpSoapPublisher">
										<httpSoapPublisher urlResourceName="" soapAction="{@soapAction}" encoding="{@encoding}" enable="{@enable}" soapVersion="{@soapVersion}" delay="{@delay}" timeout="{@timeout}">
											<description><xsl:value-of select="description|@description"/></description>
											<transformers>
												<xsl:for-each select="transformers/expressionTemplateTransformer">
													<expressionTemplateTransformer name="{@name}" entityName="{@entityName}">
														<template><xsl:value-of select="template"/></template>
														<cct layerName="{@layerName}" entityName="{@entityName}"/>
													</expressionTemplateTransformer>
												</xsl:for-each>
											</transformers>
										 	<advanced>
												<filteringPublisher filter="{advanced/filteringPublisher/@filter}">
													<expression><xsl:value-of select="advanced/filteringPublisher/expression"/></expression>
													<filteredEntities>
														<xsl:for-each select="advanced/filteringPublisher/filteredEntities/entity">
															<entity name="{@name}">
																<expression><xsl:value-of select="expression"/></expression>
																<ccf layerName="{cc/@layerName}" entityName="{cc/@entityName}"/>
															</entity>
														</xsl:for-each>
													</filteredEntities>
												</filteringPublisher>
												<retryingPublisher maxRetries="{advanced/retryingPublisher/@maxRetries}" consecutiveSuccess="{advanced/retryingPublisher/@consecutiveSuccess}" retryDelay="{advanced/retryingPublisher/@retryDelay}" retry="{advanced/retryingPublisher/@retry}" globalRetries="{advanced/retryingPublisher/@globalRetries}"/>
											</advanced>
										</httpSoapPublisher>
									</xsl:for-each>																																
								</publishers>
								<xsl:copy-of select="//filter"/>
							</handler>
						</xsl:for-each>
					</handlers>
					<xsl:copy-of select="//metaColumns"/>
				</eventHandler>
			</outputOperations>
		 </metadata>
	</xsl:template>
</xsl:stylesheet>
