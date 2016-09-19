<?xml version='1.0' encoding='UTF-8'?>
<system name="crm" elemId="22688">
	<description>CRM system</description>
	<model>
		<relationships>
			<relationship name="fk_address_customer" elemId="22785" parentTable="customer" childTable="address">
				<foreignKey>
					<column parentColumn="id" elemId="639797" childColumn="cust_id"/>
				</foreignKey>
			</relationship>
			<relationship name="fk_contact_customer" elemId="37195" parentTable="customer" childTable="contact">
				<foreignKey>
					<column parentColumn="id" elemId="639798" childColumn="cust_id"/>
				</foreignKey>
			</relationship>
			<relationship name="fk_cust_rel1" elemId="37290" parentTable="customer" childTable="customer_relation">
				<foreignKey>
					<column parentColumn="id" elemId="639799" childColumn="customer1_id"/>
				</foreignKey>
			</relationship>
			<relationship name="fk_cust_rel2" elemId="37336" parentTable="customer" childTable="customer_relation">
				<foreignKey>
					<column parentColumn="id" elemId="639800" childColumn="customer2_id"/>
				</foreignKey>
			</relationship>
		</relationships>
		<tables>
			<table name="customer" elemId="22630">
				<description>Customers in the CRM system</description>
				<columns>
					<column description="" name="id" elemId="22784" type="number"/>
					<column description="" name="first_name" elemId="22772" type="varchar2(100)"/>
					<column description="" name="last_name" elemId="109898" type="varchar2(100)"/>
					<column description="" name="birth_date" elemId="37058" type="date"/>
					<column description="" name="type" elemId="107204" type="varchar2(20)"/>
					<column description="" name="gender" elemId="107205" type="varchar2(6)"/>
					<column description="" name="id_card" elemId="38444" type="varchar2(20)"/>
					<column description="" name="sin" elemId="22773" type="varchar2(20)"/>
					<column description="" name="company_name" elemId="107331" type="varchar2(100)"/>
					<column description="" name="business_number" elemId="107332" type="varchar2(20)"/>
					<column description="" name="established_date" elemId="107333" type="date"/>
				</columns>
			</table>
			<table name="address" elemId="22774">
				<description>Postal addresses stored in the CRM system</description>
				<columns>
					<column description="" name="id" elemId="22776" type="number"/>
					<column description="" name="cust_id" elemId="22777" type="number"/>
					<column description="" name="type" elemId="107837" type="varchar(2)"/>
					<column description="" name="street" elemId="22778" type="varchar(100)"/>
					<column description="" name="city" elemId="22779" type="varchar(100)"/>
					<column description="" name="state" elemId="22781" type="varchar(2)"/>
					<column description="" name="zip" elemId="22780" type="varchar(20)"/>
				</columns>
			</table>
			<table name="contact" elemId="37127">
				<description>Customers&#39; contacts stored in the CRM systems. Typical contacts are telephone numbers and emails</description>
				<columns>
					<column description="" name="id" elemId="22776" type="number"/>
					<column description="" name="cust_id" elemId="22777" type="number"/>
					<column description="" name="type" elemId="22780" type="varchar2(30)"/>
					<column description="" name="value" elemId="22779" type="varchar2(100)"/>
				</columns>
			</table>
			<table name="customer_relation" elemId="37241">
				<description>Relationships between two customers</description>
				<columns>
					<column description="" name="id" elemId="37264" type="number"/>
					<column description="" name="customer1_id" elemId="37265" type="number"/>
					<column description="" name="customer2_id" elemId="37266" type="number"/>
					<column description="" name="relation_type" elemId="37267" type="varchar(100)"/>
				</columns>
			</table>
		</tables>
	</model>
	<sourceMappings>
		<mapping entity="party" elemId="149971" table="customer" customOrigin="">
			<description>Customers stored in CRM system
</description>
		</mapping>
		<mapping entity="address" elemId="149972" table="address" customOrigin="">
			<description>Address entries for the customers.</description>
		</mapping>
		<mapping entity="contact" elemId="149973" table="contact" customOrigin="">
			<description>Contact entries for the customers.</description>
		</mapping>
		<mapping entity="rel_party2party" elemId="149974" table="customer_relation" customOrigin="">
			<description>Relation between the customers.</description>
		</mapping>
		<mapping entity="id_document" elemId="26376307" table="customer" customOrigin="">
			<description>Customers&#39; identification documents.</description>
		</mapping>
	</sourceMappings>
	<loadOperations>
		<fullLoad nameSuffix="full" elemId="118392" allTables="false">
			<selectedTables>
				<table name="party" elemId="154025"/>
				<table name="address" elemId="154026"/>
				<table name="contact" elemId="154027"/>
				<table name="rel_party2party" elemId="110149"/>
				<table name="id_document" elemId="26374538"/>
			</selectedTables>
			<advanced deletionStrategy="use global setting (from Preferences)">
				<ignoredComparisonColumns/>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</fullLoad>
		<complexDeltaLoad nameSuffix="delta" elemId="17790350">
			<tableSettings>
				<table keyColumn="source_id" name="party" elemId="17790351" mode="central"/>
				<table keyColumn="party_source_id" name="address" elemId="17790352" mode="party"/>
				<table keyColumn="party_source_id" name="contact" elemId="17790353" mode="party"/>
				<table keyColumn="parent_source_id" name="rel_party2party" elemId="17790354" mode="party"/>
				<table keyColumn="party_source_id" name="id_document" elemId="17790355" mode="party"/>
			</tableSettings>
			<advanced deletionStrategy="use global setting (from Preferences)">
				<partitionedEntities/>
				<ignoredComparisonColumns/>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</complexDeltaLoad>
		<initialLoad nameSuffix="initial" allowLoad="true" elemId="8939" ignorePersistence="">
			<advanced>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</initialLoad>
	</loadOperations>
</system>