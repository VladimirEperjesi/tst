<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<xsl:template match="/*">
	<metaColumns>
		<metaColumn name="id" type="long" layer="master"/>
		<metaColumn name="eng_valid_from" type="date" layer="master"/>
		<metaColumn name="eng_valid_to" type="date" layer="master"/>
		<metaColumn name="eng_active" type="boolean" layer="master"/>
		<metaColumn name="eng_origin" type="string" layer=""/>
		<metaColumn name="eng_source_system" type="string" layer=""/>
		<metaColumn name="eng_source_timestamp" type="date" layer=""/>
	</metaColumns>
</xsl:template>

</xsl:stylesheet>