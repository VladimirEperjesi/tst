<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:a="attribute" xmlns:c="collection" xmlns:o="object"
	exclude-result-prefixes="sf fn a c o">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:include href="incl_general_templates.xsl" />

<xsl:template match="/Model/o:RootObject/c:Children/o:Model[1]">
<xsl:variable name="type">
	<xsl:choose>
		<xsl:when test="c:LogicalDiagrams">logical</xsl:when>
		<xsl:when test="c:PhysicalDiagrams">physical</xsl:when>
		<xsl:when test="c:ConceptualDiagrams">conceptual</xsl:when>
		<xsl:otherwise>unknown</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<instanceModel>
		<xsl:if test="$type='physical' or $type='logical'">
		<tables>
			<!-- LOGICAL MODEL -->	
			<xsl:apply-templates select="c:Entities/o:Entity[fn:lower-case(a:Stereotype)='instance' or (fn:lower-case(a:Stereotype)!='master' and fn:lower-case(a:Stereotype)!='dictionary' and fn:lower-case(a:Stereotype)!='reference_data') ]">
				<xsl:with-param name="relationships" select="c:Relationships"/>
			</xsl:apply-templates>
			<!-- PHYSICAL MODEL -->	
			<xsl:apply-templates select="c:Tables/o:Table[fn:lower-case(a:Stereotype)='instance' or (fn:lower-case(a:Stereotype)!='master' and fn:lower-case(a:Stereotype)!='dictionary' and fn:lower-case(a:Stereotype)!='reference_data')]" >
					<xsl:with-param name="relationships" select="c:References"/>
				</xsl:apply-templates>
		</tables>
		<dicTables>
			<!-- LOGICAL MODEL -->	
			<xsl:apply-templates select="c:Entities/o:Entity[fn:lower-case(a:Stereotype)='dictionary' or (fn:lower-case(a:Stereotype)!='master' and fn:lower-case(a:Stereotype)!='instance' and fn:lower-case(a:Stereotype)!='reference_data' and fn:lower-case(a:Stereotype)!='')]" >
				<xsl:with-param name="relationships" select="c:Relationships"/>
			</xsl:apply-templates>
			<!-- PHYSICAL MODEL -->	
			<xsl:apply-templates select="c:Tables/o:Table[fn:lower-case(a:Stereotype)='dictionary' or (fn:lower-case(a:Stereotype)!='master' and fn:lower-case(a:Stereotype)!='instance' and fn:lower-case(a:Stereotype)!='reference_data' and fn:lower-case(a:Stereotype)!='')]" >
					<xsl:with-param name="relationships" select="c:References"/>
			</xsl:apply-templates>
		</dicTables>		
		</xsl:if>
	
	<relationships>
		<!-- LOGICAL MODEL -->	
		<xsl:apply-templates select="c:Relationships/o:Relationship" >
			<xsl:with-param name="entities" select="c:Entities"/>
		</xsl:apply-templates>
		<!-- PHYSICAL MODEL -->	
		<xsl:apply-templates select="c:References/o:Reference" >
			<xsl:with-param name="entities" select="c:Tables"/>
		</xsl:apply-templates>
	</relationships>
	
</instanceModel>
</xsl:template>

<xsl:template match="o:Entity"  >
<xsl:param name="relationships"/>
<xsl:param name="extendedAttributes"/>
<xsl:variable name="entity" select="."/>
		<table name="{a:Code}" description="{a:Comment}" label="{a:Name}">
			<xsl:attribute name="type">
				<xsl:choose>
					<!-- <xsl:when test="fn:lower-case(a:Stereotype) ='reference_data'">dictionary</xsl:when> -->
					<xsl:when test="a:Stereotype != ''"><xsl:value-of select="a:Stereotype"/></xsl:when>
					<xsl:otherwise>instance</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<columns>
			<xsl:apply-templates select="c:Attributes/o:EntityAttribute">
					<xsl:with-param name="identifiers" select="c:Identifiers"/>
					<xsl:with-param name="primary" select="c:PrimaryIdentifier"/>
					<xsl:with-param name="relationships" select="$relationships"/>
					
				</xsl:apply-templates>
				<!-- SUB entities -->
				<xsl:apply-templates select="c:SubEntities/o:Entity/c:Attributes/o:EntityAttribute[a:Displayed !=0 or not(a:Displayed)]">
					<xsl:with-param name="identifiers" select="c:Identifiers"/>
					<xsl:with-param name="primary" select="c:PrimaryIdentifier"/>
					<xsl:with-param name="relationships" select="$relationships"/>
				</xsl:apply-templates>
			</columns>
		</table>
