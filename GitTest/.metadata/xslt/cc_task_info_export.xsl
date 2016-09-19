<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!--bound to /advancedSettings/taskInfoExport  -->
<xsl:template match="/*">
	<plans>
	<xsl:if test="@enable='true'">
		<plan name="{fn:lower-case(@name)}"/>
	</xsl:if>
	</plans>
</xsl:template>
</xsl:stylesheet>