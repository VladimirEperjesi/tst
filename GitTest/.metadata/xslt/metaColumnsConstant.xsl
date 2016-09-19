<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
<xsl:template match="/*">
	<metaColumns>
		<metaColumn name="id" type="long"/>
		<metaColumn name="event_type" type="string"/>
		<metaColumn name="entity" type="string"/>
		<metaColumn name="layer" type="string"/>
		<metaColumn name="master_view" type="string"/>
		<metaColumn name="origin" type="string"/>
		<metaColumn name="source_system" type="string"/>
		<metaColumn name="activation_date" type="day"/>
		<metaColumn name="creation_date" type="day"/>
		<metaColumn name="deactivation_date" type="day"/>
		<metaColumn name="deletion_date" type="day"/>
		<metaColumn name="last_update_date" type="day"/>
		<metaColumn name="last_source_update_date" type="day"/>		
		<metaColumn name="activation_tid" type="long"/>
		<metaColumn name="creation_tid" type="long"/>
		<metaColumn name="deactivation_tid" type="long"/>
		<metaColumn name="deletion_tid" type="long"/>
		<metaColumn name="last_update_tid" type="long"/>
		<metaColumn name="last_source_update_tid" type="long"/>		
	</metaColumns>
</xsl:template>

</xsl:stylesheet>