</xsl:template>

<xsl:template match="o:Table" >
<xsl:param name="relationships"/>
	<table name="{a:Code}" description="{a:Comment}" label="{a:Name}">
		<xsl:attribute name="type">
			<xsl:choose>
				<xsl:when test="a:Stereotype"><xsl:value-of select="sf:nvl(a:Stereotype,'instance')"/></xsl:when>
				<xsl:otherwise>instance</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<columns>
			<xsl:apply-templates select="c:Columns/o:Column">
				<xsl:with-param name="identifiers" select="c:Keys"/>
				<xsl:with-param name="primary" select="c:PrimaryKey"/>
				<xsl:with-param name="relationships" select="$relationships"/>
			</xsl:apply-templates>
		</columns>
	</table>
</xsl:template>

<xsl:template match="o:EntityAttribute">
<xsl:param name="identifiers"/>
<xsl:param name="primary"/>
<xsl:param name="relationships"/>
<xsl:variable name="extendedAttributes" select="a:ExtendedAttributesText/text()"/>
<xsl:variable name="pkIdentifier" select="$primary/o:Identifier/@Ref"/>
<xsl:variable name="identifier" select="$identifiers/o:Identifier[c:Identifier.Attributes/o:EntityAttribute/@Ref=current()/@Id]/@Id"/>
<!--<xsl:variable name="isFk" select="not($pkIdentifier=$identifier) and $relationships/o:Relationship[*/o:Entity/@Ref=current()/ancestor::o:Entity/@Id]/c:Joins/o:RelationshipJoin/*/o:EntityAttribute[@Ref=current()/@Id]">-->
<!--<xsl:variable name="parent" select="ancestor::c:Entities/o:Entity[c:Identifiers/o:Identifier/@Id=current()/c:ParentIdentifier/o:Identifier/@Ref]/@Id"/>-->
<xsl:variable name="isChild" select="$relationships/o:Relationship[*/o:Entity/@Ref=current()/ancestor::o:Entity/@Id and c:ParentIdentifier/o:Identifier/@Ref!=current()/ancestor::o:Entity/c:Identifiers/o:Identifier/@Id]"/>
<xsl:variable name="isFk" select="$relationships/o:Relationship[*/o:Entity/@Ref=current()/ancestor::o:Entity/@Id]/c:Joins/o:RelationshipJoin/*/o:EntityAttribute[@Ref=current()/@Id]">
</xsl:variable>

	<column name="{a:Code}" description="{a:Comment}" size="{a:Length}" label="{a:Name}">
		<xsl:attribute name="isPk">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isFk">
			<!--<xsl:if test="$isFk">true</xsl:if><xsl:if test="not($isFk)">false</xsl:if>-->
			<xsl:choose>
				<xsl:when test="$isFk and $isChild">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSrc">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSRC,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSRC,4')">true</xsl:when>  
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isStd">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSTD,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSTD,4')">true</xsl:when>  
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isCio">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isCIO,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isCIO,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isExp">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isEXP,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isEXP,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSco">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSCO,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSCO,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>   
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:call-template name="convertLogicalType">
				<xsl:with-param name="type" select="a:DataType"/>
				<xsl:with-param name="size" select="a:Length"/>
				<xsl:with-param name="precision" select="a:Precision"/>
			</xsl:call-template>
		</xsl:attribute>
	</column>
</xsl:template>

