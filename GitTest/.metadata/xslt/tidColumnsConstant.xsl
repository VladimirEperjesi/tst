<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<xsl:template match="/*">
	<tidColumns>
		<tidColumn name="eng_creation_tid" type="long"/>
		<tidColumn name="eng_deletion_tid" type="long"/>
		<tidColumn name="eng_last_update_tid" type="long"/>
		<tidColumn name="eng_last_source_update_tid" type="long"/>
		<tidColumn name="eng_activation_tid" type="long"/>
		<tidColumn name="eng_deactivation_tid" type="long"/>
	</tidColumns>
</xsl:template>

</xsl:stylesheet>