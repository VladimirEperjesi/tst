<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<!-- Bound to /logicalModel/dictionary -->
<xsl:template match="/*">
	<genTables>
			<xsl:if test="fn:boolean(tables/table[@loadInst=&#39;true&#39; or @loadMas=&#39;true&#39;])">
			<loadPlan/>
		</xsl:if>
		<xsl:if test="fn:boolean(tables/table[@instUse!=&#39;none&#39; or @usageValidation!='none'])">
			<buildPlan/>
		</xsl:if>
	</genTables>
</xsl:template>

</xsl:stylesheet>