<xsl:template match="o:Column">
<xsl:param name="identifiers"/>
<xsl:param name="primary"/>
<xsl:param name="relationships"/>
<xsl:variable name="extendedAttributes" select="a:ExtendedAttributesText/text()"/>
<xsl:variable name="pkIdentifier" select="$primary/o:Key/@Ref"/>
<xsl:variable name="identifier" select="$identifiers/o:Key[c:Key.Columns/o:Column/@Ref=current()/@Id]/@Id"/>
<!--<xsl:variable name="isFk" select="not($pkIdentifier=$identifier) and $relationships/o:Reference[*/o:Table/@Ref=current()/ancestor::o:Table/@Id]/c:Joins/o:ReferenceJoin/*/o:Column[@Ref=current()/@Id]">-->
<xsl:variable name="isChild" select="boolean($relationships/o:Reference[*/o:Table/@Ref=current()/ancestor::o:Table/@Id and c:ParentKey/o:Key/@Ref!=current()/ancestor::o:Table/c:Keys/o:Key/@Id])"/>
<xsl:variable name="isFk" select="boolean($relationships/o:Reference[*/o:Table/@Ref=current()/ancestor::o:Table/@Id]/c:Joins/o:ReferenceJoin/*/o:Column[@Ref=current()/@Id])">
</xsl:variable>
	<column name="{a:Code}" description="{a:Comment}" size="{a:Length}" label="{a:Name}">
		<xsl:attribute name="isPk">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isFk">
			<!--<xsl:value-of select="$isFk"/><xsl:value-of select="$isChild"/>-->
			<xsl:choose>
				<xsl:when test="$isFk and $isChild">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSrc">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSRC,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSRC,4')">true</xsl:when>  
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isStd">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSTD,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSTD,4')">true</xsl:when>  
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isCio">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isCIO,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isCIO,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isExp">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isEXP,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isEXP,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="isSco">
			<xsl:choose>
				<xsl:when test="$pkIdentifier=$identifier or $isFk">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSCO,5')">false</xsl:when>
				<xsl:when test="contains($extendedAttributes,'isSCO,4')">true</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>   
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="type">
			<xsl:call-template name="convertPhysicalType">
				<xsl:with-param name="type" select="a:DataType"/>
				<xsl:with-param name="size" select="a:Length"/>
				<xsl:with-param name="precision" select="a:Precision"/>
			</xsl:call-template>
		</xsl:attribute>
	</column>
</xsl:template>

<!-- RELATIONSHIPS -->
<xsl:template match="o:Relationship">
<xsl:param name="entities"/>
<xsl:variable name="parent" select="$entities/o:Entity[c:Identifiers/o:Identifier/@Id=current()/c:ParentIdentifier/o:Identifier/@Ref]/a:Code"/>
<xsl:variable name="child">
	<!-- parent and child are different entities -->
	<xsl:choose>
		<xsl:when test="$entities/o:Entity[@Id=current()/*/o:Entity/@Ref and a:Code!=$parent]">
			<xsl:value-of select="$entities/o:Entity[@Id=current()/*/o:Entity/@Ref and a:Code!=$parent]/a:Code"/>
		</xsl:when>
	<!-- child table is inherited by other table - child must be the top level table -->	
		<xsl:when test="$entities/o:Entity/c:SubEntities/o:Entity[@Id=current()/*/o:Entity/@Ref] ">
			<xsl:value-of select="$entities/o:Entity[c:SubEntities/o:Entity[@Id=current()/*/o:Entity/@Ref]]/a:Code"/>
		</xsl:when>
	<!-- parent and child is the same entity -->
		<xsl:when test="c:Object1/o:Entity[@Ref=current()/c:Object2/o:Entity/@Ref]"><xsl:value-of select="$parent"/></xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:variable> 
