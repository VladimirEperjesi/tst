<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/metadata">
		<metadata>
			<systems>
				<xsl:for-each select="systems/system">
					<system name="{@name}">
						<description>
							<xsl:value-of select="@description"/>
						</description>
						<model>
							<!--<xsl:copy-of select="//relationships"/>
							<xsl:copy-of select="//tables"/>-->
							<relationships>
								<xsl:for-each select="model/relationships/relationship">
									<relationship name="{@name}" parentTable="{@parentTable}" childTable="{@childTable}">
										<foreignKey>
											<xsl:for-each select="foreignKey/relationship">
												<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
											</xsl:for-each>
										</foreignKey>
									</relationship>
								</xsl:for-each>
							</relationships>
							<tables>
								<xsl:for-each select="model/tables/table">
									<table name="{@name}">
										<xsl:for-each select="columns">
											<columns>
												<xsl:for-each select="column">
													<column description="" name="{@name}" type="{@dbType}"/>
												</xsl:for-each>
											</columns>
										</xsl:for-each>
									</table>
								</xsl:for-each>
							</tables>
						</model>
						<sourceMappings>
							<xsl:for-each select="sourceMappings/mapping">
								<mapping entity="{@entity}" table="{@table}" customOrigin="{@name}">
									<description>
										<xsl:value-of select="@description"/>
									</description>
									<viewOrigin origin=""/>
									<!-- empty or {@name} -->
								</mapping>
							</xsl:for-each>
						</sourceMappings>
						<xsl:for-each select="loadOperations">
							<loadOperations>
								<xsl:for-each select="fullLoad">
									<!-- if tables defined, allTables cannot be true -->
										<fullLoad nameSuffix="{@nameSuffix}" allTables="{@allTables}">
											<xsl:choose>
											<xsl:when test="selectedTables/table">
													<xsl:attribute name="allTables">false</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
													<xsl:attribute name="allTables">true</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<selectedTables>
											<xsl:for-each select="selectedTables/table">
												<table name="{@name}">
												</table>
											</xsl:for-each>
										</selectedTables>
										<advanced deletionStrategy="{@sourceDeletionStrategy}">
											<ignoredComparisonColumns/>
										</advanced>
									</fullLoad>
								</xsl:for-each>
								<xsl:for-each select="deltaLoad">
									<deltaLoad nameSuffix="{@nameSuffix}" allTables="true">
										<advanced deletionStrategy="{@sourceDeletionStrategy}">
											<ignoredComparisonColumns/>
										</advanced>
									</deltaLoad>
								</xsl:for-each>
								<xsl:for-each select="complexDeltaLoad">
									<complexDeltaLoad nameSuffix="{@nameSuffix}">
										<tableSettings>
											<xsl:for-each select="tableSettings/table">
												<table name="{@name}" keyColumn="{@keyColumn}">
													<xsl:choose>
													<xsl:when test="@mode='dependent'">
															<xsl:attribute name="mode"><xsl:value-of select="@owningTable"/></xsl:attribute>
													</xsl:when>
													<xsl:otherwise>
														<xsl:attribute name="mode"><xsl:value-of select="@mode"/></xsl:attribute>
													</xsl:otherwise>
													</xsl:choose>
												</table>
											</xsl:for-each>
										</tableSettings>
										<advanced deletionStrategy="{@sourceDeletionStrategy}">
											<ignoredComparisonColumns/>
											<partitionedEntities/>
										</advanced>
									</complexDeltaLoad>
								</xsl:for-each>
							</loadOperations>
						</xsl:for-each>
					</system>
				</xsl:for-each>
			</systems>
			<!-- <xsl:copy-of select="//logicalModel"/> -->
			<logicalModel>
				<instanceModel>
					<relationships>
						<xsl:for-each select="logicalModel/instanceModel/relationships/relationship">
							<relationship parentRole="{@parentRole}" name="{@name}"  childRole="{@childRole}" parentTable="{@parentTable}" childTable="{@childTable}">
								<xsl:choose>
									<xsl:when test="@type='single_system'">
											<xsl:attribute name="type">Same System</xsl:attribute>
									</xsl:when>
									<xsl:when test="@type='cross_system'">
											<xsl:attribute name="type">Cross System</xsl:attribute>
									</xsl:when>
								</xsl:choose>
								<description/>
								<foreignKey>
									<xsl:for-each select="foreignKey/column">
										<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
									</xsl:for-each>
								</foreignKey>
								<parentToChild>
									<xsl:for-each select="parentToChild/column">
										<column source="{@source}" name="{@name}" type="{@type}">
											<xsl:choose>
												<xsl:when test="@copyAfter='load'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@childTable"/><xsl:text>_clean</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@copyAfter='clean'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@childTable"/><xsl:text>_match</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@copyAfter='match'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/masterModels/masterModel/@name"/><xsl:text>_</xsl:text><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@childTable"/><xsl:text>_merge</xsl:text></xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<xsl:variable name="sourceColumnShort" select="substring(@source,5)"/>
											<xsl:variable name="sourceColumn" select="@source"/>
                      						<xsl:variable name="columnDetails" select="//logicalModel/instanceModel/tables/table[@name=ancestor::logicalModel/instanceModel/relationships/relationship/@parentTable]/columns/column[@name=$sourceColumnShort or @name=$sourceColumn]"/>
											<xsl:choose>	
												<!-- master_id is an internal column and size is not defined -->
												<xsl:when test="@source='master_id'">
														<xsl:attribute name="size">
														<xsl:text/>
													</xsl:attribute>
												</xsl:when>
												<!-- size is retrieved from instance table -->
												<xsl:when test="substring(@source,5)=$columnDetails/@name and (substring(@source,1,4)='std_' or substring(@source,1,4)='cio_')">
														<xsl:attribute name="size">
														<xsl:value-of select="$columnDetails/@size"/>
													</xsl:attribute>
												</xsl:when>
                        <xsl:when test="substring(@source,5)=$columnDetails/@name and substring(@source,1,4)='src_'">
														<xsl:attribute name="size">
														<xsl:text>2000</xsl:text>
													</xsl:attribute>
												</xsl:when>
                        <xsl:when test="substring(@source,5)=$columnDetails/@name and substring(@source,1,4)='sco_'">
														<xsl:attribute name="size">
														<xsl:text>10</xsl:text>
													</xsl:attribute>
												</xsl:when>
                         <xsl:when test="substring(@source,5)=$columnDetails/@name and substring(@source,1,4)='exp_'">
														<xsl:attribute name="size">
														<xsl:text>500</xsl:text>
													</xsl:attribute>
												</xsl:when>
												<xsl:when test="@source=$columnDetails/@name">
														<xsl:attribute name="size">
														<xsl:value-of select="$columnDetails/@size"/>
													</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="size">
														<xsl:value-of select="@size"/>
													</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<filterExpression><xsl:value-of select="@filterExpression"/></filterExpression>
										</column>
									</xsl:for-each>
								</parentToChild>
								<childToParent>
									<xsl:for-each select="childToParent/item">
										<column source="{@source}" name="{@name}"  method="{@method}" type="{@type}" separator="{@separator}" size="{@size}">
											<xsl:choose>
												<xsl:when test="@copyAfter='load'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@parentTable"/><xsl:text>_clean</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@copyAfter='clean'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@parentTable"/><xsl:text>_match</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@copyAfter='match'">
														<xsl:attribute name="createInto"><xsl:value-of select="ancestor::logicalModel/masterModels/masterModel/@name"/><xsl:text>_</xsl:text><xsl:value-of select="ancestor::logicalModel/instanceModel/relationships/relationship/@parentTable"/><xsl:text>_merge</xsl:text></xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<filterExpression><xsl:value-of select="@filterExpression"/></filterExpression>
										</column>
									</xsl:for-each>
								</childToParent>
							</relationship>
						</xsl:for-each>
					</relationships>
					<tables>
						<xsl:for-each select="logicalModel/instanceModel/tables/table">
							<xsl:variable name="matchingTable" select="@name"/>
							<table name="{@name}">
								<description/>
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@isPk}" isSco="{@isSco}" type="{@type}" size="{@size}" isFk="{@isFk}" refData="" isSrc="{@isSrc}" isExp="{@isExp}" description="{@description}" name="{@name}" isStd="{@isStd}" isCio="{@isCio}"/>
									</xsl:for-each>
								</columns>
								<xsl:for-each select="//logicalModel/matchingModel/matching/tables/matchingTable[$matchingTable=@name]">
									<matchingTab enableIdentify="{@enableIdentify}" matching="true">
										<matchingTabColumns>
											<xsl:for-each select="matchingColumns/column">
												<column name="{@name}" type="{@type}" size="{@size}">
												</column>
											</xsl:for-each>
										</matchingTabColumns>
									</matchingTab>
								</xsl:for-each>
								<advanced>
									<specialColumns/>
									<historicalColumns/>
									<oldValueColumns/>
								</advanced>
							</table>
						</xsl:for-each>
					</tables>
				</instanceModel>
				<masterModels>
					<xsl:for-each select="logicalModel/masterModels/masterModel">
					<masterModel name="{@name}" enableGui="false">
						<description>
							<xsl:value-of select="@description"/>
						</description>
						<instanceTables>
						<xsl:for-each select="instanceTables/instanceTable">
							<instanceTable name="{@name}" instanceTable="{@instanceTable}"/>
						</xsl:for-each>
						</instanceTables>
						<masterTables>
							<xsl:for-each select="masterTables/masterTable">
								<!-- entity role converted: central > golden aand dependent > silver-->
								<masterTable description="" name="{@name}" entityRole="" instanceTable="{@instanceTable}">
									<xsl:choose>
										<xsl:when test="@entityRole='central'">
												<xsl:attribute name="entityRole">golden</xsl:attribute>
										</xsl:when>
										<xsl:when test="@entityRole='dependent'">
												<xsl:attribute name="entityRole">silver</xsl:attribute>
										</xsl:when>
									</xsl:choose>
									<columns>
										<xsl:for-each select="columns/column">
											<column isCmo="{@isCmo}" isPk="{@isPk}" isFk="{@isFk}" description="{@description}" name="{@name}"  size="{@size}">
											<xsl:choose>
												<xsl:when test="@type='long' and @isPk='true'">
														<xsl:attribute name="type">long_int</xsl:attribute>
												</xsl:when>
												<xsl:when test="@type='long' and @isFk='true'">
														<xsl:attribute name="type">long_int</xsl:attribute>
												</xsl:when>
												<xsl:when test="@isPk='true' and @isFk!='true'">
														<xsl:attribute name="type">long_int</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
														<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											</column>
										</xsl:for-each>
									</columns>
									<advanced inputFilterExpression="{@inputFilterExpression}" groupColumn="" customActivity="false">
										<specialColumns/>
									</advanced>
								</masterTable>
							</xsl:for-each>
						</masterTables>
							<relationships>
								<xsl:for-each select="relationships/relationship">
								<!-- type conversion single_system => Same System atd. not available now -->
								<relationship parentRole="{@parentRole}" name="{@name}"  childRole="{@childRole}" parentTable="{@parentTable}" childTable="{@childTable}">
								<description/>
									<xsl:for-each select="foreignKey/column">
										<foreignKey>
											<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
										</foreignKey>
									</xsl:for-each>
							</relationship>
						</xsl:for-each>
						</relationships>
						</masterModel>
					</xsl:for-each>
				</masterModels>
			</logicalModel>
			<outputOperations>
				<exportModel>
					<xsl:for-each select="exportModel">
						<xsl:for-each select="fullMasterExport">
							<fullMasterExport name="{@name}" layerName="{@layerName}" allEntities="false">
								<selectedTables>
									<xsl:for-each select="selectedTables/table">
										<table allColumns="true" name="{@name}">
											<columns/>
										</table>
									</xsl:for-each>
								</selectedTables>
							</fullMasterExport>
						</xsl:for-each>
						<xsl:for-each select="fullInstanceExport">
							<fullInstanceExport sourceSystem="{@sourceSystem}" name="{@name}" allEntities="false">
								<selectedTables>
									<xsl:for-each select="selectedTables/instanceTable">
										<instanceTable allColumns="true" name="{@name}">
											<columns/>
										</instanceTable>
									</xsl:for-each>
								</selectedTables>
							</fullInstanceExport>
						</xsl:for-each>
						<xsl:for-each select="complexExport">
							<complexExport name="{@name}">
								<dataSources>
									<xsl:for-each select="dataSources/instanceDataSource">
										<instanceDataSource allEntities="false" sourceSystem="{@sourceSystem}" prefix="{@prefix}" mode="{@mode}">
											<selectedTables>
												<xsl:for-each select="selectedTables/instanceTable">
													<instanceTable allColumns="true" name="{@name}">
														<columns/>
													</instanceTable>
												</xsl:for-each>
											</selectedTables>
										</instanceDataSource>
									</xsl:for-each>
									<xsl:for-each select="dataSources/masterDataSource">
										<masterDataSource allEntities="false" layerName="{@layerName}" prefix="{@prefix}" mode="{@mode}">
											<selectedTables>
												<xsl:for-each select="selectedTables/table">
													<table allColumns="true" name="{@name}">
														<columns/>
													</table>
												</xsl:for-each>
											</selectedTables>
										</masterDataSource>
									</xsl:for-each>
								</dataSources>
							</complexExport>
						</xsl:for-each>
					</xsl:for-each>
				</exportModel>
			</outputOperations>
		</metadata>
	</xsl:template>
</xsl:stylesheet>
