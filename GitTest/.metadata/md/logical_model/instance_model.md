<?xml version='1.0' encoding='UTF-8'?>
<instanceModel>
	<relationships>
		<relationship parentRole="party" name="party_has_address" elemId="22725" childRole="addresses" type="Same System" parentTable="party" childTable="address">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="435514" childColumn="party_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="party_master_id" elemId="29326" type="long_int" size="" createInto="address_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_match_isolate" elemId="179911" type="boolean" size="" createInto="address_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent>
				<column source="cio_address_comp" name="cio_address_comp_set" elemId="111566" method="concatenateDistinct" type="string" separator="^~" size="40000" createInto="party_match">
					<filterExpression></filterExpression>
				</column>
			</childToParent>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_contact" elemId="35423" childRole="contacts" type="Same System" parentTable="party" childTable="contact">
			<description>Relationship between Party and Contact. Party can have have multiple Contacts (even same type and value), and each Contact belongs exactly to one Party</description>
			<foreignKey>
				<column parentColumn="source_id" elemId="455507" childColumn="party_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="party_master_id" elemId="37575" type="long_int" size="" createInto="contact_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_match_isolate" elemId="184062" type="boolean" size="" createInto="contact_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent>
				<column source="cio_contact_comp" name="cio_contact_comp_set" elemId="105669" method="concatenateDistinct" type="string" separator="^~" size="2000" createInto="party_match">
					<filterExpression>source.cio_contact_comp is not null</filterExpression>
				</column>
			</childToParent>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_contract" elemId="35618" childRole="rel_party_contract" type="Same System" parentTable="party" childTable="rel_party2contract">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="455653" childColumn="party_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="pty_master_id" elemId="39002" type="long_int" size="" createInto="rel_party2contract_clean">
					<filterExpression></filterExpression>
				</column>
				<column source="cio_type" name="party_parent_cio_type" elemId="11885" type="string" size="30" createInto="rel_party2contract_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_match_isolate" elemId="184818" type="boolean" size="" createInto="rel_party2contract_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="ctr" name="contract_has_party" elemId="35634" childRole="party_contract" type="Same System" parentTable="contract" childTable="rel_party2contract">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="455799" childColumn="contract_source_id"/>
			</foreignKey>
			<parentToChild/>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party_child" name="party_has_child_party" elemId="35827" childRole="rel_party_party_parent" type="Same System" parentTable="party" childTable="rel_party2party">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="455945" childColumn="child_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="party_child_master_id" elemId="37694" type="long_int" size="" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
				<column source="cio_type" name="party_child_cio_type" elemId="20870" type="string" size="30" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_child_match_isolate" elemId="185578" type="boolean" size="" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party_parent" name="party_has_parent_party" elemId="35885" childRole="rel_party_party_child" type="Same System" parentTable="party" childTable="rel_party2party">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="456091" childColumn="parent_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="party_parent_master_id" elemId="37993" type="long_int" size="" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
				<column source="cio_type" name="party_parent_cio_type" elemId="21149" type="string" size="30" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_parent_match_isolate" elemId="185197" type="boolean" size="" createInto="rel_party2party_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_id_document" elemId="26400708" childRole="id_documents" type="Same System" parentTable="party" childTable="id_document">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="26403943" childColumn="party_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="party_master_id" elemId="26401858" type="long_int" size="" createInto="id_document_match">
					<filterExpression></filterExpression>
				</column>
				<column source="isolate_flag" name="party_match_isolate" elemId="184439" type="boolean" size="" createInto="id_document_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent>
				<column source="cio_id_document_comp" name="cio_id_document_set" elemId="26401859" method="concatenateDistinct" type="string" separator="^~" size="2000" createInto="party_match">
					<filterExpression>source.cio_id_document_comp is not null</filterExpression>
				</column>
			</childToParent>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_parent" elemId="14735" childRole="" type="Same System" parentTable="product" childTable="rel_prod2prod">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="20728" childColumn="parent_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="product_parent_master_id" elemId="16637" type="long_int" size="" createInto="rel_prod2prod_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="contract_has_product" elemId="14749" childRole="" type="Same System" parentTable="contract" childTable="rel_prod2contract">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="19950" childColumn="ctr_source_id"/>
			</foreignKey>
			<parentToChild/>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_contract" elemId="14763" childRole="" type="Same System" parentTable="product" childTable="rel_prod2contract">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="20339" childColumn="prd_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="prd_master_id" elemId="16049" type="long_int" size="" createInto="rel_prod2contract_clean">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="meta_system_override" enable="true" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_child" elemId="14777" childRole="" type="Same System" parentTable="product" childTable="rel_prod2prod">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="21117" childColumn="child_source_id"/>
			</foreignKey>
			<parentToChild>
				<column source="master_id" name="product_child_master_id" elemId="16935" type="long_int" size="" createInto="rel_prod2prod_match">
					<filterExpression></filterExpression>
				</column>
			</parentToChild>
			<childToParent/>
			<advanced>
				<extendedSameSystem parentColumn="" enable="false" childColumn=""/>
				<alternativeKey alternativePk="" alternativeFk=""/>
			</advanced>
		</relationship>
	</relationships>
	<tables>
		<table name="party" elemId="22660" type="instance">
			<description>Entity represents all company customers - persons and companies</description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="22662" isStd="false" isCio="false">
					<description>This ID serves as Primary Key in the external system providing the data. Combination of source_id and origin is unique in the MDM hub</description>
				</column>
				<column isPk="false" label="First Name" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="first_name" elemId="22754" isStd="true" isCio="true">
					<description>First name</description>
				</column>
				<column isPk="false" label="Middle Name" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="middle_name" elemId="144664" isStd="true" isCio="true">
					<description>Middle name</description>
				</column>
				<column isPk="false" label="Last Name" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="last_name" elemId="22755" isStd="true" isCio="true">
					<description>Last name</description>
				</column>
				<column isPk="false" label="Birth Date" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="birth_date" elemId="35355" isStd="true" isCio="true">
					<description>Date of birth</description>
				</column>
				<column isPk="false" label="Type" isSco="true" type="string" size="30" isFk="false" refData="party_type" isSrc="true" isExp="true" name="type" elemId="35356" isStd="true" isCio="true">
					<description>Type of customer - either Person or Company</description>
				</column>
				<column isPk="false" label="Gender" isSco="true" type="string" size="10" isFk="false" refData="gender" isSrc="true" isExp="true" name="gender" elemId="22756" isStd="true" isCio="true">
					<description>Gender</description>
				</column>
				<column isPk="false" label="SIN" isSco="true" type="string" size="30" isFk="false" refData="" isSrc="true" isExp="true" name="sin" elemId="626" isStd="true" isCio="true">
					<description>Social insurance number</description>
				</column>
				<column isPk="false" label="Company Name" isSco="true" type="string" size="200" isFk="false" refData="" isSrc="true" isExp="true" name="company_name" elemId="627" isStd="true" isCio="true">
					<description>Company name</description>
				</column>
				<column isPk="false" label="Business Number" isSco="true" type="string" size="30" isFk="false" refData="" isSrc="true" isExp="true" name="business_number" elemId="628" isStd="true" isCio="true">
					<description>Business number</description>
				</column>
				<column isPk="false" label="Legal Form" isSco="false" type="string" size="30" isFk="false" refData="legal_form" isSrc="true" isExp="false" name="legal_form" elemId="107186" isStd="true" isCio="true">
					<description>Company legal form</description>
				</column>
				<column isPk="false" label="Established Date" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="established_date" elemId="629" isStd="true" isCio="true">
					<description>Company established date</description>
				</column>
			</columns>
			<matchingTab enableIdentify="true" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="21991" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="16228" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="16229" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
					<column name="mat_party_type" elemId="20413" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_gender" elemId="20414" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_first_name" elemId="20415" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_middle_name" elemId="20416" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_last_name" elemId="20417" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_full_name" elemId="20418" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_initials" elemId="20419" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_person_id" elemId="20420" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_birth_date" elemId="20421" type="day" size="">
						<description></description>
					</column>
					<column name="mat_company_name" elemId="20422" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_company_id" elemId="20423" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_address_set" elemId="20424" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_contact_set" elemId="20425" type="string" size="1000">
						<description></description>
					</column>
					<column name="mat_id_doc_set" elemId="20426" type="string" size="1000">
						<description></description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="true" groupingColumn="master_id">
				<aggregationTabColumns>
					<aggregationTabColumn name="agg_group_size" elemId="16123" type="integer" size="">
						<description>Number of records in the matching group</description>
					</aggregationTabColumn>
				</aggregationTabColumns>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="sco_full_name" elemId="105256" type="integer" size="" createInto="party_clean">
						<description>Full name cleansing Score column</description>
					</column>
					<column name="exp_full_name" elemId="105257" type="string" size="2000" createInto="party_clean">
						<description>Full name cleansing Explanation column</description>
					</column>
					<column name="sco_instance" elemId="166560" type="integer" size="" createInto="party_clean">
						<description>Concatenated score across the whole party entity</description>
					</column>
					<column name="pat_name" elemId="145001" type="string" size="20" createInto="party_clean">
						<description></description>
					</column>
					<column name="dq_indicator" elemId="8785" type="integer" size="" createInto="party_clean">
						<description></description>
					</column>
					<column name="dq_indicator_name" elemId="8786" type="string" size="10" createInto="party_clean">
						<description></description>
					</column>
					<column name="mda_override" elemId="16626" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns/>
			</advanced>
		</table>
		<table name="address" elemId="22721" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="22723" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Party source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="party_source_id" elemId="22734" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Type" isSco="true" type="integer" size="30" isFk="false" refData="address_type" isSrc="true" isExp="true" name="type" elemId="114595" isStd="true" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Street" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="street" elemId="22759" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="City" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="city" elemId="22760" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="State" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="state" elemId="22761" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="ZIP" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="zip" elemId="22762" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="string" size="100" isFk="false" refData="" isSrc="false" isExp="true" name="address" elemId="22763" isStd="false" isCio="false">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="10508" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="10511" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="10512" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="cio_address_comp" elemId="111107" type="string" size="1000" createInto="address_clean">
						<description></description>
					</column>
					<column name="tmp_validity_level" elemId="149960" type="string" size="100" createInto="address_clean">
						<description></description>
					</column>
					<column name="tmp_address_validity" elemId="149961" type="string" size="100" createInto="address_clean">
						<description></description>
					</column>
					<column name="mda_override" elemId="17021" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns>
					<column name="old_party_master_id" elemId="27409" srcColumn="party_master_id">
						<description></description>
					</column>
				</oldValueColumns>
			</advanced>
		</table>
		<table name="contact" elemId="35382" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="35452" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Party source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="party_source_id" elemId="35384" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Type" isSco="true" type="string" size="20" isFk="false" refData="contact_type" isSrc="true" isExp="true" name="type" elemId="35399" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Value" isSco="true" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="true" name="value" elemId="35400" isStd="true" isCio="true">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="10891" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="10894" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="10895" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
					<column name="mat_value" elemId="18781" type="string" size="1000">
						<description></description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="cio_contact_comp" elemId="112223" type="string" size="1000" createInto="contact_clean">
						<description></description>
					</column>
					<column name="mda_override" elemId="13820" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns>
					<column name="old_party_master_id" elemId="240825" srcColumn="party_master_id">
						<description></description>
					</column>
				</oldValueColumns>
			</advanced>
		</table>
		<table name="rel_party2party" elemId="35725" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="35727" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Parent source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="parent_source_id" elemId="35749" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Child source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="child_source_id" elemId="35747" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Relation Type" isSco="false" type="string" size="100" isFk="false" refData="rel_pty2pty_type" isSrc="true" isExp="false" name="rel_type" elemId="35750" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Relation Category" isSco="false" type="string" size="100" isFk="false" refData="rel_pty2pty_ctg" isSrc="true" isExp="false" name="rel_category" elemId="11440487" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Valid From" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="p2p_valid_from" elemId="26373496" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Valid To" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="p2p_valid_to" elemId="26373497" isStd="true" isCio="true">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="11659" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="11662" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="11663" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="mda_override" elemId="14652" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns>
					<column name="old_party_child_master_id" elemId="181790" srcColumn="party_child_master_id">
						<description></description>
					</column>
					<column name="old_party_parent_master_id" elemId="182180" srcColumn="party_parent_master_id">
						<description></description>
					</column>
				</oldValueColumns>
			</advanced>
		</table>
		<table name="rel_party2contract" elemId="35554" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="35556" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Contract source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="contract_source_id" elemId="35593" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Party source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="party_source_id" elemId="35594" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Relation Type" isSco="true" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="true" name="rel_type" elemId="35595" isStd="true" isCio="false">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="12562" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="12564" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="12565" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns/>
				<historicalColumns/>
				<oldValueColumns>
					<column name="old_party_master_id_tmp" elemId="185960" srcColumn="pty_master_id">
						<description></description>
					</column>
				</oldValueColumns>
			</advanced>
		</table>
		<table name="contract" elemId="35489" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="35491" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Sale Point" isSco="false" type="string" size="100" isFk="false" refData="sale_point" isSrc="true" isExp="false" name="sale_point" elemId="35526" isStd="false" isCio="true">
					<description>ID of the Branch where the contract has been signed - works just as a reference check. List of Branches is maintained elsewhere and is not mastered in Party entity</description>
				</column>
				<column isPk="false" label="Status" isSco="false" type="string" size="30" isFk="false" refData="" isSrc="true" isExp="false" name="status" elemId="115661" isStd="false" isCio="false">
					<description>Describes Contract life-cycle states (e.g. &quot;Proposed&quot;, &quot;Active&quot;, &quot;Terminated&quot;, ...)</description>
				</column>
				<column isPk="false" label="Type" isSco="false" type="string" size="100" isFk="false" refData="contract_type" isSrc="true" isExp="false" name="type" elemId="115662" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Variant" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="variant" elemId="26387343" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Valid From" isSco="true" type="datetime" size="" isFk="false" refData="" isSrc="true" isExp="true" name="valid_from" elemId="35524" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Valid To" isSco="true" type="datetime" size="" isFk="false" refData="" isSrc="true" isExp="true" name="valid_to" elemId="35525" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Product source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="product_source_id" elemId="26376215" isStd="false" isCio="false">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="false">
				<matchingTabColumns/>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns/>
				<historicalColumns/>
				<oldValueColumns/>
			</advanced>
		</table>
		<table name="id_document" elemId="26399563" type="instance">
			<description>Identification Document - usually driving licence, ID card, or Passport</description>
			<columns>
				<column isPk="true" label="source_id" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="26400158" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Party source_id" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="party_source_id" elemId="26400524" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Type" isSco="true" type="string" size="30" isFk="false" refData="id_document_type" isSrc="true" isExp="true" name="type" elemId="26401077" isStd="false" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="Value" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="value" elemId="26401078" isStd="false" isCio="true">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="uni_rule_name" elemId="12957" type="string" size="100">
						<description>String column for storing the name of the matching rule used in matching group collecting</description>
					</column>
					<column name="uni_match_quality" elemId="12959" type="float" size="">
						<description>Match quality</description>
					</column>
					<column name="uni_match_id" elemId="12960" type="long_int" size="">
						<description>ID of record to whom we matched to</description>
					</column>
					<column name="mat_value" elemId="19565" type="string" size="1000">
						<description></description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="cio_id_document_comp" elemId="26402046" type="string" size="1000" createInto="id_document_clean">
						<description></description>
					</column>
					<column name="mda_override" elemId="14236" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns>
					<column name="old_party_master_id" elemId="181403" srcColumn="party_master_id">
						<description></description>
					</column>
				</oldValueColumns>
			</advanced>
		</table>
		<table name="product" elemId="14675" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="13497" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="true" name="name" elemId="13498" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="1000" isFk="false" refData="" isSrc="true" isExp="false" name="description" elemId="13499" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="string" size="100" isFk="false" refData="product_type" isSrc="true" isExp="true" name="type" elemId="13500" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="true" name="status" elemId="13501" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="10" isFk="false" refData="" isSrc="true" isExp="false" name="package_flag" elemId="13502" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="valid_to" elemId="4950" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="true" type="day" size="" isFk="false" refData="" isSrc="true" isExp="true" name="valid_from" elemId="4951" isStd="true" isCio="true">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns>
					<column name="mat_name" elemId="32605" type="string" size="100">
						<description></description>
					</column>
					<column name="mat_type" elemId="32606" type="string" size="100">
						<description></description>
					</column>
				</matchingTabColumns>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
			<advanced>
				<specialColumns>
					<column name="mda_override" elemId="15174" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns/>
			</advanced>
		</table>
		<table name="rel_prod2prod" elemId="14695" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="15169" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="parent_source_id" elemId="15170" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="child_source_id" elemId="15171" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="rel_type" elemId="17162" isStd="true" isCio="true">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="rel_category" elemId="17163" isStd="true" isCio="true">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="true">
				<matchingTabColumns/>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<advanced>
				<specialColumns>
					<column name="mda_override" elemId="15465" type="boolean" size="" createInto="load">
						<description></description>
					</column>
				</specialColumns>
				<historicalColumns/>
				<oldValueColumns/>
			</advanced>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
		</table>
		<table name="rel_prod2contract" elemId="14715" type="instance">
			<description></description>
			<columns>
				<column isPk="true" label="" isSco="false" type="string" size="200" isFk="false" refData="" isSrc="false" isExp="false" name="source_id" elemId="13099" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="prd_source_id" elemId="13100" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="" isSco="false" type="string" size="200" isFk="true" refData="" isSrc="false" isExp="false" name="ctr_source_id" elemId="13101" isStd="false" isCio="false">
					<description></description>
				</column>
				<column isPk="false" label="Variant" isSco="false" type="string" size="100" isFk="false" refData="" isSrc="true" isExp="false" name="variant" elemId="27071" isStd="false" isCio="false">
					<description></description>
				</column>
			</columns>
			<matchingTab enableIdentify="false" matching="false">
				<matchingTabColumns/>
				<multipleMatching disableDefault="false">
					<matchingDefinitions/>
				</multipleMatching>
			</matchingTab>
			<advanced>
				<specialColumns/>
				<historicalColumns/>
				<oldValueColumns/>
			</advanced>
			<aggregationTab aggregation="false" groupingColumn="">
				<aggregationTabColumns/>
			</aggregationTab>
		</table>
	</tables>
	<dicTables/>
</instanceModel>