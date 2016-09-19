<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>	

	<xsl:template match="/">
	<guiConstants>
		<guiLookups>
			<guiLookup name="WINDOW" label="Pop-up Window"/>
			<guiLookup name="COMBO" label="Combo Box"/>
		</guiLookups>
		<guiAttributeFormats>
			<guiAttributeFormat name="yyyy-MM-dd" label="Day format: yyyy-MM-dd" dqcType="day"/>
			<guiAttributeFormat name="yyyy/MM/dd" label="Day format: yyyy/MM/dd" dqcType="day"/>
			<guiAttributeFormat name="yyyy.MM.dd" label="Day format: yyyy.MM.dd" dqcType="day"/>
			<guiAttributeFormat name="yyyy-MMM-dd" label="Day format: yyyy-MMM-dd" dqcType="day"/>
			<guiAttributeFormat name="yyyy-MM-dd HH:mm:ss" label="Datetime format: yyyy-MM-dd HH:mm:ss " dqcType="datetime"/>
			<guiAttributeFormat name="yyyy/MM/dd HH:mm:ss" label="Datetime format: yyyy/MM/dd HH:mm:ss" dqcType="datetime"/>
			<guiAttributeFormat name="yyyy.MM.dd HH:mm:ss" label="Datetime format: yyyy.MM.dd HH:mm:ss" dqcType="datetime"/>
			<!-- <guiAttributeFormat name="0000" label="Nulls from left to 4 characters" dqcType="integer"/>
			<guiAttributeFormat name="#,###" label="Thousands separator: #,###" dqcType="anyNumber"/>
			<guiAttributeFormat name="####" label="Without thousands separator: ####" dqcType="anyNumber"/>
			<guiAttributeFormat name="#,###.0" label="Thousands separator and 1 decimal point : #,###.0" dqcType="float"/>
			<guiAttributeFormat name="#,###.#" label="Thousands separator and at least 1 decimal point : #,###.#" dqcType="float"/>
			<guiAttributeFormat name="#,###.##" label="Thousands separator and max. 2 decimal points : #,###.##" dqcType="float"/>	
			<guiAttributeFormat name="#,###.0#" label="Thousands separator and at least 1 but max. 2 decimal points : #,###.0#" dqcType="float"/>
			<guiAttributeFormat name="####.0" label="Without thousands separator and 1 decimal point : ####.0" dqcType="float"/>
			<guiAttributeFormat name="####.#" label="Without thousands separator and at least 1 decimal point : ####.#" dqcType="float"/>
			<guiAttributeFormat name="####.##" label="Without thousands separator and max. 2 decimal points : ####.##" dqcType="float"/>	
			<guiAttributeFormat name="####.0#" label="Without thousands separator and at least 1 but max. 2 decimal points : ####.0#" dqcType="float"/> -->
		</guiAttributeFormats> 
	</guiConstants>	
	</xsl:template>

</xsl:stylesheet>