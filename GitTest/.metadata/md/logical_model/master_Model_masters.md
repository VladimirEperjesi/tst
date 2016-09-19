<?xml version='1.0' encoding='UTF-8'?>
<masterModel name="masters" elemId="12690">
	<description>Complete master data view</description>
	<relationships>
		<relationship parentRole="party" name="party_has_address" elemId="22894" childRole="addresses" label="Party has Address" type="" parentTable="party" childTable="address">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109192" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master" name="party_has_instance" elemId="22897" childRole="instances" label="Party has Instance Details" type="" parentTable="party" childTable="party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109194" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="party_has_contact" elemId="36452" childRole="contacts" label="Party has Contact" type="" parentTable="party" childTable="contact">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109196" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="parent" name="party_has_parent_party" elemId="36626" childRole="relparent" label="Party has Parent Party" type="" parentTable="party" childTable="rel_party_party">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109198" childColumn="parent_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="child" name="party_has_child_party" elemId="36673" childRole="relchild" label="Party has Child Party" type="" parentTable="party" childTable="rel_party_party">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109200" childColumn="child_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master" name="contact_has_instance" elemId="36877" childRole="instances" label="Contact has Instance Details" type="" parentTable="contact" childTable="contact_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109202" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master" name="address_has_instance" elemId="36967" childRole="instances" label="Address has Instance Details" type="" parentTable="address" childTable="address_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18108677" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_contract" elemId="38949" childRole="contract" label="Party has Contract" type="" parentTable="party" childTable="rel_party2contract_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109205" childColumn="pty_master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="contract" name="contract_has_party" elemId="49427" childRole="party" label="Contract is Related to Party" type="" parentTable="contract_instance" childTable="rel_party2contract_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="18109207" childColumn="contract_source_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master" name="relation_party_has_instance" elemId="78629" childRole="instances" label="Relation has Instance Details" type="" parentTable="rel_party_party" childTable="rel_party_party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109209" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_id_document" elemId="26377853" childRole="id_documents" label="Party has ID Document" type="" parentTable="party" childTable="id_document">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109211" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="id_document_has_instance" elemId="156412" childRole="" label="ID Document has Instance Details" type="" parentTable="id_document" childTable="id_document_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="156744" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="rel_prod2prod_has_instance" elemId="20329" childRole="" label="" type="" parentTable="rel_prod2prod" childTable="rel_prod2prod_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="31363" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_child" elemId="20337" childRole="" label="" type="" parentTable="product" childTable="rel_prod2prod">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="14277" childColumn="child_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_parent" elemId="20345" childRole="" label="" type="" parentTable="product" childTable="rel_prod2prod">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="13393" childColumn="parent_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_instance" elemId="20353" childRole="" label="" type="" parentTable="product" childTable="product_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="20826" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="product_has_contract" elemId="20361" childRole="" label="" type="" parentTable="product" childTable="rel_prod2contract_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="5535" childColumn="prd_master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="contract_has_product" elemId="21440" childRole="" label="" type="" parentTable="contract_instance" childTable="rel_prod2contract_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="4086" childColumn="ctr_source_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
	</relationships>
	<masterTables>
		<masterTable name="party" elemId="22867" label="Master Party" entityRole="golden" instanceTable="party" topLevel="true">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22887" label="Party Id" type="long_int" size=""/>
				<column isCmo="true" refData="party_type" isPk="false" isFk="false" description="" name="type" elemId="128185" label="Customer Type" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="first_name" elemId="22868" label="First Name" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="last_name" elemId="29082" label="Last Name" type="string" size="100"/>
				<column isCmo="true" refData="gender" isPk="false" isFk="false" description="" name="gender" elemId="36720" label="Gender" type="string" size="10"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="birth_date" elemId="36721" label="Birth Date" type="day" size=""/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="sin" elemId="128186" label="Social Insurance Number" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="company_name" elemId="128187" label="Company Name" type="string" size="200"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="business_number" elemId="128188" label="Business Number" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="established_date" elemId="128189" label="Established Date" type="day" size=""/>
				<column isCmo="true" refData="legal_form" isPk="false" isFk="false" description="" name="legal_form" elemId="26381948" label="Business Form" type="string" size="30"/>
			</columns>
			<guiTab>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
				<views>
					<detailView elemId="107789">
						<groups>
							<labeledGroup templatePosition="left" name="par_basic_P" elemId="31250" label="Basic Party Information">
								<viewCondition>cmo_type = &#39;P&#39;</viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="11473299" format=""/>
									<column lookupType="COMBO" name="cmo_type" elemId="87507" format=""/>
									<column lookupType="" name="cmo_first_name" elemId="87508" format=""/>
									<column lookupType="" name="cmo_last_name" elemId="87509" format=""/>
									<column lookupType="WINDOW" name="cmo_gender" elemId="87510" format=""/>
									<column lookupType="" name="cmo_birth_date" elemId="87511" format="yyyy.MM.dd"/>
									<column lookupType="" name="cmo_sin" elemId="87512" format=""/>
									<column lookupType="" name="age" elemId="87513" format=""/>
									<column lookupType="" name="eng_active" elemId="11455738" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="11474488" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="left" name="par_basic_C" elemId="92873" label="Basic Party Information">
								<viewCondition>cmo_type = &#39;C&#39;</viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="11473299" format=""/>
									<column lookupType="COMBO" name="cmo_type" elemId="87507" format=""/>
									<column lookupType="" name="cmo_company_name" elemId="93294" format=""/>
									<column lookupType="" name="cmo_business_number" elemId="93295" format=""/>
									<column lookupType="" name="cmo_established_date" elemId="93296" format="yyyy/MM/dd"/>
									<column lookupType="WINDOW" name="cmo_legal_form" elemId="93297" format=""/>
									<column lookupType="" name="eng_active" elemId="11455738" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="11474488" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedList relationship="party_has_address" templatePosition="right" name="address" elemId="158834" label="Address">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_street} ${cmo_city}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_id_document" templatePosition="right" name="id_doc" elemId="111272" label="ID Document">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_contact" templatePosition="right" name="contact" elemId="24847" label="Contact">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedMNList relationship="party_has_child_party" entity_out="party" templatePosition="left" name="p2p_parent" elemId="160124" relationship_out="party_has_parent_party" label="Parent Party">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Parent Id: ${parent_id} | Relationship Type: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Party</firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name} ${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="party_has_parent_party" entity_out="party" templatePosition="left" name="p2p_child" elemId="122759" relationship_out="party_has_child_party" label="Child Party">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Child Id: ${child_id} | Relationship Type: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Party</firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name} ${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="party_has_contract" entity_out="contract_instance" templatePosition="right" name="p2c" elemId="130114" relationship_out="contract_has_party" label="Contract">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Contract Id: ${contract_source_id} | Relationship Type: ${src_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Contract Type</firstColumnFormat>
									<secondColumnFormat>${src_type}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<listGrid relationship="party_has_instance" templatePosition="bottom" name="list_P" elemId="31251" label="Instances">
								<viewCondition>cmo_type = &#39;P&#39;</viewCondition>
								<lists>
									<list name="src" elemId="45892" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="45894" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="uni" elemId="45895" label="Instances: matching results" columnMask="">
										<columns>
											<column name="eng_source_system" elemId="48665"/>
											<column name="source_id" elemId="48666"/>
											<column name="master_id" elemId="48668"/>
											<column name="uni_rule_name" elemId="48669"/>
											<column name="uni_match_quality" elemId="17415"/>
											<column name="uni_match_id" elemId="17416"/>
											<column name="mat_party_type" elemId="31252"/>
											<column name="mat_gender" elemId="31253"/>
											<column name="mat_first_name" elemId="31254"/>
											<column name="mat_middle_name" elemId="31255"/>
											<column name="mat_last_name" elemId="31256"/>
											<column name="mat_full_name" elemId="31257"/>
											<column name="mat_initials" elemId="31258"/>
											<column name="mat_person_id" elemId="31259"/>
											<column name="mat_birth_date" elemId="31260"/>
											<column name="mat_address_set" elemId="31261"/>
											<column name="mat_contact_set" elemId="31262"/>
											<column name="mat_id_doc_set" elemId="31263"/>
										</columns>
									</list>
									<list name="all" elemId="45896" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
							<listGrid relationship="party_has_instance" templatePosition="bottom" name="list_C" elemId="97076" label="Instances">
								<viewCondition>cmo_type = &#39;C&#39;</viewCondition>
								<lists>
									<list name="src" elemId="45892" label="Instances: source columns" columnMask="^src_comp*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
											<column name="src_type" elemId="31739"/>
										</columns>
									</list>
									<list name="std" elemId="45894" label="Instances: standardized columns" columnMask="^std_comp*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="uni" elemId="45895" label="Instances: matching results" columnMask="">
										<columns>
											<column name="eng_source_system" elemId="48665"/>
											<column name="source_id" elemId="48666"/>
											<column name="master_id" elemId="48668"/>
											<column name="uni_rule_name" elemId="48669"/>
											<column name="uni_match_quality" elemId="17415"/>
											<column name="uni_match_id" elemId="17416"/>
											<column name="mat_party_type" elemId="31264"/>
											<column name="mat_company_name" elemId="31265"/>
											<column name="mat_company_id" elemId="31266"/>
											<column name="mat_address_set" elemId="31267"/>
											<column name="mat_contact_set" elemId="31268"/>
											<column name="mat_id_doc_set" elemId="31269"/>
										</columns>
									</list>
									<list name="all" elemId="45896" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="107790">
						<columns>
							<column name="cmo_first_name" elemId="10692"/>
							<column name="cmo_last_name" elemId="10693"/>
							<column name="cmo_company_name" elemId="107791"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="age" elemId="657533" label="Age">
						<producer>toString(floor(dateDiff(getMdaValDatetime(&#39;cmo_birth_date&#39;), now(), &#39;DAY&#39;)/365))</producer>
					</column>
				</computedColumns>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>eng_active = true or eng_source_system = &#39;mda&#39;</inputFilterExpression>
				<specialColumns>
					<column name="dq_indicator" elemId="7797" label="DQ Indicator" type="integer" size="">
						<description></description>
					</column>
					<column name="dq_indicator_name" elemId="7798" label="DQ Indicator Name" type="string" size="10">
						<description></description>
					</column>
					<column name="group_count" elemId="6284" label="Group Count" type="integer" size="">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="4055"/>
					<column nmeMapping="src_first_name" name="cmo_first_name" elemId="4056"/>
					<column nmeMapping="src_last_name" name="cmo_last_name" elemId="4057"/>
					<column nmeMapping="src_gender" name="cmo_gender" elemId="4058"/>
					<column nmeMapping="src_birth_date" name="cmo_birth_date" elemId="4059"/>
					<column nmeMapping="src_sin" name="cmo_sin" elemId="4060"/>
					<column nmeMapping="src_company_name" name="cmo_company_name" elemId="4061"/>
					<column nmeMapping="src_business_number" name="cmo_business_number" elemId="4062"/>
					<column nmeMapping="src_established_date" name="cmo_established_date" elemId="4063"/>
					<column nmeMapping="src_legal_form" name="cmo_legal_form" elemId="4064"/>
				</editColumns>
				<parentColumns/>
			</guiEdit>
		</masterTable>
		<masterTable name="address" elemId="22881" label="Master Address" entityRole="silver" instanceTable="address" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22885" label="Address Id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="22891" label="Party Id" type="long_int" size="30"/>
				<column isCmo="true" refData="address_type" isPk="false" isFk="false" description="" name="type" elemId="129734" label="Type" type="integer" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="street" elemId="35288" label="Street" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="city" elemId="35289" label="City" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="state" elemId="35290" label="State" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="zip" elemId="35291" label="Postal Code" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="135960">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="198134" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26380488" format=""/>
									<column lookupType="" name="cmo_type" elemId="130397" format=""/>
									<column lookupType="" name="cmo_street" elemId="511929" format=""/>
									<column lookupType="" name="cmo_city" elemId="515447" format=""/>
									<column lookupType="" name="cmo_zip" elemId="515449" format=""/>
									<column lookupType="" name="cmo_state" elemId="515448" format=""/>
									<column lookupType="" name="eng_active" elemId="11454524" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="11478848" format=""/>
									<column lookupType="" name="party_id" elemId="515446" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="address_has_instance" templatePosition="bottom" name="instances" elemId="515582" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="50293" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="50294" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="50295" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="97510">
						<columns>
							<column name="cmo_street" elemId="97512"/>
							<column name="cmo_city" elemId="104080"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>eng_active = true or eng_source_system = &#39;mda&#39;</inputFilterExpression>
				<specialColumns>
					<column name="group_count" elemId="6706" label="Group Count" type="integer" size="">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_address" name="party_source_id" elemId="19850"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="10383"/>
					<column nmeMapping="src_street" name="cmo_street" elemId="10384"/>
					<column nmeMapping="src_city" name="cmo_city" elemId="10385"/>
					<column nmeMapping="src_state" name="cmo_state" elemId="10386"/>
					<column nmeMapping="src_zip" name="cmo_zip" elemId="10387"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="contact" elemId="36374" label="Master Contact" entityRole="silver" instanceTable="contact" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22885" label="Contact Id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="22891" label="Party Id" type="long_int" size="30"/>
				<column isCmo="true" refData="contact_type" isPk="false" isFk="false" description="" name="type" elemId="35288" label="Contact Type" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="value" elemId="35289" label="Contact Value" type="string" size="100"/>
			</columns>
			<guiTab>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
				<views>
					<detailView elemId="26386301">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26386302" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26376694" format=""/>
									<column lookupType="" name="party_id" elemId="26376695" format=""/>
									<column lookupType="" name="cmo_type" elemId="26376696" format=""/>
									<column lookupType="" name="cmo_value" elemId="26376697" format=""/>
									<column lookupType="" name="eng_active" elemId="11461721" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="contact_has_instance" templatePosition="bottom" name="instances" elemId="26380322" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="50731" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="50732" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="50733" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="86327">
						<columns>
							<column name="cmo_type" elemId="86328"/>
							<column name="cmo_value" elemId="86329"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="contact_label" elemId="26380143" label="Contact Label">
						<producer>getMdaValString(&#39;cmo_type&#39;) + &#39; contact&#39;</producer>
					</column>
				</computedColumns>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression></inputFilterExpression>
				<specialColumns>
					<column name="group_count" elemId="7102" label="Group Count" type="integer" size="">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="10554"/>
					<column nmeMapping="src_value" name="cmo_value" elemId="10555"/>
				</editColumns>
				<parentColumns>
					<parentColumn relationship="party_has_contact" name="party_source_id" elemId="62366"/>
				</parentColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_party_party" elemId="36496" label="Master Party to Party Relations" entityRole="silver" instanceTable="rel_party2party" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="36520" label="Relationship Id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="parent_id" elemId="36592" label="Parent Party Id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="child_id" elemId="36590" label="Child Party Id" type="long_int" size="30"/>
				<column isCmo="true" refData="rel_pty2pty_type" isPk="false" isFk="false" description="" name="p2p_rel_type" elemId="36593" label="Relationship Type" type="string" size="100"/>
				<column isCmo="true" refData="rel_pty2pty_ctg" isPk="false" isFk="false" description="" name="rel_category" elemId="11441674" label="Relationship Category" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="26375491">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26375492" label="Party to Party relation">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26375493" format=""/>
									<column lookupType="" name="parent_id" elemId="26375494" format=""/>
									<column lookupType="" name="child_id" elemId="26375495" format=""/>
									<column lookupType="" name="cmo_p2p_rel_type" elemId="26375496" format=""/>
									<column lookupType="" name="cmo_rel_category" elemId="11458928" format=""/>
									<column lookupType="" name="eng_active" elemId="109012" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="109013" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="relation_party_has_instance" templatePosition="bottom" name="list" elemId="109416" label="Instances ">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="51588" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="51589" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="51590" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression></inputFilterExpression>
				<specialColumns>
					<column name="group_count" elemId="7867" label="Group Count" type="integer" size="">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_child_party" name="child_source_id" elemId="43257"/>
					<parentColumn relationship="party_has_parent_party" name="parent_source_id" elemId="43258"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_rel_type" name="cmo_p2p_rel_type" elemId="10224"/>
					<column nmeMapping="src_rel_category" name="cmo_rel_category" elemId="6400"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="id_document" elemId="26377244" label="ID Document" entityRole="silver" instanceTable="id_document" topLevel="false">
			<description>Identification Document - usually driving licence, ID card, or Passport</description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="26373988" label="Document Id" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="26374577" label="Party Id" type="long_int" size=""/>
				<column isCmo="true" refData="id_document_type" isPk="false" isFk="false" description="" name="type" elemId="26373989" label="Document Type" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="value" elemId="26373990" label="Document Value" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="26374207">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26374208" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26374209" format=""/>
									<column lookupType="" name="cmo_type" elemId="26374210" format=""/>
									<column lookupType="" name="cmo_value" elemId="26374211" format=""/>
									<column lookupType="" name="eng_active" elemId="11460928" format=""/>
									<column lookupType="" name="party_id" elemId="26374212" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="id_document_has_instance" templatePosition="bottom" name="list" elemId="154687" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="51160" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="51161" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="51162" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="118349">
						<columns>
							<column name="cmo_value" elemId="118350"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="id_document_label" elemId="26375307" label="ID Document Label">
						<producer>getMdaValString(&#39;cmo_value&#39;)</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression></inputFilterExpression>
				<specialColumns>
					<column name="group_count" elemId="7495" label="Group Count" type="integer" size="">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="Read-Only">
				<parentColumns>
					<parentColumn relationship="party_has_id_document" name="party_source_id" elemId="63233"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="10717"/>
					<column nmeMapping="src_value" name="cmo_value" elemId="10718"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_prod2prod" elemId="20259" label="Product to Product Relation" entityRole="silver" instanceTable="rel_prod2prod" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="12220" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="parent_id" elemId="13685" label="" type="long_int" size="200"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="child_id" elemId="13686" label="" type="long_int" size="200"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="rel_type" elemId="13687" label="" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="rel_category" elemId="13688" label="" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<breadcrumbView allColumns="false" elemId="24389">
						<columns>
							<column name="id" elemId="24390"/>
							<column name="cmo_rel_type" elemId="24391"/>
							<column name="cmo_rel_category" elemId="28335"/>
						</columns>
					</breadcrumbView>
					<detailView elemId="25276">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="25277" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="25278" format=""/>
									<column lookupType="" name="eng_active" elemId="25279" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="25280" format=""/>
									<column lookupType="" name="parent_id" elemId="25281" format=""/>
									<column lookupType="" name="child_id" elemId="25282" format=""/>
									<column lookupType="" name="cmo_rel_type" elemId="25283" format=""/>
									<column lookupType="" name="cmo_rel_category" elemId="25284" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="rel_prod2prod_has_instance" templatePosition="bottom" name="instances" elemId="29782" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="30519" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="30520" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="30521" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="false">
				<inputFilterExpression></inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="product_has_child" name="child_source_id" elemId="31605"/>
					<parentColumn relationship="product_has_parent" name="parent_source_id" elemId="31606"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="parent_source_id" name="parent_id" elemId="24392"/>
					<column nmeMapping="child_source_id" name="child_id" elemId="24393"/>
					<column nmeMapping="src_rel_type" name="cmo_rel_type" elemId="24394"/>
					<column nmeMapping="src_rel_category" name="cmo_rel_category" elemId="24395"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="product" elemId="20279" label="Product" entityRole="golden" instanceTable="product" topLevel="true">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="3498" label="" type="long_int" size=""/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="name" elemId="7295" label="" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="description" elemId="7296" label="" type="string" size="1000"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="type" elemId="7297" label="" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="status" elemId="7298" label="" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="valid_to" elemId="6799" label="" type="day" size=""/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="valid_from" elemId="6800" label="" type="day" size=""/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="package_flag" elemId="7299" label="" type="string" size="10"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="23217">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="23218" label="Basic Product Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="23219" format=""/>
									<column lookupType="" name="eng_active" elemId="23220" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="23221" format=""/>
									<column lookupType="" name="cmo_name" elemId="23222" format=""/>
									<column lookupType="" name="cmo_description" elemId="23223" format=""/>
									<column lookupType="" name="cmo_type" elemId="23224" format=""/>
									<column lookupType="" name="cmo_status" elemId="23225" format=""/>
									<column lookupType="" name="cmo_package_flag" elemId="23226" format=""/>
									<column lookupType="" name="cmo_valid_to" elemId="18040" format=""/>
									<column lookupType="" name="cmo_valid_from" elemId="18041" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedMNList relationship="product_has_child" entity_out="product" templatePosition="right" name="prod2prod_parent" elemId="14726" relationship_out="product_has_parent" label="Product has Parent">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Parent Id: ${parent_id} | Relationship Type: ${cmo_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Product</firstColumnFormat>
									<secondColumnFormat>${cmo_name} ${cmo_type}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="product_has_parent" entity_out="product" templatePosition="right" name="prod2prod_child" elemId="8672" relationship_out="product_has_child" label="Product has Child">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Child Id: ${child_id} | Relationship Type: ${cmo_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Product</firstColumnFormat>
									<secondColumnFormat>${cmo_name} ${cmo_type}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="product_has_contract" entity_out="contract_instance" templatePosition="left" name="contract" elemId="12909" relationship_out="contract_has_product" label="Product has Contract">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Contract Id: ${ctr_source_id} | Variant Type: ${src_variant}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Contract</firstColumnFormat>
									<secondColumnFormat>${cio_sale_point} ${cio_type} ${source_id}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<listGrid relationship="product_has_instance" templatePosition="bottom" name="instances" elemId="19246" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="32926" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="32934" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="cio" elemId="34484" label="Instances: cleansed columns" columnMask="^cio_*">
										<columns>
											<column name="source_id" elemId="34485"/>
											<column name="eng_source_system" elemId="34486"/>
										</columns>
									</list>
									<list name="all" elemId="32935" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="22912">
						<columns>
							<column name="cmo_name" elemId="22913"/>
							<column name="cmo_type" elemId="22914"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>eng_active = true or eng_source_system = &#39;mda&#39;</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns/>
				<editColumns>
					<column nmeMapping="src_name" name="cmo_name" elemId="24094"/>
					<column nmeMapping="src_description" name="cmo_description" elemId="24095"/>
					<column nmeMapping="src_type" name="cmo_type" elemId="24096"/>
					<column nmeMapping="src_status" name="cmo_status" elemId="24097"/>
					<column nmeMapping="src_valid_to" name="cmo_valid_to" elemId="17737"/>
					<column nmeMapping="src_valid_from" name="cmo_valid_from" elemId="17738"/>
				</editColumns>
			</guiEdit>
		</masterTable>
	</masterTables>
	<instanceTables>
		<instanceTable name="party_instance" elemId="22862" label="Instance Party" instanceTable="party" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="26374600">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26374601" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="source_id" elemId="26374604" format=""/>
									<column lookupType="" name="id" elemId="26374602" format=""/>
									<column lookupType="" name="cio_type" elemId="178085" format=""/>
									<column lookupType="" name="cio_first_name" elemId="26382361" format=""/>
									<column lookupType="" name="cio_middle_name" elemId="178086" format=""/>
									<column lookupType="" name="cio_last_name" elemId="26382362" format=""/>
									<column lookupType="" name="cio_sin" elemId="26382363" format=""/>
									<column lookupType="" name="cio_gender" elemId="26373214" format=""/>
									<column lookupType="" name="cio_company_name" elemId="26382364" format=""/>
									<column lookupType="" name="cio_business_number" elemId="26382365" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="left" name="source" elemId="26374818" label="Source Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="eng_source_system" elemId="18081162" format=""/>
									<column lookupType="" name="src_type" elemId="26375022" format=""/>
									<column lookupType="" name="src_first_name" elemId="26375023" format=""/>
									<column lookupType="" name="src_last_name" elemId="26375024" format=""/>
									<column lookupType="" name="src_sin" elemId="26375025" format=""/>
									<column lookupType="" name="src_company_name" elemId="26375026" format=""/>
									<column lookupType="" name="src_business_number" elemId="26375027" format=""/>
									<column lookupType="" name="src_birth_date" elemId="26375028" format=""/>
									<column lookupType="" name="src_gender" elemId="26375029" format=""/>
									<column lookupType="" name="src_legal_form" elemId="26375031" format=""/>
									<column lookupType="" name="src_established_date" elemId="26375032" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="18081305" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="cleansed" elemId="26375238" label="Cleansed Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="cio_first_name" elemId="26376064" format=""/>
									<column lookupType="" name="cio_last_name" elemId="26376065" format=""/>
									<column lookupType="" name="exp_full_name" elemId="26375798" format=""/>
									<column lookupType="" name="cio_birth_date" elemId="26376066" format=""/>
									<column lookupType="" name="exp_birth_date" elemId="26375799" format=""/>
									<column lookupType="" name="cio_type" elemId="26376067" format=""/>
									<column lookupType="" name="exp_type" elemId="26375800" format=""/>
									<column lookupType="" name="cio_gender" elemId="26376068" format=""/>
									<column lookupType="" name="cio_sin" elemId="26376070" format=""/>
									<column lookupType="" name="exp_sin" elemId="26375801" format=""/>
									<column lookupType="" name="cio_company_name" elemId="26376071" format=""/>
									<column lookupType="" name="exp_company_name" elemId="26375802" format=""/>
									<column lookupType="" name="cio_business_number" elemId="26376072" format=""/>
									<column lookupType="" name="exp_business_number" elemId="26375803" format=""/>
									<column lookupType="" name="cio_legal_form" elemId="26376073" format=""/>
									<column lookupType="" name="cio_established_date" elemId="26376074" format=""/>
									<column lookupType="" name="exp_established_date" elemId="26375804" format=""/>
									<column lookupType="" name="cio_address_comp_set" elemId="26376075" format=""/>
									<column lookupType="" name="cio_contact_comp_set" elemId="26376076" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="matching" elemId="26376722" label="Matching Details">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="master_id" elemId="178087" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="26376724" format=""/>
									<column lookupType="" name="uni_match_id" elemId="14334" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Party Id" name="id" elemId="211582"/>
				<column customLabel="Matching Rule Name" name="uni_rule_name" elemId="657845"/>
				<column customLabel="Data source_id" name="source_id" elemId="211583"/>
				<column customLabel="Master Party Id" name="master_id" elemId="211584"/>
			</columns>
		</instanceTable>
		<instanceTable name="contact_instance" elemId="36790" label="Instance Contact" instanceTable="contact" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="26380093">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26380094" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26380095" format=""/>
									<column lookupType="" name="master_id" elemId="26380096" format=""/>
									<column lookupType="" name="eng_source_system" elemId="18081018" format=""/>
									<column lookupType="" name="source_id" elemId="26380097" format=""/>
									<column lookupType="" name="party_source_id" elemId="26380098" format=""/>
									<column lookupType="" name="src_type" elemId="26380099" format=""/>
									<column lookupType="" name="std_type" elemId="26380100" format=""/>
									<column lookupType="" name="dic_type" elemId="26380101" format=""/>
									<column lookupType="" name="src_value" elemId="26380102" format=""/>
									<column lookupType="" name="std_value" elemId="26380103" format=""/>
									<column lookupType="" name="cio_value" elemId="26380104" format=""/>
									<column lookupType="" name="exp_value" elemId="26380105" format=""/>
									<column lookupType="" name="sco_value" elemId="26380106" format=""/>
									<column lookupType="" name="cio_contact_comp" elemId="26380107" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="26380109" format=""/>
									<column lookupType="" name="party_master_id" elemId="26380111" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="18081019" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Contact Id" name="id" elemId="510184"/>
				<column customLabel="source_id" name="source_id" elemId="510185"/>
				<column customLabel="Master Contact Id" name="master_id" elemId="510186"/>
				<column customLabel="Master Party Id" name="party_master_id" elemId="658070"/>
			</columns>
		</instanceTable>
		<instanceTable name="address_instance" elemId="36923" label="Instance Address" instanceTable="address" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="26373348">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26373554" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26373555" format=""/>
									<column lookupType="" name="master_id" elemId="26373556" format=""/>
									<column lookupType="" name="source_id" elemId="26373557" format=""/>
									<column lookupType="" name="party_source_id" elemId="26373558" format=""/>
									<column lookupType="" name="party_master_id" elemId="26373560" format=""/>
									<column lookupType="" name="eng_active" elemId="11476866" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="11476867" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="left" name="source" elemId="26373349" label="Source Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="eng_source_system" elemId="18081449" format=""/>
									<column lookupType="" name="src_type" elemId="26373767" format=""/>
									<column lookupType="" name="src_street" elemId="26373768" format=""/>
									<column lookupType="" name="src_city" elemId="26373769" format=""/>
									<column lookupType="" name="src_zip" elemId="26373771" format=""/>
									<column lookupType="" name="src_state" elemId="26373770" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="cleansed" elemId="26373350" label="Cleansed Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="cio_address_comp" elemId="26374180" format=""/>
									<column lookupType="" name="dic_type" elemId="26374181" format=""/>
									<column lookupType="" name="cio_street" elemId="26374182" format=""/>
									<column lookupType="" name="cio_city" elemId="26374183" format=""/>
									<column lookupType="" name="cio_zip" elemId="26374184" format=""/>
									<column lookupType="" name="cio_state" elemId="26374185" format=""/>
									<column lookupType="" name="exp_address" elemId="26374594" format=""/>
									<column lookupType="" name="sco_address" elemId="26374595" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Address Id" name="id" elemId="658295"/>
				<column customLabel="Address source_id" name="source_id" elemId="658296"/>
				<column customLabel="Party source_id" name="party_source_id" elemId="658298"/>
				<column customLabel="Cleansing Explanation" name="exp_address" elemId="658302"/>
				<column customLabel="Cleansing Score" name="sco_address" elemId="658303"/>
				<column customLabel="Master Party Id" name="party_master_id" elemId="658304"/>
				<column customLabel="Address Component" name="cio_address_comp" elemId="26375003"/>
				<column customLabel="Verified Address Type" name="dic_type" elemId="26375638"/>
				<column customLabel="Master Address Id" name="master_id" elemId="172557"/>
				<column customLabel="Type" name="src_type" elemId="172897"/>
			</columns>
		</instanceTable>
		<instanceTable name="rel_party2contract_instance" elemId="38877" label="Instance Party to Contract Roles" instanceTable="rel_party2contract" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="111806">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="110993" label="Details">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="111807" format=""/>
									<column lookupType="" name="eng_active" elemId="111808" format=""/>
									<column lookupType="" name="eng_origin" elemId="111809" format=""/>
									<column lookupType="" name="eng_source_system" elemId="111810" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="111811" format=""/>
									<column lookupType="" name="master_id" elemId="111812" format=""/>
									<column lookupType="" name="source_id" elemId="111813" format=""/>
									<column lookupType="" name="contract_source_id" elemId="111814" format=""/>
									<column lookupType="" name="party_source_id" elemId="111815" format=""/>
									<column lookupType="" name="src_rel_type" elemId="111816" format=""/>
									<column lookupType="" name="std_rel_type" elemId="111817" format=""/>
									<column lookupType="" name="exp_rel_type" elemId="111818" format=""/>
									<column lookupType="" name="sco_rel_type" elemId="111819" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="111825" format=""/>
									<column lookupType="" name="pty_master_id" elemId="111827" format=""/>
									<column lookupType="" name="party_parent_cio_type" elemId="111828" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Party to Contract Relationship Id" name="id" elemId="212415"/>
				<column customLabel="Party to Contract Relationship source_id" name="source_id" elemId="212416"/>
				<column customLabel="Contract source_id" name="contract_source_id" elemId="212417"/>
				<column customLabel="Party Master Id" name="pty_master_id" elemId="212423"/>
				<column customLabel="Party source_id" name="party_source_id" elemId="132918"/>
				<column customLabel="Relationship Type" name="src_rel_type" elemId="132919"/>
				<column customLabel="Relationship Type" name="std_rel_type" elemId="132920"/>
			</columns>
		</instanceTable>
		<instanceTable name="contract_instance" elemId="49273" label="Instance Contract" instanceTable="contract" topLevel="true">
			<guiTab>
				<views>
					<detailView elemId="113030">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="11489160" label="Contract Instance Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26374602" format=""/>
									<column lookupType="" name="source_id" elemId="26374604" format=""/>
									<column lookupType="" name="eng_active" elemId="11489161" format=""/>
									<column lookupType="" name="eng_source_system" elemId="11489162" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="11489163" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="source" elemId="11489164" label="Source Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="source_id" elemId="11505850" format=""/>
									<column lookupType="" name="src_sale_point" elemId="11491153" format=""/>
									<column lookupType="" name="src_status" elemId="11491154" format=""/>
									<column lookupType="" name="src_type" elemId="11491155" format=""/>
									<column lookupType="" name="src_variant" elemId="11491156" format=""/>
									<column lookupType="" name="src_valid_from" elemId="11491157" format=""/>
									<column lookupType="" name="src_valid_to" elemId="11491158" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedMNList relationship="contract_has_party" entity_out="party" templatePosition="right" name="c2p" elemId="123614" relationship_out="party_has_contract" label="Contract to Party Relation">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Party Id: ${id}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Party</firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name} ${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledGroup templatePosition="left" name="cleansed" elemId="11489165" label="Cleansed Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="cio_sale_point" elemId="11508652" format=""/>
									<column lookupType="" name="cio_type" elemId="11508653" format=""/>
									<column lookupType="" name="std_valid_from" elemId="11493537" format=""/>
									<column lookupType="" name="cio_valid_from" elemId="11493538" format=""/>
									<column lookupType="" name="exp_valid_from" elemId="11493539" format=""/>
									<column lookupType="" name="std_valid_to" elemId="11493540" format=""/>
									<column lookupType="" name="cio_valid_to" elemId="11493541" format=""/>
									<column lookupType="" name="exp_valid_to" elemId="11493542" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="113031">
						<columns>
							<column name="src_type" elemId="125899"/>
							<column name="src_variant" elemId="125900"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="contract_single_line" elemId="26386514" label="Contract Label">
						<producer>getMdaValString(&#39;source_id&#39;) + &#39;@&#39; + nvl(getMdaValString(&#39;dic_sale_point&#39;), getMdaValString(&#39;src_sale_point&#39;))</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Contract Id" name="id" elemId="132473"/>
				<column customLabel="Contract Number" name="source_id" elemId="132474"/>
				<column customLabel="Contract Sale Point" name="src_sale_point" elemId="132475"/>
				<column customLabel="Contract Status" name="src_status" elemId="132480"/>
				<column customLabel="Contract Type" name="src_type" elemId="132484"/>
				<column customLabel="Valid From" name="src_valid_from" elemId="132489"/>
				<column customLabel="Valid From" name="cio_valid_from" elemId="132490"/>
				<column customLabel="Valid To" name="src_valid_to" elemId="132491"/>
				<column customLabel="Valid To" name="cio_valid_to" elemId="132492"/>
				<column customLabel="Product Family" name="product_source_id" elemId="170476"/>
				<column customLabel="Point of Sale" name="cio_sale_point" elemId="11508654"/>
				<column customLabel="Contract Type" name="cio_type" elemId="11508655"/>
			</columns>
		</instanceTable>
		<instanceTable name="rel_party_party_instance" elemId="78553" label="Instance Party to Party Relations" instanceTable="rel_party2party" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="110609">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="110192" label="Attributes">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="110193" format=""/>
									<column lookupType="" name="dic_rel_type" elemId="110214" format=""/>
									<column lookupType="" name="party_parent_cio_type" elemId="110222" format=""/>
									<column lookupType="" name="eng_active" elemId="110194" format=""/>
									<column lookupType="" name="eng_source_system" elemId="11483602" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="110197" format=""/>
									<column lookupType="" name="master_id" elemId="110198" format=""/>
									<column lookupType="" name="source_id" elemId="110199" format=""/>
									<column lookupType="" name="parent_source_id" elemId="110200" format=""/>
									<column lookupType="" name="child_source_id" elemId="110201" format=""/>
									<column lookupType="" name="src_rel_type" elemId="110202" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="110217" format=""/>
									<column lookupType="" name="party_child_master_id" elemId="110219" format=""/>
									<column lookupType="" name="party_child_cio_type" elemId="110220" format=""/>
									<column lookupType="" name="party_parent_master_id" elemId="110221" format=""/>
									<column lookupType="" name="std_p2p_valid_from" elemId="110204" format=""/>
									<column lookupType="" name="cio_p2p_valid_from" elemId="110205" format=""/>
									<column lookupType="" name="exp_p2p_valid_from" elemId="11484792" format=""/>
									<column lookupType="" name="std_p2p_valid_to" elemId="110209" format=""/>
									<column lookupType="" name="cio_p2p_valid_to" elemId="110210" format=""/>
									<column lookupType="" name="exp_p2p_valid_to" elemId="11484793" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns>
				<column customLabel="Party to Party Relation Id" name="id" elemId="127730"/>
				<column customLabel="Party to Party Relation Master Id" name="master_id" elemId="127731"/>
				<column customLabel="Parent Party source_id" name="parent_source_id" elemId="127745"/>
				<column customLabel="Child Party source_id" name="child_source_id" elemId="127746"/>
				<column customLabel="Child Party master_id" name="party_child_master_id" elemId="127755"/>
				<column customLabel="Parent Party master_id" name="party_parent_master_id" elemId="127756"/>
			</columns>
		</instanceTable>
		<instanceTable name="id_document_instance" elemId="155032" label="ID Document" instanceTable="id_document" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="155364">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="155365" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="155366" format=""/>
									<column lookupType="" name="master_id" elemId="155367" format=""/>
									<column lookupType="" name="eng_active" elemId="155368" format=""/>
									<column lookupType="" name="eng_origin" elemId="155369" format=""/>
									<column lookupType="" name="eng_source_system" elemId="155370" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="155371" format=""/>
									<column lookupType="" name="source_id" elemId="155372" format=""/>
									<column lookupType="" name="party_source_id" elemId="155373" format=""/>
									<column lookupType="" name="src_type" elemId="155374" format=""/>
									<column lookupType="" name="cio_type" elemId="155375" format=""/>
									<column lookupType="" name="dic_type" elemId="155376" format=""/>
									<column lookupType="" name="src_value" elemId="155377" format=""/>
									<column lookupType="" name="cio_value" elemId="155378" format=""/>
									<column lookupType="" name="cio_id_document_comp" elemId="155379" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="155381" format=""/>
									<column lookupType="" name="party_master_id" elemId="155383" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns/>
		</instanceTable>
		<instanceTable name="rel_prod2prod_instance" elemId="20249" label="Product to Product Relation" instanceTable="rel_prod2prod" topLevel="false">
			<guiTab>
				<views>
					<breadcrumbView allColumns="false" elemId="28544">
						<columns>
							<column name="cio_rel_type" elemId="28545"/>
							<column name="cio_rel_category" elemId="28546"/>
						</columns>
					</breadcrumbView>
					<detailView elemId="29163">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="29164" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="29165" format=""/>
									<column lookupType="" name="eng_active" elemId="29166" format=""/>
									<column lookupType="" name="eng_origin" elemId="29167" format=""/>
									<column lookupType="" name="eng_source_system" elemId="29168" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="29169" format=""/>
									<column lookupType="" name="master_id" elemId="29170" format=""/>
									<column lookupType="" name="source_id" elemId="29171" format=""/>
									<column lookupType="" name="parent_source_id" elemId="29172" format=""/>
									<column lookupType="" name="child_source_id" elemId="29173" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="data" elemId="29797" label="Relationship Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="parent_source_id" elemId="29798" format=""/>
									<column lookupType="" name="child_source_id" elemId="29799" format=""/>
									<column lookupType="" name="src_rel_type" elemId="29800" format=""/>
									<column lookupType="" name="cio_rel_type" elemId="29801" format=""/>
									<column lookupType="" name="src_rel_category" elemId="29802" format=""/>
									<column lookupType="" name="cio_rel_category" elemId="29803" format=""/>
									<column lookupType="" name="product_child_master_id" elemId="29804" format=""/>
									<column lookupType="" name="product_parent_master_id" elemId="29805" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns/>
		</instanceTable>
		<instanceTable name="product_instance" elemId="20299" label="" instanceTable="product" topLevel="false">
			<guiTab>
				<views>
					<breadcrumbView allColumns="false" elemId="23572">
						<columns>
							<column name="cio_name" elemId="23573"/>
							<column name="cio_type" elemId="23574"/>
						</columns>
					</breadcrumbView>
					<detailView elemId="20156">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="20157" label="Basic Product Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="20158" format=""/>
									<column lookupType="" name="master_id" elemId="24493" format=""/>
									<column lookupType="" name="source_id" elemId="24494" format=""/>
									<column lookupType="" name="eng_active" elemId="24495" format=""/>
									<column lookupType="" name="eng_source_system" elemId="24496" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="20159" format=""/>
									<column lookupType="" name="mda_override" elemId="24497" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="source" elemId="24498" label="Source Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="src_name" elemId="25117" format=""/>
									<column lookupType="" name="src_description" elemId="25118" format=""/>
									<column lookupType="" name="src_type" elemId="25119" format=""/>
									<column lookupType="" name="src_status" elemId="25120" format=""/>
									<column lookupType="" name="src_package_flag" elemId="25121" format=""/>
									<column lookupType="" name="src_valid_to" elemId="25122" format=""/>
									<column lookupType="" name="src_valid_from" elemId="25123" format=""/>
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="right" name="cleansed" elemId="24499" label="Cleansed Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="cio_name" elemId="25736" format=""/>
									<column lookupType="" name="cio_description" elemId="25737" format=""/>
									<column lookupType="" name="cio_type" elemId="25738" format=""/>
									<column lookupType="" name="cio_status" elemId="25739" format=""/>
									<column lookupType="" name="cio_package_flag" elemId="25740" format=""/>
									<column lookupType="" name="cio_valid_to" elemId="25741" format=""/>
									<column lookupType="" name="cio_valid_from" elemId="25742" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns/>
		</instanceTable>
		<instanceTable name="rel_prod2contract_instance" elemId="20309" label="" instanceTable="rel_prod2contract" topLevel="false">
			<guiTab>
				<views>
					<breadcrumbView allColumns="false" elemId="26898">
						<columns>
							<column name="src_variant" elemId="26899"/>
						</columns>
					</breadcrumbView>
					<detailView elemId="27966">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="27967" label="Basic Information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="27968" format=""/>
									<column lookupType="" name="eng_active" elemId="27969" format=""/>
									<column lookupType="" name="eng_origin" elemId="27970" format=""/>
									<column lookupType="" name="eng_source_system" elemId="27971" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="27972" format=""/>
									<column lookupType="" name="source_id" elemId="27973" format=""/>
									<column lookupType="" name="prd_source_id" elemId="27974" format=""/>
									<column lookupType="" name="ctr_source_id" elemId="27975" format=""/>
									<column lookupType="" name="src_variant" elemId="27976" format=""/>
									<column lookupType="" name="prd_master_id" elemId="27977" format=""/>
								</columns>
							</labeledGroup>
						</groups>
					</detailView>
				</views>
				<computedColumns/>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<columns/>
		</instanceTable>
	</instanceTables>
	<guiConfig enableGui="true" guiSystem="mda" guiMode="Read-Write">
		<hierarchies>
			<hierarchy1N relationship="party_has_address" elemId="26435438" label="Party has Address">
				<startPoint position="1,0.5,0.5,0" label="Adr"/>
				<endPoint position="0,0.5,-0.5,0" label="Pty"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
			</hierarchy1N>
			<hierarchyMN tableMN="rel_party_party" elemId="104153" label="Party has Party">
				<startPoint position="0.5,1,0,0.2" label="PLo"/>
				<endPoint position="0.5,0,0,-0.2" label="PUp"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${cmo_p2p_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_party2contract_instance" elemId="26436602" label="Party has Contract">
				<startPoint position="0,0.5,-0.5,0" label="Ctr"/>
				<endPoint position="1,0.5,0.5,0" label="Pty"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${src_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_prod2contract_instance" elemId="8976" label="Product is sold Contract">
				<startPoint position="1,0.5,0.5,0" label="Ctr"/>
				<endPoint position="0,0.5,-0.5,0" label="Prd"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${src_variant}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_prod2prod" elemId="11595" label="Product has parent Product">
				<startPoint position="0.5,0,0,-0.5" label="PUp"/>
				<endPoint position="0.5,1,0,0.5" label="PLo"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${cmo_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
		</hierarchies>
		<actions hierarchies="true" revert="true" manualExceptions="true" edit="true" deactivate="true" create="true"/>
		<indicators dqi="true"/>
		<batchOperations guiInitialLoad="false" guiFullLoad="false" guiLoadAllEntities="true">
			<loadedEntities/>
		</batchOperations>
	</guiConfig>
</masterModel>