<!--<xsl:variable name="parentColumn" select="$entities/o:Entity[a:Code=$parent]/c:Attributes/o:EntityAttribute[@Id=../../c:Identifiers/o:Identifier[@Id=../../c:PrimaryIdentifier/o:Identifier/@Ref]/c:Identifier.Attributes/o:EntityAttribute/@Ref]/a:Code"/>-->
<xsl:variable name="parentColumnId" select="$entities/o:Entity[a:Code=$parent]/c:Attributes/o:EntityAttribute[@Id=../../c:Identifiers/o:Identifier[@Id=../../c:PrimaryIdentifier/o:Identifier/@Ref]/c:Identifier.Attributes/o:EntityAttribute/@Ref]/@Id"/>
<xsl:variable name="parentNode" select="$entities/o:Entity[a:Code=$parent]/c:Attributes[o:EntityAttribute/@Id=../../c:Identifiers/o:Identifier[@Id=../../c:PrimaryIdentifier/o:Identifier/@Ref]/c:Identifier.Attributes/o:EntityAttribute/@Ref]"/>
<!--<xsl:variable name="childColumn" select="$entities/o:Entity[a:Code=$child]/c:Attributes/o:EntityAttribute[@Id = current()/c:Joins/o:RelationshipJoin/*/o:EntityAttribute[@Ref !=$parentColumnId]/@Ref ]/a:Code"/>
<xsl:variable name="subChildColumn" select="$entities/o:Entity[a:Code=$child]/c:SubEntities/o:Entity[@Id=current()/*/o:Entity/@Ref]/c:Attributes/o:EntityAttribute[@Id = current()/c:Joins/o:RelationshipJoin/*/o:EntityAttribute[@Ref !=$parentColumnId]/@Ref ]/a:Code"/>
-->
<xsl:variable name="childNode" select="$entities/o:Entity[a:Code=$child]/c:Attributes/o:EntityAttribute[@Id = current()/c:Joins/o:RelationshipJoin/*/o:EntityAttribute[@Ref !=$parentColumnId]/@Ref ]"/>
	
	
	<xsl:if test="a:Stereotype/text()='instance' or not(a:Stereotype) or a:Stereotype=''">  
	<relationship name="{a:Code}"   parentTable="{$parent}" childTable="{$child}" description="{a:Comment}" >
		<foreignKey><!-- DODELAT SKLADANE KLICE -->
			<xsl:for-each select="c:Joins/o:RelationshipJoin">
				<xsl:variable name="childColumn" select="$entities/o:Entity[a:Code=$child]/c:Attributes/o:EntityAttribute[@Id = current()/*/o:EntityAttribute[@Ref !=$parentColumnId]/@Ref ]/a:Code"/>
				<xsl:variable name="subChildColumn" select="$entities/o:Entity[a:Code=$child]/c:SubEntities/o:Entity[@Id=current()/*/o:Entity/@Ref]/c:Attributes/o:EntityAttribute[@Id = current()/*/o:EntityAttribute[@Ref !=$parentColumnId]/@Ref ]/a:Code"/>
				<xsl:variable name="position" select="position()"/>
					
				<column parentColumn="{$entities/o:Entity[a:Code=$parent]/c:Attributes/o:EntityAttribute[@Id=current()/*/o:EntityAttribute[@Ref =$parentColumnId]/@Ref ]/a:Code}" childColumn="{$childColumn|$subChildColumn}"></column>
			</xsl:for-each>	
		</foreignKey> 
	</relationship>
	</xsl:if>
	
</xsl:template>

<xsl:template match="o:Reference">
<xsl:param name="entities"/>
<xsl:variable name="parent" select="$entities/o:Table[@Id=current()/c:ParentTable/o:Table/@Ref]/a:Code"/>
<xsl:variable name="child" select="$entities/o:Table[@Id=current()/c:ChildTable/o:Table/@Ref]/a:Code"/>
<!--<xsl:variable name="parentKey" select="$entities/o:Table[a:Code=$parent]/c:Keys/o:Key[@Id=current()/c:ParentKey/o:Key/@Ref]/c:Key.Columns/o:Column/@Ref"/>
<xsl:variable name="parentColumn" select="$entities/o:Table[a:Code=$parent]/c:Columns/o:Column[@Id=$parentKey]/a:Code"/>-->
<xsl:variable name="parentKey" select="$entities/o:Table[a:Code=$parent]/c:Keys/o:Key[@Id=current()/c:ParentKey/o:Key/@Ref]/c:Key.Columns/o:Column/@Ref"/>
	<xsl:if test="a:Stereotype/text()='instance' or not(a:Stereotype) or a:Stereotype=''">   
	<relationship name="{a:Code}"   parentTable="{$parent}" childTable="{$child}" description="{a:Comment}">
		<foreignKey><!-- DODELAT SKLADANE KLICE -->
			<xsl:for-each select="c:Joins/o:ReferenceJoin">
			
			<xsl:variable name="parentColumn" select="$entities/o:Table[a:Code=$parent]/c:Columns/o:Column[@Id=$parentKey]/a:Code"/>
		
			<!--<column parentColumn="{$parentColumn}" childColumn="{$entities/o:Table[a:Code=$child]/c:Columns/o:Column[@Id=current()/c:Joins/o:ReferenceJoin/*/o:Column/@Ref and @Id != $parentKey]/a:Code}"/>-->
				<column parentColumn="{$entities/o:Table[a:Code=$parent]/c:Columns/o:Column[@Id=current()/*/o:Column/@Ref and @Id = $parentKey]/a:Code}" childColumn="{$entities/o:Table[a:Code=$child]/c:Columns/o:Column[@Id=current()/*/o:Column/@Ref and @Id != $parentKey]/a:Code}"/>
			</xsl:for-each>	
		</foreignKey> 
	</relationship>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>