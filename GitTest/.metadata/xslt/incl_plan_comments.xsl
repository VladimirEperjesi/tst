<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!-- GENERATED STEP WARNING -->
<xsl:template name="generated_step">
<xsl:text>DO NOT ALTER! This step was automatically generated from the model. Your changes will be discarded when you re-generate this plan!</xsl:text>
</xsl:template>

<!-- PARTLY-GENERATED STEP WARNING -->
<xsl:template name="generated_AFmapping_step">
<xsl:text>BE CAREFUL WHEN EDITING! This step was automatically pre-generated from the model. Your are allowed to complete the attribute mapping on Added Columns tab only (i.e. fill the Expression column in). This content will be preserved even if listed attributes changed. Other changes will be discarded.</xsl:text>
</xsl:template>


<!-- CLEANSING PLAN -->
<xsl:template name="cleansing_plan_comment">
<xsl:text>•	Create or add logic to cleanse attributes. 
•	Then store the result into std values  (best cleansed value) or optionally also into cio values (cleansed instance output – best value available created as nvl(std_xxx, precleansed value or potentionally src_xxx). 
•	If translation dictionary used (dic_ prefixed values available in this plan), map the dic values into appropriate std and/or cio attributes to complete the dictionary translation process.
•	Also you can store scores or explanations.
Warning: there shouldn’t be any aggregation logic used</xsl:text>
</xsl:template>

<!-- MATCHING PLAN -->
<xsl:template name="matching_plan_comment">
<xsl:param name="master_column"/>
<xsl:text>Please insert Matching step and follow the instructions below:
•	Almost all Column Bindings are used according to the Match operation definition of this entity in the Logical Model/Instance Model.
•	It is recommended to choose the appropriate column and map it to the Rule Name (e.g. rule_name) on the Column Bindings tab in the Matching step. 
Warning: there shouldn’t be any aggregation logic used
</xsl:text>
</xsl:template>

<!-- AGGREGATION PLAN -->
<xsl:template name="aggregation_plan_comment">
<xsl:param name="master_column"/>
<xsl:variable name="master">
	<xsl:choose>
	<xsl:when test="$master_column != ''"><xsl:value-of select="$master_column"/></xsl:when>
	<xsl:otherwise>master_id</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<xsl:text>Usually the Representative Creator step is used with the following settings:
•	Always use out endpoint of the step
•	Grouping column that is defined for this entity in the Logical Model/Instance Model has to be used as the Representative Creator Grouping Strategy (Key)
•	Add Rule then define Attribute Set (one set is usually enough)
•	Define Instance Attributes along with aggregation output columns definition in the Instance Model </xsl:text>
</xsl:template>

<!-- MERGING PLAN -->
<xsl:template name="merging_plan_comment">
<xsl:param name="master_column"/>
<xsl:variable name="master">
	<xsl:choose>
	<xsl:when test="$master_column != ''"><xsl:value-of select="$master_column"/></xsl:when>
	<xsl:otherwise>master_id</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<xsl:text>Please insert Representative Creator step and use setting below for mentioned attributes 
•	Always use out_merged endpoint of the step
•	</xsl:text>
<xsl:value-of select="$master"/>
<xsl:text> grouping column has to be used as the Representative Creator Grouping Strategy (Key) (</xsl:text>
<xsl:value-of select="$master"/>
<xsl:text> grouping column related record descriptor can be used instead)
•	Add Rule then define Attribute Set (one or more sets)
•	Define Representative Attributes  along  out endpoint definition 
•	id column has to be always populated by </xsl:text>
<xsl:value-of select="$master"/>
</xsl:template>



<!-- LOAD PLAN -->
<xsl:template name="load_plan_comment">
<xsl:text>•	Drag and drop your extract sources and connect them to appropriate data flow. Then complete mapping in map_&lt;entity&gt;</xsl:text>
<xsl:value-of select="@name"/>
<xsl:text>_source_columns step to load data into MDM Hub.
•	Delta load: change type I/U/D is expected to be mapped into change_type column (it doesn't matter whether I/U is used, because upsert is performed)
</xsl:text>
</xsl:template>


<!-- DICTIONARY LOAD PLAN -->
<xsl:template name="dictionary_load_plan_comment">
<xsl:param name="systems"/>
<xsl:text>•	Drag and drop your extract sources and connect them to appropriate data flow. Then complete mapping in map_&lt;entity&gt;</xsl:text>
<xsl:value-of select="@name"/>
<xsl:text>_source_columns step to load data into MDM Hub.</xsl:text><xsl:text>
•	Delta load: change type I/U/D is expected to be mapped into change_type column (it doesn't matter whether I/U is used, because upsert is performed)
•	Translation dictionary uses cleanse/source system names. Incoming and MDM Connected System names should match! There is a list of Connected systems defined:
	</xsl:text>
<xsl:for-each select="$systems/system">
	<xsl:value-of select="fn:upper-case(@name)"/>
	<xsl:if test="position()!=last()">
		<xsl:text>, </xsl:text>
	</xsl:if>	
</xsl:for-each>
	

</xsl:template>
</xsl:stylesheet>
