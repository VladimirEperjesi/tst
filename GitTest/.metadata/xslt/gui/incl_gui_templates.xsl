<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<!-- detail view groups -->
	<xsl:template match="labeledGroup">
		<!-- <xsl:param name="templatePosition"/> -->
		<fieldGrid classes="mda-BorderedSection mda-{@templatePosition}ContentMargin" labelKey="{@label}">
			<xsl:if test="viewCondition!=''">
				<xsl:attribute name="parts" select="@name"/>
			</xsl:if>
			<!--  there should be a new field in configuration describing the left/right position  -->
			<fields>
				<xsl:apply-templates select="columns/column" mode="view"/>
			</fields>
		</fieldGrid>
	</xsl:template>
	
	<xsl:template match="labeledGroup" mode="readOnly">
			<!-- read only added -->
			<!-- <xsl:param name="templatePosition"/> -->
			<fieldGrid classes="mda-BorderedSection mda-{@templatePosition}ContentMargin" labelKey="{@label}" readOnly="true">
				<!--  there should be a new field in configuration describing the left/right position  -->
				<xsl:if test="viewCondition!=''">
					<xsl:attribute name="parts" select="@name"/>
				</xsl:if>
				<fields>
					<xsl:apply-templates select="columns/column" mode="view"/>
				</fields>
			</fieldGrid>
		</xsl:template>
		
	<xsl:template match="column" mode="view">
		<field>
			<xsl:attribute name="name">
				<xsl:value-of select="fn:lower-case(@name)"/>
			</xsl:attribute>
			<xsl:if test="@lookupType!=''">
				<xsl:attribute name="lookupType">
					<xsl:value-of select="@lookupType"/>
				</xsl:attribute>
			</xsl:if> 
			<xsl:if test="@format!=''">
				<xsl:attribute name="format">
					<xsl:value-of select="@format"/>
				</xsl:attribute>
			</xsl:if> 
			<!-- <fieldGrid classes="mda-BorderedSection mda-leftContentMargin" labelKey="Basic organisation information"> 
				<fields> 
					<field name="cmo_type" lookupType="COMBO"/> 
					<field name="cmo_legal_form" lookupType="COMBO"/> 
					<field name="cmo_established_date" format="yyyy-MM-dd"/>
				 </fields> 
				 </fieldGrid> -->
				<!-- there has to be the following attributes added: lookupType="COMBO" 
				format="yyyy-MM-dd" -->
		</field>
	</xsl:template>
	
	<xsl:template match="labeledRelatedMNList">
		<!-- <xsl:param name="templatePosition"/> -->
		<switchPanel classes="mda-BorderedSection mda-{@templatePosition}ContentMargin">
				<xsl:if test="viewCondition!=''">
					<xsl:attribute name="parts" select="@name"/>
				</xsl:if>
			<option activeLabel="{@label}" inactiveLabel="Show Linked Records">
				<rowIterator relation="rev_{@relationship}:{@relationship_out}"	template="relatedRow.tmpl" emptyMessageKey="No records" previewLimit="5">
					<!-- rev_party_has_child_party:party_has_parent_party -->
					<templateParameters>
						<parameter name="firstColumnFormat" value="{MNlinkedRecordsParams/firstColumnFormat}" /> <!-- {@columnLabel}: {@columnName} -->
						<parameter name="secondColumnFormat" value="{MNlinkedRecordsParams/secondColumnFormat}"/> <!-- Company: ${cmo_company_name} -->
					</templateParameters>
					<header>
						<element label="View all" action="showAll" classes="headerButtonShowAll" tooltip="Show all records"/>
					</header>
					<!-- <selectionModel type="multi" mode="edit" /> -->
				</rowIterator>
			</option>
			<option activeLabel="{@label} Relationships" inactiveLabel="Show Relationships">
				<rowIterator relation="rev_{@relationship}" template="relatedRow.tmpl" emptyMessageKey="No records">
					<templateParameters>
						<parameter name="firstColumnFormat" value="{MNrelationParams/firstColumnFormat}" /> <!-- ParentId: ${{parent_id}} | RelType: ${{cmo_p2p_rel_type}} -->
						<parameter name="secondColumnFormat" value="{MNrelationParams/secondColumnFormat}"/>  <!--  Active: ${{eng_active}} | Updated: ${{eng_mtdt}} -->
					</templateParameters>
					<header>
						<element label="View all" action="showAll" classes="headerButtonShowAll" tooltip="Show all records"/>
						<element action="create" classes="headerButtonActionAdd" tooltip="Create new record">
							<enablement>
								<modes>
									<mode>edit</mode>
								</modes>
							</enablement>
						</element>
						<element action="deactivate" classes="headerButtonActionDeactivate" tooltip="Deactivate selected records">
							<enablement>
								<modes>
									<mode>edit</mode>
									<mode>activation</mode>
								</modes>
								<selection min="1" />
							</enablement>
						</element>
						<element action="activate" classes="headerButtonActionActivate" tooltip="Activate selected records">
		                      <enablement>
		                          <modes>
								  	<mode>edit</mode>
									<mode>activation</mode>
								  </modes>
		                          <selection min="1" />
		                      </enablement>
               			</element>
					</header>
					<selectionModel type="multi"/>
				</rowIterator>
			</option>
		</switchPanel>
	</xsl:template>
		
	<xsl:template match="labeledRelatedList">
		<!-- <xsl:param name="templatePosition"/> -->
		<rowIterator classes="mda-BorderedSection mda-{@templatePosition}ContentMargin" relation="rev_{@relationship}" template="relatedRow.tmpl" labelKey="{@label}" emptyMessageKey="No records">
			<xsl:if test="viewCondition!=''">
				<xsl:attribute name="parts" select="@name"/>
			</xsl:if>
			<templateParameters>
				<parameter name="firstColumnFormat" value="{linkedRecordParams/firstColumnFormat}" /> <!-- {@columnLabel}: {@columnName} -->
				<parameter name="secondColumnFormat" value="{linkedRecordParams/secondColumnFormat}"/> <!-- Company: ${cmo_company_name} -->
			</templateParameters>
			<header>
				<element label="{@label}" classes="" />
				<element label="View all" action="showAll" classes="headerButtonShowAll" tooltip="Show all records"/>
				<element action="create" classes="headerButtonActionAdd" tooltip="Create new record">
					<enablement>
						<modes>
							<mode>edit</mode>
						</modes>
					</enablement>
				</element>
				<element action="deactivate" classes="headerButtonActionDeactivate" tooltip="Deactivate selected records">
					<enablement>
						<modes>
						 	<mode>edit</mode>
							<mode>activation</mode>
						</modes>
						<selection min="1" />
					</enablement>
				</element>
				<element action="activate" classes="headerButtonActionActivate" tooltip="Activate selected records">
                      <enablement>
                          <modes>
						  	<mode>edit</mode>
							<mode>activation</mode>
						  </modes>
                          <selection min="1" />
                      </enablement>
                </element>
			</header>
			<selectionModel type="multi" />
		</rowIterator>
	</xsl:template>
		
	<xsl:template match="listGrid">
		<xsl:param name="masterModels"/>
		<xsl:param name="model_name"/>
		<xsl:param name="table_name"/>
        <switchPanel>
        	<xsl:attribute name="classes">
        		<xsl:text>mda-BorderedSection mda-</xsl:text><xsl:value-of select="fn:replace(@templatePosition,'bottom','leftRight')"/><xsl:text>ContentMargin</xsl:text>
        	</xsl:attribute> 
			<xsl:if test="viewCondition!=''">
				<xsl:attribute name="parts" select="@name"/>
			</xsl:if>
			<xsl:call-template name="option">
				<xsl:with-param name="listGrid" select="."/>
				<xsl:with-param name="masterModels" select="$masterModels"/>
				<xsl:with-param name="model_name" select="$model_name"/>
				<xsl:with-param name="table_name" select="$table_name"/> <!---->
          	</xsl:call-template>
		</switchPanel>
	</xsl:template>

	<xsl:template name="option">
		<xsl:param name="listGrid" />
		<xsl:param name="masterModels"/>
		<xsl:param name="model_name"/>
		<xsl:param name="table_name"/>
		<xsl:for-each select="$listGrid/lists/list">
			<option activeLabel="{@label}" inactiveLabel="{@label}">
				<rowGrid relation="rev_{$listGrid/@relationship}" gridHeight="auto">
				<xsl:if test="@columnMask!=''">
					<xsl:attribute name="columnMask">
						<xsl:value-of select="@columnMask"/>
					</xsl:attribute>
				</xsl:if>
					<columns>
						<xsl:for-each select="columns/column">
							<column name="{@name}"/>
						</xsl:for-each>
	                </columns>
					<actions>
						<action action="openDetail" />
					</actions>
					<!-- matching is on, manualMatch is on and the entity is TLE -->
					<xsl:if test="$masterModels/masterModel[@name=$model_name and guiConfig/actions/@manualExceptions='true']/masterTables/masterTable[@name=$table_name]/@topLevel='true'">
						<xsl:call-template name="manualMatch"/>
	                 </xsl:if>
				</rowGrid>
			</option>
		</xsl:for-each>	
	</xsl:template>

	<xsl:template name="manualMatch">
		<selectionModel type="multi"/>
            <header>
                <element action="instance_split" classes="headerButtonAction-instance-drop" tooltip="Split &amp; isolate instance(s)">
                    <enablement>
                    	<modes>
                        	<mode>view</mode>
                        </modes>
                        <selection min="1" />
                    </enablement>
                </element>
                <element action="instance_merge" classes="headerButtonAction-instance-rebind" tooltip="Merge instance(s)">
                    <enablement>
                        <modes>
                        	<mode>view</mode>
                        </modes>
                        <selection min="1" />
                    </enablement>
                </element>
            </header> 
	</xsl:template>
</xsl:stylesheet>