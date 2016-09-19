<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>	

	<xsl:param name="thisMatching" select="document('param:thisMatching')/*"/>
	<xsl:param name="settings" select="document('param:settings')/*"/>
	
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$settings/advancedSettings/@matchingCompatibility='false'">
				<xsl:if test="$thisMatching/@matching='true'">
					<xsl:choose>
						<xsl:when test="$thisMatching/multipleMatching/@disableDefault='false'">
							<!-- idKeeperFlagColumn="id_keeper_flag" -->
							<defaultMatchingDefinition name="k" isolateFlagColumn="isolate_flag" masterIdColumn="master_id" rematchFlagColumn="rematch_flag"/>
						</xsl:when>
						<xsl:when test="$thisMatching/multipleMatching/@disableDefault='true'">
							<!-- idKeeperFlagColumn="" -->
							<defaultMatchingDefinition name="" isolateFlagColumn="" masterIdColumn="" rematchFlagColumn=""/>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="$thisMatching/@matching='false'">
					<!-- idKeeperFlagColumn="" -->
					<defaultMatchingDefinition name="" isolateFlagColumn="" masterIdColumn="" rematchFlagColumn=""/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$thisMatching/@matching='true'">
					<xsl:choose>
						<xsl:when test="$thisMatching/multipleMatching/@disableDefault='false'">
							<!-- idKeeperFlagColumn="" -->
							<defaultMatchingDefinition name="" isolateFlagColumn="" masterIdColumn="master_id" rematchFlagColumn=""/>
						</xsl:when>
						<xsl:when test="$thisMatching/multipleMatching/@disableDefault='true'">
							<!-- idKeeperFlagColumn="" -->
							<defaultMatchingDefinition name="" isolateFlagColumn="" masterIdColumn="" rematchFlagColumn=""/>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="$thisMatching/@matching='false'">
					<!-- idKeeperFlagColumn="" -->
					<defaultMatchingDefinition name="" isolateFlagColumn="" masterIdColumn="" rematchFlagColumn=""/>
				</xsl:if>			
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>