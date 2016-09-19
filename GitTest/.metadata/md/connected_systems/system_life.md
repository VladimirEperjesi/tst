<?xml version='1.0' encoding='UTF-8'?>
<system name="life" elemId="34731">
	<description>Life insurance system</description>
	<model>
		<relationships>
			<relationship name="product_is_bound_on_contract" elemId="37503" parentTable="product" childTable="contract">
				<foreignKey>
					<column parentColumn="ID" elemId="639801" childColumn="PRODUCT"/>
				</foreignKey>
			</relationship>
			<relationship name="party_has_role_on_contract" elemId="345006" parentTable="party" childTable="party_contract">
				<foreignKey>
					<column parentColumn="ID" elemId="639802" childColumn="CUSTOMERID"/>
				</foreignKey>
			</relationship>
			<relationship name="contract_has_party" elemId="26378142" parentTable="contract" childTable="party_contract">
				<foreignKey>
					<column parentColumn="ID" elemId="26378294" childColumn="CONTRACTID"/>
				</foreignKey>
			</relationship>
		</relationships>
		<tables>
			<table name="party" elemId="344776">
				<description>Customers stored in Life Insurance ERP system</description>
				<columns>
					<column description="" name="ID" elemId="344886" type="NUMBER"/>
					<column description="" name="FIRSTNAME" elemId="344887" type="VARCHAR(100)"/>
					<column description="" name="LASTNAME" elemId="109772" type="VARCHAR(100)"/>
					<column description="" name="BIRTHDATE" elemId="344888" type="DATE"/>
					<column description="" name="ID_CARD" elemId="344889" type="VARCHAR(20)"/>
					<column description="" name="SIN" elemId="344890" type="VARCHAR(20)"/>
					<column description="" name="COMPANYNAME" elemId="110778" type="VARCHAR(100)"/>
					<column description="" name="BUSINESSNUMBER" elemId="110779" type="VARCHAR(20)"/>
					<column description="" name="PHONE" elemId="116936" type="VARCHAR(20)"/>
					<column description="" name="EMAIL" elemId="116937" type="VARCHAR(100)"/>
					<column description="" name="ADDRESSLINE1" elemId="117356" type="VARCHAR(100)"/>
					<column description="" name="ADDRESSLINE2" elemId="117357" type="VARCHAR(100)"/>
					<column description="" name="ADDRESSLINE3" elemId="117358" type="VARCHAR(100)"/>
					<column description="" name="ADDRESSLINE4" elemId="117359" type="VARCHAR(100)"/>
				</columns>
			</table>
			<table name="contract" elemId="34832">
				<description>Life insurance contracts stored in the ERP system</description>
				<columns>
					<column description="" name="ID" elemId="34925" type="NUMBER"/>
					<column description="" name="CUSTOMERID" elemId="34926" type="NUMBER"/>
					<column description="" name="SALEPOINT" elemId="37432" type="VARCHAR(80)"/>
					<column description="" name="STATUS" elemId="34927" type="VARCHAR(30)"/>
					<column description="" name="TYPE" elemId="34928" type="VARCHAR(30)"/>
					<column description="" name="DATESTART" elemId="34930" type="DATE"/>
					<column description="" name="DATETO" elemId="34929" type="DATE"/>
					<column description="" name="PRODUCT" elemId="26377228" type="VARCHAR(50)"/>
					<column description="" name="VARIANT" elemId="26377229" type="VARCHAR(50)"/>
				</columns>
			</table>
			<table name="product" elemId="37383">
				<description>Life Insurance products stored in the ERP system</description>
				<columns>
					<column description="" name="ID" elemId="34925" type="NUMBER"/>
					<column description="" name="CONTRACTID" elemId="37458" type="NUMBER"/>
					<column description="" name="NAME" elemId="37459" type="VARCHAR(100)"/>
					<column description="" name="PRICE" elemId="37409" type="NUMBER"/>
					<column description="" name="CURRENCY" elemId="111408" type="VARCHAR(20)"/>
					<column description="" name="DESCRIPTION" elemId="111409" type="VARCHAR(2000)"/>
					<column description="" name="PARENTID" elemId="111410" type="NUMBER"/>
				</columns>
			</table>
			<table name="party_contract" elemId="109406">
				<description>Customer roles on contracts in the ERP system</description>
				<columns>
					<column description="" name="ID" elemId="26377684" type="NUMBER"/>
					<column description="" name="CONTRACTID" elemId="26377685" type="NUMBER"/>
					<column description="" name="CUSTOMERID" elemId="26377838" type="NUMBER"/>
					<column description="" name="RELTYPE" elemId="26377839" type="VARCHAR(30)"/>
				</columns>
			</table>
		</tables>
	</model>
	<sourceMappings>
		<mapping entity="contract" elemId="277153" table="contract" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="product" elemId="277155" table="product" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="party" elemId="116725" table="party" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="contact" elemId="117990" table="party" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="address" elemId="117991" table="party" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="id_document" elemId="26375924" table="party" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="rel_party2contract" elemId="307381" table="party_contract" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="rel_prod2prod" elemId="17780" table="product" customOrigin="">
			<description></description>
		</mapping>
		<mapping entity="rel_prod2contract" elemId="18225" table="contract" customOrigin="">
			<description></description>
		</mapping>
	</sourceMappings>
	<loadOperations>
		<fullLoad nameSuffix="full" elemId="277263" allTables="false">
			<selectedTables>
				<table name="contract" elemId="348637"/>
				<table name="product" elemId="348638"/>
				<table name="rel_party2contract" elemId="18396"/>
				<table name="party" elemId="350211"/>
				<table name="contact" elemId="118204"/>
				<table name="address" elemId="348639"/>
				<table name="id_document" elemId="26378230"/>
				<table name="rel_prod2prod" elemId="18666"/>
				<table name="rel_prod2contract" elemId="18667"/>
			</selectedTables>
			<advanced deletionStrategy="use global setting (from Preferences)">
				<ignoredComparisonColumns/>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</fullLoad>
		<initialLoad nameSuffix="initial" allowLoad="true" elemId="9314" ignorePersistence="">
			<advanced>
				<pathVariables/>
				<additionalParameters/>
			</advanced>
		</initialLoad>
	</loadOperations>
</system>