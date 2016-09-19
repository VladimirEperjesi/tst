<?xml version='1.0' encoding='UTF-8'?>
<system name="invest" elemId="13231">
	<description></description>
	<model>
		<relationships>
			<relationship name="product_is_part_of" elemId="14149" parentTable="product" childTable="product_hierarchy">
				<foreignKey/>
			</relationship>
		</relationships>
		<tables>
			<table name="product_hierarchy" elemId="14141">
				<description></description>
				<columns/>
			</table>
			<table name="product" elemId="14145">
				<description></description>
				<columns/>
			</table>
		</tables>
	</model>
	<sourceMappings>
		<mapping entity="product" elemId="14584" table="product" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="rel_prod2prod" elemId="14585" table="product_hierarchy" customOrigin="">
			<description></description>
		</mapping>
	</sourceMappings>
	<loadOperations>
		<fullLoad nameSuffix="full" elemId="13708" allTables="true">
			<selectedTables/>
			<advanced deletionStrategy="use global setting (from Preferences)">
				<ignoredComparisonColumns/>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</fullLoad>
		<initialLoad nameSuffix="initial" allowLoad="true" elemId="15020" ignorePersistence="">
			<advanced>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</initialLoad>
	</loadOperations>
</system>