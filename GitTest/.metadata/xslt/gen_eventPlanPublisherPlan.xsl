<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf fn comm" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:comm="http://www.ataccama.com/purity/comment" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml"/>
<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:param select="document(&#39;param:databaseModel&#39;)/*" name="databaseModel"/>
<xsl:param select="document(&#39;param:eventHandler&#39;)/*" name="eventHandler"/>

<xsl:template match="/*">
	<purity-config version="{$version}">
		<xsl:variable name="stepID">
			<xsl:choose>
				<xsl:when test="@layerName='instance'">
					<xsl:value-of select="lower-case(entityName/@entity)"/>
				</xsl:when>
				<xsl:otherwise>				
					<xsl:value-of select="lower-case(@layerName)"/>
					<xsl:value-of select="'.'"/>
					<xsl:value-of select="lower-case(entityName/@entity)"/>				
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<step id="{$stepID}" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
	        <properties>
	            <columns>
	            <xsl:variable select="@layerName" name="layer"/>
	            <xsl:variable select="entityName/@entity" name="entity"/>
	            	<xsl:choose>
		            	<xsl:when test="entityName/@allColumns=&#39;true&#39;">
		            		<xsl:for-each select="$eventHandler/metaColumns/metaColumn">
		            			<columnDef name="meta_{@name}" type="{if(@type='long_int') then 'LONG' else upper-case(@type)}"/>
		            		</xsl:for-each>
		            	
		            		<xsl:for-each select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entity) and $layer='instance']/columns/column">
	            				<columnDef name="new_{@name}" type="{if(@type='long_int') then 'LONG' else upper-case(@type)}"/>
	            				<columnDef name="old_{@name}" type="{if(@type='long_int') then 'LONG' else upper-case(@type)}"/>	            			
		            		</xsl:for-each>
		     
		            		<xsl:for-each select="$databaseModel/masterTables/physicalTable[@layerName=lower-case($layer) and @name=lower-case($entity)]/columns/column">
	            				<columnDef name="new_{@name}" type="{if(@type='long_int') then 'LONG' else upper-case(@type)}"/>
	            				<columnDef name="old_{@name}" type="{if(@type='long_int') then 'LONG' else upper-case(@type)}"/>	            			
		            		</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>																								
							<xsl:for-each select="columns/column">
								<xsl:if test="$layer='instance'">
									<xsl:variable name="columnName" select="@name"/>								
									<xsl:variable name="type" select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entity) and $layer='instance']/columns/column[@name=lower-case($columnName)]/@type"/>
									<xsl:variable name="name" select="$databaseModel/instanceTables/physicalTable[@name=lower-case($entity) and $layer='instance']/columns/column[@name=lower-case($columnName)]/@name"/>
									<xsl:if test="@new=&#39;true&#39;">
			            				<columnDef name="new_{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
			            			<xsl:if test="@old=&#39;true&#39;">
			            				<columnDef name="old_{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
			            			<xsl:if test="@old = &#39;false&#39; and @new = &#39;false&#39;">
			            				<columnDef name="{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
		            			</xsl:if>
		            			<xsl:if test="$layer!='instance'">
									<xsl:variable name="columnName" select="@name"/>								
									<xsl:variable name="type" select="$databaseModel/masterTables/physicalTable[@layerName=lower-case($layer) and @name=lower-case($entity)]/columns/column[@name=lower-case($columnName)]/@type"/>
									<xsl:variable name="name" select="$databaseModel/masterTables/physicalTable[@layerName=lower-case($layer) and @name=lower-case($entity)]/columns/column[@name=lower-case($columnName)]/@name"/>
									<xsl:if test="@new=&#39;true&#39;">
			            				<columnDef name="new_{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
			            			<xsl:if test="@old=&#39;true&#39;">
			            				<columnDef name="old_{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
			            			<xsl:if test="@old = &#39;false&#39; and @new = &#39;false&#39;">
			            				<columnDef name="{@name}" type="{if($type='long_int') then 'LONG' else upper-case($type)}"/>
			            			</xsl:if>
		            			</xsl:if>
		            		</xsl:for-each>				                 
			            		
			            	<xsl:for-each select="columnsMeta/columnMeta">			
			            		<xsl:variable name="metaColumnName" select="replace(@name,'meta_','')"/>			            		
								<xsl:variable name="type" select="$eventHandler/metaColumns/metaColumn[@name=$metaColumnName]/@type"/>			            																			
								<columnDef name="{lower-case(@name)}" type="{upper-case($type)}"/>								
							</xsl:for-each>
							
						</xsl:otherwise>
					</xsl:choose>			
				</columns>
				<shadowColumns/>
				<comm:comment>
            		<xsl:call-template name="generated_step"/>
            	</comm:comment>
	        </properties>
	        <visual-constraints layout="vertical">
				<xsl:attribute name="bounds">
					<xsl:text>1,72,-1,-1</xsl:text>
				</xsl:attribute>
			</visual-constraints>
	    </step>

	</purity-config>
</xsl:template>

</xsl:stylesheet> 