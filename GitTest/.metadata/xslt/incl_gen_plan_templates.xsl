
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg comm">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!-- <xsl:param name="logicalModel" select="document('param:logicalModel')/*"/> -->

<xsl:template name="column_def">
	<xsl:choose>
		<xsl:when test="@type='long_int'"><columnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
		<xsl:otherwise><columnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

 <xsl:template name="column_shadow">
	<xsl:choose>
		<xsl:when test="@type='long_int'"><shadowColumnDef name="{lower-case(@name)}" type="LONG"/></xsl:when>
		<!-- -->  
		<xsl:when test="fn:substring(@name,1,4)='sco_' and @type='integer'"><shadowColumnDef name="{lower-case(@name)}" defaultExpression="0" type="{fn:upper-case(@type)}"/></xsl:when>
		
		<xsl:otherwise><shadowColumnDef name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="column_required">
	<xsl:choose>
		<xsl:when test="@type='long_int'"><requiredColumn name="{lower-case(@name)}" type="LONG"/></xsl:when>
		<xsl:otherwise><requiredColumn name="{lower-case(@name)}" type="{fn:upper-case(@type)}"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- convert LONG_INT to LONG  -->
<xsl:template name="convertType">
	<xsl:choose>
		<xsl:when test="@type='long_int'">LONG</xsl:when>
		<xsl:otherwise><xsl:value-of select="fn:upper-case(@type)"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- add old value column into a plan -->
<xsl:template name="oldValueColumn">
	<xsl:param name="table_name"/>
	<xsl:param name="logicalModel"/>
	<xsl:variable name="column_name" select="@name"/>
	<xsl:variable name="column_type" >
		<xsl:choose>
		<xsl:when test="@type='long_int'">LONG</xsl:when>
		<xsl:otherwise><xsl:value-of select="fn:upper-case(@type)"/></xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:if test="$logicalModel/instanceModel/tables/table[lower-case(@name)=lower-case($table_name)]/advanced/oldValueColumns/column[lower-case(@srcColumn)=lower-case($column_name)]">
		<columnDef name="{lower-case($logicalModel/instanceModel/tables/table[lower-case(@name)=lower-case($table_name)]/advanced/oldValueColumns/column[lower-case(@srcColumn)=lower-case($column_name)]/@name)}" type="{$column_type}"/>
	</xsl:if>
</xsl:template>

<xsl:template name="column_af">
	  <addedColumn name="{lower-case(@name)}" mrg:retainNodes="expression">
		  <xsl:attribute name="type">
			  <xsl:call-template name="convertType"/>
		  </xsl:attribute>
	  </addedColumn>
</xsl:template>

<!-- valid lookup -->
<xsl:template match="column" mode="validLookup">
		<xsl:param name="dictionary"/>
		<xsl:param name="logicalModel"/>
		<xsl:param name="table_name"/>
		<xsl:variable name="valid" select="@refData"/>
		<xsl:variable name="srcDic" select="concat('src_',@refData)"/>
	
	<xsl:choose>
		<xsl:when test="@isSrc='true'">
		    <step id="Validate_{@name}" className="com.ataccama.dqc.tasks.clean.LookupAlgorithm">		  			
				<properties maxDifference="0" tableFileName="pathvar://HUB_RD_LKP/{$valid}_valid.lkp" prefix="false" foreignKeyColumn="{@name}">
					<columns>	
						<columnAssign expression="lookup.master_code" name="{replace(@name,'src_','dic_')}"/>										
					</columns>
					<scorer>
						<scoringEntries>
							<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
							<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
							<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
							<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
							<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
						</scoringEntries>
					</scorer>
					<selectBestMatch/>
					<comm:comment>
            			<xsl:call-template name="generated_step"/>
            		</comm:comment>
				</properties>
			</step>	
		</xsl:when>
		<xsl:otherwise>
		    <step id="Validate_{@name}" className="com.ataccama.dqc.tasks.clean.LookupAlgorithm">		  			
				<properties maxDifference="0" tableFileName="pathvar://HUB_RD_LKP/{$valid}_valid.lkp" prefix="false" foreignKeyColumn="{@name}">
					<columns>	
						<columnAssign expression="lookup.master_code" name="dic_{@name}"/>										
					</columns>
					<scorer>
						<scoringEntries>
							<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
							<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
							<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
							<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
							<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
						</scoringEntries>
					</scorer>
					<selectBestMatch/>
					<comm:comment>
	            		<xsl:call-template name="generated_step"/>
            		</comm:comment>
				</properties>
			</step>			
		</xsl:otherwise>	
	</xsl:choose>
</xsl:template>

<!-- lookup -->
<xsl:template match="column" mode="lookup">
<!-- params are passed only for lookups in load plans -->
<xsl:param name="position"/>
<xsl:param name="system"/>
<xsl:param name="logicalModel"/>
<xsl:param name="table_name"/>
<xsl:param name="dictionary"/>
<xsl:variable name="refDataName" select="@refData"/>	
	
	 <step className="com.ataccama.dqc.tasks.clean.LookupAlgorithm" disabled="false" mode="NORMAL">
		<xsl:attribute name="id">
			<xsl:choose>
				<xsl:when test="@isSrc='false'">			
					<xsl:text>Translate </xsl:text><xsl:value-of select="replace(@name,'dic_','')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Translate </xsl:text><xsl:value-of select="replace(@name,'dic_','src_')"/>
				</xsl:otherwise>	
			</xsl:choose>
		</xsl:attribute>
		
		<xsl:choose>
			<xsl:when test="@isSrc='false'">
				<properties maxDifference="0" prefix="false" foreignKeyColumn="{fn:replace(@name,'dic_','')}" >
				<xsl:choose>
					<!-- load plans -->
					<xsl:when test="$system !=''">
					<xsl:attribute name="tableFileName">
						<xsl:text>pathvar://HUB_RD_LKP/</xsl:text><xsl:value-of select="$refDataName"/><xsl:text>_trans.lkp</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="matchCondition">
						<xsl:text>upper(lookup.source_system)='</xsl:text><xsl:value-of select="fn:upper-case($system/@name)"/><xsl:text>'</xsl:text>
					</xsl:attribute>
					</xsl:when>
					<!-- cleansing plan only -->
					<xsl:otherwise>
					<xsl:attribute name="tableFileName">
						<xsl:text>pathvar://HUB_RD_LKP/</xsl:text><xsl:value-of select="$refDataName"/><xsl:text>_trans.lkp</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="matchCondition">
						<xsl:text>upper(lookup.source_system)=upper(eng_source_system)</xsl:text>
					</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
				<columns>
                	<columnAssign expression="lookup.master_code" name="dic_{@name}"/>
            	</columns>
				<scorer>
					<scoringEntries>
						<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
						<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
						<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
						<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
						<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
					</scoringEntries>
				</scorer>
				<selectBestMatch/>
				<comm:comment>
            		<xsl:call-template name="generated_step"/>
            	</comm:comment>
				</properties>
			</xsl:when>
			<xsl:otherwise>
				<properties maxDifference="0" prefix="false" foreignKeyColumn="{fn:replace(@name,'dic_','src_')}" >
				<xsl:choose>
					<!-- load plans -->
					<xsl:when test="$system !=''">
					<xsl:attribute name="tableFileName">
						<xsl:text>pathvar://HUB_RD_LKP/</xsl:text><xsl:value-of select="$refDataName"/><xsl:text>_trans.lkp</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="matchCondition">
						<xsl:text>upper(lookup.source_system)='</xsl:text><xsl:value-of select="fn:upper-case($system/@name)"/><xsl:text>'</xsl:text>
					</xsl:attribute>
					</xsl:when>
					<!-- cleansing plan only -->
					<xsl:otherwise>
					<xsl:attribute name="tableFileName">
						<xsl:text>pathvar://HUB_RD_LKP/</xsl:text><xsl:value-of select="$refDataName"/><xsl:text>_trans.lkp</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="matchCondition">
						<xsl:text>upper(lookup.source_system)=upper(eng_source_system)</xsl:text>
					</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
				<columns>
                	<columnAssign expression="lookup.master_code" name="{replace(@name,'src_','dic_')}"/>
            	</columns>
				<scorer>
					<scoringEntries>
						<scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
						<scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
						<scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
						<scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
						<scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
					</scoringEntries>
				</scorer>
				<selectBestMatch/>
				<comm:comment>
            		<xsl:call-template name="generated_step"/>
            	</comm:comment>
				</properties>
			</xsl:otherwise>
		</xsl:choose>
			
				<visual-constraints layout="vertical">
					<xsl:choose>
					<!-- load plans -->
					<xsl:when test="$system !=''">
					<xsl:attribute name="bounds">
						<xsl:value-of select="(($position)*336)+48"/><xsl:text>,288,-1,-1</xsl:text>
					</xsl:attribute>
					</xsl:when>
					<!-- cleansing plan only -->
					<xsl:otherwise>
						<visual-constraints layout="vertical" bounds="216,264,-1,-1"/>
					</xsl:otherwise>
					</xsl:choose>
				</visual-constraints>
			</step>
</xsl:template>

<!-- <xsl:template match="column" mode="lookupInCleansePlan">
 <step className="com.ataccama.dqc.tasks.clean.LookupAlgorithm" disabled="false" mode="NORMAL">
	<xsl:attribute name="id">
			<xsl:variable name="colName" select="fn:replace(@name,'dic_','')"/>
			<xsl:choose>
				<xsl:when test="count(ancestor::physicalTable/columns/column[@dic=current()/@dic])>1">
					<xsl:text>Lookup </xsl:text><xsl:value-of select="@dic"/><xsl:text> on column </xsl:text><xsl:value-of select="$colName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Lookup </xsl:text><xsl:value-of select="@dic"/>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:attribute> 
	<properties maxDifference="0" tableFileName="../../../data/ext/lkp/referenceData/{@dic}_trans.lkp" foreignKeyColumn="{fn:replace(@name,'dic_','src_')}"  matchCondition="upper(lookup.source_system)=upper(eng_source_system)">
          <columns>
  				<columnAssign expression="lookup.master_code" name="{@name}"/>
		  </columns>
          <scorer>
              <scoringEntries>
                  <scoringEntry score="0" explainAs="LKP_NULL_ID" explain="true" key="LKP_NULL_ID"/>
                  <scoringEntry score="0" explainAs="LKP_NOT_FOUND" explain="true" key="LKP_NOT_FOUND"/>
                  <scoringEntry score="0" explainAs="LKP_FOUND" explain="true" key="LKP_FOUND"/>
                  <scoringEntry score="0" explainAs="LKP_FOUND_DUPL" explain="true" key="LKP_FOUND_DUPL"/>
                  <scoringEntry score="0" explainAs="LKP_APPROX_USED" explain="true" key="LKP_APPROX_USED"/>
              </scoringEntries>
          </scorer>
          <selectBestMatch/>
           <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
      </properties>
      <visual-constraints layout="vertical" bounds="216,264,-1,-1"/>
  </step>
</xsl:template> -->

</xsl:stylesheet>
