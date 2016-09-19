<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/metadata">
		<metadata>
			<settings guiReadOnly="true" scope="active" deletionStrategy="deactivate">
				<advancedSettings expStringLength="500" srcStringLength="100" alternativeKeys="true">
					<ignoredComparisonColumns>
						<ignoredComparisonColumn allEntities="true" names="meta_last_mod_date">
							<entities/>
						</ignoredComparisonColumn>
					</ignoredComparisonColumns>
				</advancedSettings>
				<lengthValidation databaseType="Oracle R9+" nmePrefixLength="2" historyPersistence="false"/>
			</settings>
			<systems>
				<xsl:for-each select="dataSources/company/systems/system[@active='true']">
					<xsl:variable name="companyCode" select="ancestor::company/@code"/>
					<xsl:variable name="systemCode" select="@code"/>
					<system name="{$systemCode}">
						<!-- <system name="{ancestor::company/@code}_{@name}"> -->
						<description>
							<xsl:value-of select="@desc"/>
						</description>
						<model>
							<relationships>
								<!-- N/A in v7 - not upgrading -->
							</relationships>
							<tables>
								<xsl:for-each select="endpoints/endpoint[@active='true']/entities/entity">
									<xsl:if test="self::entity[not(@entitySource = preceding-sibling::entity/@entitySource)]">
										<table name="{@entitySource}"/>
									</xsl:if>
								</xsl:for-each>
							</tables>
						</model>
						<sourceMappings>
							<xsl:for-each select="endpoints/endpoint[@active='true']/entities/entity">
								<mapping entity="{@entityName}" table="{@entitySource}" customOrigin="{$companyCode}##{$systemCode}##{@entityName}">
									<description>
										<xsl:value-of select="@desc"/>
									</description>
									<viewOrigin origin=""/>
								</mapping>
							</xsl:for-each>
						</sourceMappings>
						<loadOperations>
							<xsl:for-each select="endpoints/endpoint[@active='true']">
							<xsl:variable name="endpoint" select="@code" />
								<xsl:if test="ancestor::system/@DirectLoad = 'true'">
									<directLoad nameSuffix="{$endpoint}_INI" allTables="true">
										<advanced deletionStrategy="use global setting (from Preferences)">
											<ignoredComparisonColumns/>
										</advanced>
									</directLoad>
								</xsl:if>
								<xsl:if test="ancestor::system/@FullLoad = 'true'">
									<fullLoad nameSuffix="{$endpoint}_FULL">
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
												<table name="{@name}"/>
											</xsl:for-each>
										</selectedTables>
										<advanced deletionStrategy="use global setting (from Preferences)">
											<ignoredComparisonColumns/>
										</advanced>
									</fullLoad>
								</xsl:if>
								<xsl:if test="ancestor::system/@DeltaLoad = 'true'">
									<xsl:choose>
										<xsl:when test="ancestor::system/@entityType='autonomous'">
											<deltaLoad nameSuffix="{$endpoint}_INC" allTables="true">
												<advanced deletionStrategy="use global setting (from Preferences)">
													<ignoredComparisonColumns/>
												</advanced>
											</deltaLoad>
										</xsl:when>
										<xsl:when test="ancestor::system/@entityType='custom'">
											<complexDeltaLoad nameSuffix="{$endpoint}_INC">
												<tableSettings>
													<xsl:for-each select="entities/entity">
														<table name="{@entityName}" keyColumn="">
															<xsl:choose>
																<xsl:when test="@deltaDependency = 'autonomous'">
																	<xsl:attribute name="mode"><xsl:text>autonomous</xsl:text></xsl:attribute>
																</xsl:when>
																<xsl:when test="@deltaDependency = 'Central'">
																	<xsl:attribute name="mode"><xsl:text>central</xsl:text></xsl:attribute>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:attribute name="mode"><xsl:value-of select="@deltaDependency"/></xsl:attribute>
																</xsl:otherwise>
															</xsl:choose>
														</table>
													</xsl:for-each>
												</tableSettings>
												<advanced deletionStrategy="use global setting (from Preferences)">
													<ignoredComparisonColumns/>
													<partitionedEntities/>
												</advanced>
											</complexDeltaLoad>
										</xsl:when>
										<xsl:otherwise>
											<error/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</xsl:for-each>
						</loadOperations>
					</system>
				</xsl:for-each>
			</systems>
			<logicalModel>
				<instanceModel>
					<relationships>
						<xsl:for-each select="metamodel/entities/relationships/relationship">
							<relationship name="{@name}" parentRole="" childRole="" parentTable="{@parentTable}" childTable="{@childTable}">
								<xsl:choose>
									<xsl:when test="@relType='sameSystem'">
										<xsl:attribute name="type">Same System</xsl:attribute>
									</xsl:when>
									<xsl:when test="@relType='crossSystem'">
										<xsl:attribute name="type">Cross System</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="type">unknown</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<description>
									<xsl:value-of select="@desc"/>
								</description>
								<foreignKey>
									<xsl:for-each select="foreignKeys/foreignKey">
										<column parentColumn="{@parentColumn}" childColumn="{@childColumn}"/>
									</xsl:for-each>
								</foreignKey>
								<parentToChild>
									<xsl:for-each select="parentToChild/column">
										<column source="{@sourceColumn}" name="{@name}" type="{@dqcType}">
											<xsl:choose>
												<xsl:when test="@origin='COPY_SOURCE'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::relationship/@childTable"/><xsl:text>_clean</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@origin='COPY_CLEAN'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::relationship/@childTable"/><xsl:text>_match</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@origin='COPY_MATCH'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::metamodel/domainViews/domainView/@domainViewCode"/><xsl:text>_</xsl:text><xsl:value-of select="ancestor::relationship/@childTable"/><xsl:text>_merge</xsl:text></xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<xsl:variable name="sourceColumnShort" select="substring(@sourceColumn,5)"/>
											<xsl:variable name="sourceColumn" select="@sourceColumn"/>
											<xsl:variable name="columnDetails" select="ancestor::metamodel/entities/tables/table[@name=ancestor::metamodel/entities/relationships/relationship/@parentTable]/columns/column[@name=$sourceColumnShort or @name=$sourceColumn]"/>
											<xsl:choose>
												<!-- master_id is an internal column and size is not defined -->
												<xsl:when test="@sourceColumn='master_id'">
													<xsl:attribute name="size"><xsl:text/></xsl:attribute>
												</xsl:when>
												<!-- size is retrieved from instance table -->
												<xsl:when test="substring(@sourceColumn,5)=$columnDetails/@name and (substring(@sourceColumn,1,4)='std_' or substring(@sourceColumn,1,4)='cio_')">
													<xsl:attribute name="size"><xsl:value-of select="$columnDetails/@size"/></xsl:attribute>
												</xsl:when>
												<xsl:when test="substring(@sourceColumn,5)=$columnDetails/@name and substring(@sourceColumn,1,4)='src_'">
													<xsl:attribute name="size"><xsl:text>2000</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="substring(@sourceColumn,5)=$columnDetails/@name and substring(@sourceColumn,1,4)='sco_'">
													<xsl:attribute name="size"><xsl:text>10</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="substring(@sourceColumn,5)=$columnDetails/@name and substring(@sourceColumn,1,4)='exp_'">
													<xsl:attribute name="size"><xsl:text>500</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@sourceColumn=$columnDetails/@name">
													<xsl:attribute name="size"><xsl:value-of select="$columnDetails/@size"/></xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="size"><xsl:value-of select="@size"/></xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<filterExpression>
												<xsl:value-of select="@filterExpression"/>
											</filterExpression>
										</column>
									</xsl:for-each>
								</parentToChild>
								<childToParent>
									<xsl:for-each select="childToParent/column">
										<column source="{@sourceColumn}" name="{@name}" method="{@method}" type="{@dqcType}" separator="{@separator}" size="{@size}">
											<xsl:choose>
												<xsl:when test="@origin='COPY_SOURCE'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::relationship/@parentTable"/><xsl:text>_clean</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@origin='COPY_CLEAN'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::relationship/@parentTable"/><xsl:text>_match</xsl:text></xsl:attribute>
												</xsl:when>
												<xsl:when test="@origin='COPY_MATCH'">
													<xsl:attribute name="createInto"><xsl:value-of select="ancestor::metamodel/domainViews/domainView/@domainViewCode"/><xsl:text>_</xsl:text><xsl:value-of select="ancestor::relationship/@parentTable"/><xsl:text>_merge</xsl:text></xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<filterExpression>
												<xsl:value-of select="@filterExpression"/>
											</filterExpression>
										</column>
									</xsl:for-each>
								</childToParent>
							</relationship>
						</xsl:for-each>
					</relationships>
					<tables>
						<xsl:for-each select="metamodel/entities/tables/table">
							<xsl:variable name="matchingTable" select="@name"/>
							<table name="{@name}">
								<description>
									<xsl:choose>
										<xsl:when test="@desc">
											<xsl:value-of select="@desc"/>
										</xsl:when>
										<xsl:when test="desc">
											<xsl:value-of select="desc"/>
										</xsl:when>
									</xsl:choose>
								</description>
								<columns>
									<xsl:for-each select="columns/column">
										<column isPk="{@primary}" isSco="{@sco}" type="{@dqcType}" size="{@size}" isFk="{@foreignKey}" refData="{@refDataInst}" isSrc="{@src}" isExp="{@exp}" description="{@comment}" name="{@name}" isStd="{@std}" isCio="{@cio}"/>
									</xsl:for-each>
								</columns>
								<xsl:for-each select="ancestor::metamodel/matchings/matching[@code='gen']/tables/table[$matchingTable=@name]">
									<matchingTab enableIdentify="true" matching="true">
										<matchingTabColumns>
											<xsl:for-each select="matchingOutputCols/column">
												<column name="{@name}" type="{@dqcType}" size="{@size}">
													<description>
														<xsl:value-of select="@desc"/>
													</description>
												</column>
											</xsl:for-each>
										</matchingTabColumns>
									</matchingTab>
								</xsl:for-each>
								<advanced>
									<specialColumns>
										<xsl:for-each select="specialColumns/column">
											<column name="{@name}" type="{@dqcType}" size="{@size}">
												<xsl:attribute name="createInto"><xsl:choose><xsl:when test="@origin = 'SOURCE'"><xsl:text>load</xsl:text></xsl:when><xsl:otherwise><xsl:value-of select="ancestor::table/@name"/><xsl:text>_</xsl:text><xsl:value-of select="fn:lower-case(@origin)"/></xsl:otherwise></xsl:choose></xsl:attribute>
												<description>
													<xsl:value-of select="@desc"/>
												</description>
											</column>
										</xsl:for-each>
									</specialColumns>
									<historicalColumns/>
									<oldValueColumns/>
								</advanced>
							</table>
						</xsl:for-each>
					</tables>
				</instanceModel>
				<masterModels>
					<xsl:for-each select="metamodel/domainViews/domainView">
						<masterModel name="{@domainViewCode}" enableGui="false">
							<description>
								<xsl:value-of select="@description"/>
							</description>
							<instanceTables>
								<xsl:for-each select="model/tables/table[@type='instance']">
									<instanceTable name="{@entity}" instanceTable="{@entity}"/>
								</xsl:for-each>
							</instanceTables>
							<masterTables>
								<xsl:for-each select="model/tables/table[@type='silver' or @type= 'golden']">
									<masterTable description="" name="{@name}" entityRole="{@type}" instanceTable="{@entity}">
										<columns>
											<xsl:for-each select="outputColumns/column">
												<column isCmo="false" isPk="{@primary}" isFk="{@foreignKey}" description="{@comment}" name="{@name}" size="{@size}">
													<xsl:choose>
														<xsl:when test="@dqcType='long' and @primary='true'">
															<xsl:attribute name="type">long_int</xsl:attribute>
														</xsl:when>
														<xsl:when test="@dqcType='long' and @foreignKey='true'">
															<xsl:attribute name="type">long_int</xsl:attribute>
														</xsl:when>
														<xsl:when test="@primary='true' and @foreignKey!='true'">
															<xsl:attribute name="type">long_int</xsl:attribute>
														</xsl:when>
														<xsl:otherwise>
															<xsl:attribute name="type"><xsl:value-of select="@dqcType"/></xsl:attribute>
														</xsl:otherwise>
													</xsl:choose>
												</column>
											</xsl:for-each>
										</columns>
										<advanced inputFilterExpression="" groupColumn="" customActivity="false">
											<specialColumns/>
										</advanced>
									</masterTable>
								</xsl:for-each>
							</masterTables>
							<relationships>
								<xsl:for-each select="model/relationships/relationship">
									<relationship name="{@name}" parentRole="" childRole="" parentTable="{@parentTable}" childTable="{@childTable}">
										<!--
										<xsl:attribute name="relType"><xsl:choose><xsl:when test="@relType='sameSystem'">Same System</xsl:when><xsl:when test="@relType='crossSystem'">Cross System</xsl:when><xsl:otherwise/></xsl:choose></xsl:attribute>
										-->
										<description>
											<xsl:value-of select="@desc"/>
										</description>
										<xsl:for-each select="foreignKeys/foreignKey">
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
				<dictionary>
					<tables>
						<xsl:for-each select="ancestor-or-self::metadata/dictionary/dicModel/tables/table">
							<table name="{@name}" loadInst="false" loadMas="true" label="" description="{@desc}">
								<xsl:attribute name="instUse"><xsl:choose><xsl:when test="@insertType = 'batch and on-line oriented' ">cleansing</xsl:when><xsl:when test="@insertType = 'batch oriented' ">load</xsl:when><xsl:otherwise>none</xsl:otherwise></xsl:choose></xsl:attribute>
								<columns>
									<xsl:for-each select="columns/column">
										<xsl:choose>
											<xsl:when test="@primary = 'true' or @lookupRole='source system' or @lookupRole='target value'"/>
											<xsl:otherwise>
												<column name="{@name}" type="{@dqcType}" instance="true" master="true" size="{@size}" label="">
													<comment>
														<xsl:value-of select="@comment"/>
													</comment>
												</column>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</columns>
								<xsl:copy-of select="lookupSettings"/>
							</table>
						</xsl:for-each>
					</tables>
					<genTables/>
				</dictionary>
			</logicalModel>
			<outputOperations>
				<exportModel>
					<xsl:for-each select="exportOperations/ExportSystemWrapper/ExportSystem">
						<xsl:for-each select="ExportOperationWrapper/exportOperation">
							<xsl:if test="@fullExport = 'true'">
								<xsl:call-template name="ComplexExport">
									<xsl:with-param name="mode">full</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="@deltaExport = 'true'">
								<xsl:call-template name="ComplexExport">
									<xsl:with-param name="mode">delta</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</exportModel>
				<eventHandler>
					<handlers/>
				</eventHandler>
			</outputOperations>
			<advancedSettings>
				<taskInfoExport description="" name="task_info" enable="false"/>
				<reprocessSettings>
					<reprocess>
						<xsl:for-each select="ancestor-or-self::metadata/settings/reprocessings/reprocessing">
							<full plan="{@name}" allTables="false">
								<description/>
								<entities>
									<xsl:for-each select="entities/entity">
										<entity name="{@entityName}"/>
									</xsl:for-each>
								</entities>
							</full>
						</xsl:for-each>
					</reprocess>
				</reprocessSettings>
			</advancedSettings>
		</metadata>
	</xsl:template>
	<xsl:template name="ComplexExport">
		<xsl:param name="mode"/>
		<complexExport name="{ancestor::ExportSystem/@name}_{@name}_{$mode}">
			<description>
				<xsl:value-of select="desc"/>
			</description>
			<dataSources>
				<xsl:for-each select="dataProviders/dataProvider[@source = 'inst']">
					<instanceDataSource scope="{fn:lower-case(@scope)}" allEntities="false" sourceSystem="{ancestor::ExportSystem/@name}" prefix="{@prefix}" mode="{$mode}">
						<selectedTables>
							<xsl:for-each select="entities/entity">
								<instanceTable allColumns="{@allColumns}" name="{@name}">
									<xsl:choose>
										<xsl:when test="@allColumns = 'false'">
											<columns>
												<xsl:for-each select="ExportColumnWrapper/ExportColumn">
													<xsl:variable name="colPrefix" select="substring(@column,1,4)"/>
													<xsl:choose>
														<xsl:when test="$colPrefix = 'eng_'">
															<!-- exclude ENG_ columns -->
														</xsl:when>
														<xsl:otherwise>
															<column name="{fn:lower-case(@column)}"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</columns>
										</xsl:when>
										<xsl:otherwise>
											<columns/>
										</xsl:otherwise>
									</xsl:choose>
								</instanceTable>
							</xsl:for-each>
						</selectedTables>
					</instanceDataSource>
				</xsl:for-each>
				<xsl:for-each select="dataProviders/dataProvider[@source != 'inst']">
					<masterDataSource scope="{fn:lower-case(@scope)}" allEntities="false" layerName="{@source}" prefix="{@prefix}" mode="{$mode}">
						<selectedTables>
							<xsl:for-each select="entities/entity">
								<table allColumns="{@allColumns}" name="{@name}">
									<xsl:choose>
										<xsl:when test="@allColumns = 'false'">
											<columns>
												<xsl:for-each select="ExportColumnWrapper/ExportColumn">
													<xsl:variable name="colPrefix" select="substring(@column,1,4)"/>
													<xsl:choose>
														<xsl:when test="$colPrefix = 'eng_'">
															<!-- exclude ENG_ columns -->
														</xsl:when>
														<xsl:otherwise>
															<column name="{fn:lower-case(@column)}"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</columns>
										</xsl:when>
										<xsl:otherwise>
											<columns/>
										</xsl:otherwise>
									</xsl:choose>
								</table>
							</xsl:for-each>
						</selectedTables>
					</masterDataSource>
				</xsl:for-each>
			</dataSources>
		</complexExport>
	</xsl:template>
</xsl:stylesheet>
