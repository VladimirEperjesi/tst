<?xml version='1.0' encoding='UTF-8'?>
<masterModel name="norm" elemId="22817">
	<description>Normilized example</description>
	<relationships>
		<relationship parentRole="person" name="party_has_address" elemId="22894" childRole="addresses_per" label="Party has Address" type="" parentTable="person" childTable="address">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109192" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master_per" name="party_has_instance" elemId="22897" childRole="instances" label="Party has Instance Details" type="" parentTable="person" childTable="party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109194" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="person" name="party_has_contact" elemId="36452" childRole="contacts_per" label="Party has Contact" type="" parentTable="person" childTable="contact">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109196" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="parent_person" name="party_has_parent_party_per" elemId="36626" childRole="relparent_person" label="Party has Parent Party" type="" parentTable="person" childTable="rel_per_per">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109198" childColumn="parent_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="child" name="party_has_child_party_per" elemId="36673" childRole="relchild" label="Party has Child Party" type="" parentTable="person" childTable="rel_per_per">
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
		<relationship parentRole="master_per" name="relation_party_has_instance_per" elemId="78629" childRole="instances_per" label="Relation has Instance Details" type="" parentTable="rel_per_per" childTable="rel_party_party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109209" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="person" name="party_has_id_document" elemId="26377853" childRole="id_documents_per" label="Party has ID Document" type="" parentTable="person" childTable="id_document">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109211" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="id_document_has_instance" elemId="156412" childRole="" label="" type="" parentTable="id_document" childTable="id_document_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="156744" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="parent_org" name="party_has_parent_party_org" elemId="13243" childRole="relparent_org" label="Party has Parent Party" type="" parentTable="organisation" childTable="rel_org_org">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109198" childColumn="parent_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="child_org" name="party_has_child_party_org" elemId="13249" childRole="relchild_org" label="Party has Child Party" type="" parentTable="organisation" childTable="rel_org_org">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109200" childColumn="child_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master_org" name="party_has_instance_2" elemId="16006" childRole="instances" label="Party has Instance Details" type="" parentTable="organisation" childTable="party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109194" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="parent_per" name="person_has_organisation" elemId="17353" childRole="relparent_per" label="Party has Parent Party" type="" parentTable="person" childTable="rel_party_party">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109198" childColumn="parent_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="child" name="organisation_has_person" elemId="17359" childRole="relchild" label="Party has Child Party" type="" parentTable="organisation" childTable="rel_party_party">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109200" childColumn="child_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_address_2" elemId="18713" childRole="addresses" label="Party has Address" type="" parentTable="organisation" childTable="address">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109192" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="party" name="party_has_id_document_2" elemId="19253" childRole="id_documents" label="Party has ID Document" type="" parentTable="organisation" childTable="id_document">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109211" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="" name="party_has_contact_2" elemId="19627" childRole="contacts" label="Party has Contact" type="" parentTable="organisation" childTable="contact">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109196" childColumn="party_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="contract" name="contract_has_party_per" elemId="111450" childRole="person" label="Contract has Person" type="" parentTable="contract_instance" childTable="rel_per_cntrct_i">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="18109207" childColumn="contract_source_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="contract" name="contract_has_party_org" elemId="111458" childRole="org" label="Contract has Organisation" type="" parentTable="contract_instance" childTable="rel_org_cntrct_i">
			<description></description>
			<foreignKey>
				<column parentColumn="source_id" elemId="18109207" childColumn="contract_source_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="org" name="org_has_contract" elemId="111466" childRole="contract" label="Organisation has Contract" type="" parentTable="organisation" childTable="rel_org_cntrct_i">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109205" childColumn="pty_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="person" name="per_has_contract" elemId="111474" childRole="contract" label="Person has Contract" type="" parentTable="person" childTable="rel_per_cntrct_i">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109205" childColumn="pty_id"/>
			</foreignKey>
			<advanced ignoreRelGui="false">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master_org" name="relation_party_has_instance_org" elemId="25249" childRole="instances_org" label="Relation has Instance Details" type="" parentTable="rel_org_org" childTable="rel_party_party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109209" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="true">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
		<relationship parentRole="master_pty" name="relation_party_has_instance_party" elemId="26648" childRole="instances_pty" label="Relation has Instance Details" type="" parentTable="rel_party_party" childTable="rel_party_party_instance">
			<description></description>
			<foreignKey>
				<column parentColumn="id" elemId="18109209" childColumn="master_id"/>
			</foreignKey>
			<advanced ignoreRelGui="true">
				<extendedSameSystem parentColumn="" childColumn=""/>
			</advanced>
		</relationship>
	</relationships>
	<masterTables>
		<masterTable name="organisation" elemId="12691" label="Master organisation" entityRole="golden" instanceTable="party" topLevel="true">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22887" label="ID" type="long_int" size=""/>
				<column isCmo="true" refData="party_type" isPk="false" isFk="false" description="" name="type" elemId="128185" label="Customer Type" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="company_name" elemId="128187" label="Company Name" type="string" size="200"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="business_number" elemId="128188" label="Business Number" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="established_date" elemId="128189" label="Established Date" type="day" size=""/>
				<column isCmo="true" refData="legal_form" isPk="false" isFk="false" description="" name="legal_form" elemId="26381948" label="Business Form" type="string" size="30"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="166199">
						<groups>
							<labeledGroup templatePosition="left" name="party_basic" elemId="87506" label="Basic personal information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="47828" format=""/>
									<column lookupType="" name="cmo_type" elemId="87507" format=""/>
									<column lookupType="" name="cmo_company_name" elemId="47829" format=""/>
									<column lookupType="" name="cmo_business_number" elemId="47830" format=""/>
									<column lookupType="" name="cmo_established_date" elemId="47831" format=""/>
									<column lookupType="" name="cmo_legal_form" elemId="47832" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedList relationship="party_has_address_2" templatePosition="right" name="address" elemId="158834" label="Address">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${address_single_line}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_id_document_2" templatePosition="right" name="id_doc" elemId="111272" label="ID document">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_contact_2" templatePosition="right" name="contact" elemId="159802" label="Contact">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedMNList relationship="party_has_parent_party_org" entity_out="organisation" templatePosition="left" name="o2o_child" elemId="160124" relationship_out="party_has_child_party_org" label="Child Organisation">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ChildId:${child_id} | RelType: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Organisation</firstColumnFormat>
									<secondColumnFormat>${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="party_has_child_party_org" entity_out="organisation" templatePosition="left" name="o2o_parent" elemId="122759" relationship_out="party_has_parent_party_org" label="Organisation Parent">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ParentId:${parent_id} | RelType: ${cmo_p2p_rel_type}&quot;</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Company</firstColumnFormat>
									<secondColumnFormat>${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="organisation_has_person" entity_out="person" templatePosition="left" name="o2p" elemId="130114" relationship_out="person_has_organisation" label="Person">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>OrgId:${parent_id} | RelType: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Person</firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="org_has_contract" entity_out="contract_instance" templatePosition="right" name="o2c" elemId="38223" relationship_out="contract_has_party_org" label="Contract">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Contract Id: ${contract_source_id}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Contract</firstColumnFormat>
									<secondColumnFormat>${src_type}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<listGrid relationship="party_has_instance_2" templatePosition="bottom" name="list" elemId="97076" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="34112" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="34113" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="uni" elemId="34114" label="Instances: matching results" columnMask="">
										<columns>
											<column name="eng_source_system" elemId="48665"/>
											<column name="source_id" elemId="48666"/>
											<column name="master_id" elemId="48668"/>
											<column name="uni_rule_name" elemId="48669"/>
											<column name="uni_match_quality" elemId="17415"/>
											<column name="uni_match_id" elemId="17416"/>
										</columns>
									</list>
									<list name="all" elemId="34115" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="58294">
						<columns>
							<column name="cmo_company_name" elemId="58295"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="customer_single_line" elemId="26383506" label="Customer in Single Line">
						<producer>nvl(getMdaValString(&#39;cmo_company_name&#39;))</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>(eng_active = true or eng_source_system = &#39;mda&#39;) and cio_type = &#39;C&#39;</inputFilterExpression>
				<specialColumns>
					<column name="dq_indicator" elemId="7797" label="" type="integer" size="">
						<description></description>
					</column>
					<column name="dq_indicator_name" elemId="7798" label="" type="string" size="10">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns/>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="4055"/>
					<column nmeMapping="src_company_name" name="cmo_company_name" elemId="4061"/>
					<column nmeMapping="src_business_number" name="cmo_business_number" elemId="4062"/>
					<column nmeMapping="src_established_date" name="cmo_established_date" elemId="4063"/>
					<column nmeMapping="src_legal_form" name="cmo_legal_form" elemId="4064"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="person" elemId="22867" label="Master person" entityRole="golden" instanceTable="party" topLevel="true">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22887" label="ID" type="long_int" size=""/>
				<column isCmo="true" refData="party_type" isPk="false" isFk="false" description="" name="type" elemId="128185" label="Customer Type" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="first_name" elemId="22868" label="Firstname" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="last_name" elemId="29082" label="Lastname" type="string" size="100"/>
				<column isCmo="true" refData="gender" isPk="false" isFk="false" description="" name="gender" elemId="36720" label="Gender" type="string" size="10"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="birth_date" elemId="36721" label="Birth Date" type="day" size=""/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="sin" elemId="128186" label="Social Insurance Number" type="string" size="30"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="87505">
						<groups>
							<labeledGroup templatePosition="left" name="party_basic" elemId="87506" label="Basic personal information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="cmo_type" elemId="87507" format=""/>
									<column lookupType="" name="cmo_first_name" elemId="87508" format=""/>
									<column lookupType="" name="cmo_last_name" elemId="87509" format=""/>
									<column lookupType="" name="cmo_gender" elemId="87510" format=""/>
									<column lookupType="" name="cmo_birth_date" elemId="87511" format=""/>
									<column lookupType="" name="cmo_sin" elemId="87512" format=""/>
									<column lookupType="" name="age" elemId="87513" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedList relationship="party_has_address" templatePosition="right" name="address" elemId="158834" label="Address">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${address_single_line}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_id_document" templatePosition="right" name="id_doc" elemId="111272" label="ID document">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedList relationship="party_has_contact" templatePosition="right" name="contact" elemId="159802" label="Contact">
								<viewCondition></viewCondition>
								<linkedRecordParams>
									<firstColumnFormat>${cmo_type}</firstColumnFormat>
									<secondColumnFormat>${cmo_value}</secondColumnFormat>
								</linkedRecordParams>
							</labeledRelatedList>
							<labeledRelatedMNList relationship="party_has_child_party_per" entity_out="person" templatePosition="left" name="p2p_parent" elemId="160124" relationship_out="party_has_parent_party_per" label="Parent Person">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ParentId: ${parent_id} | RelType: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Person: </firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="party_has_parent_party_per" entity_out="person" templatePosition="left" name="p2p_child" elemId="122759" relationship_out="party_has_child_party_per" label="Child person">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ChildId:${child_id} | RelType: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Person</firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="person_has_organisation" entity_out="organisation" templatePosition="left" name="p2o" elemId="36639" relationship_out="organisation_has_person" label="Organisation">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ParentId:${parent_id} | RelType: ${cmo_p2p_rel_type}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Organisation</firstColumnFormat>
									<secondColumnFormat>${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="per_has_contract" entity_out="contract_instance" templatePosition="right" name="p2c" elemId="130114" relationship_out="contract_has_party_per" label="Contract">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>Contract Id: ${contract_source_id}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Contract</firstColumnFormat>
									<secondColumnFormat>${src_type}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<listGrid relationship="party_has_instance" templatePosition="bottom" name="list" elemId="97076" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="33735" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="33736" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="uni" elemId="33737" label="Instances: matching results" columnMask="">
										<columns>
											<column name="eng_source_system" elemId="48665"/>
											<column name="source_id" elemId="48666"/>
											<column name="master_id" elemId="48668"/>
											<column name="uni_rule_name" elemId="48669"/>
											<column name="uni_match_quality" elemId="17415"/>
											<column name="uni_match_id" elemId="17416"/>
										</columns>
									</list>
									<list name="all" elemId="33738" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="10691">
						<columns>
							<column name="cmo_first_name" elemId="10692"/>
							<column name="cmo_last_name" elemId="10693"/>
						</columns>
					</breadcrumbView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="age" elemId="657533" label="Age">
						<producer>toString(floor(dateDiff(getMdaValDatetime(&#39;cmo_birth_date&#39;), now(), &#39;DAY&#39;)/365))</producer>
					</column>
					<column indexType="BOTH" dataType="string" description="" name="customer_single_line" elemId="26383506" label="Customer in Single Line">
						<producer>nvl(getMdaValString(&#39;cmo_first_name&#39;) + &#39; &#39; + getMdaValString(&#39;cmo_last_name&#39;))</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>(eng_active = true or eng_source_system = &#39;mda&#39;) and cio_type = &#39;P&#39;</inputFilterExpression>
				<specialColumns>
					<column name="dq_indicator" elemId="7797" label="" type="integer" size="">
						<description></description>
					</column>
					<column name="dq_indicator_name" elemId="7798" label="" type="string" size="10">
						<description></description>
					</column>
				</specialColumns>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns/>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="4055"/>
					<column nmeMapping="src_first_name" name="cmo_first_name" elemId="4056"/>
					<column nmeMapping="src_last_name" name="cmo_last_name" elemId="4057"/>
					<column nmeMapping="src_gender" name="cmo_gender" elemId="4058"/>
					<column nmeMapping="src_birth_date" name="cmo_birth_date" elemId="4059"/>
					<column nmeMapping="src_sin" name="cmo_sin" elemId="4060"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="address" elemId="22881" label="Master address" entityRole="silver" instanceTable="address" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22885" label="ID" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="22891" label="Party ID" type="long_int" size="30"/>
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
									<column lookupType="" name="party_id" elemId="515446" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="address_has_instance" templatePosition="bottom" name="instances" elemId="515582" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="34489" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="34490" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="34491" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="address_single_line" elemId="26379312" label="Address Information">
						<producer>getMdaValString(&#39;cmo_street&#39;) + &#39;, &#39; + getMdaValString(&#39;cmo_city&#39;)</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>eng_active = true or eng_source_system = &#39;mda&#39;</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_address" name="party_source_id" elemId="61493"/>
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
		<masterTable name="contact" elemId="36374" label="Master contact" entityRole="silver" instanceTable="contact" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="22885" label="ID (Contact PK)" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="22891" label="Party Id" type="long_int" size="30"/>
				<column isCmo="true" refData="contact_type" isPk="false" isFk="false" description="" name="type" elemId="35288" label="Contact Type" type="string" size="100"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="value" elemId="35289" label="Contact Value" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<breadcrumbView allColumns="false" elemId="34864">
						<columns>
							<column name="cmo_value" elemId="34865"/>
						</columns>
					</breadcrumbView>
					<detailView elemId="61661">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="62617" label="Contact">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="62618" format=""/>
									<column lookupType="" name="party_id" elemId="62619" format=""/>
									<column lookupType="" name="eng_active" elemId="62620" format=""/>
									<column lookupType="" name="cmo_type" elemId="62621" format=""/>
									<column lookupType="" name="cmo_value" elemId="62622" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="contact_has_instance" templatePosition="bottom" name="list" elemId="61662" label="Contact instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="34866" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="34867" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="34868" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
				</views>
				<computedColumns>
					<column indexType="BOTH" dataType="string" description="" name="contact_label" elemId="26380143" label="Contact Label">
						<producer>getMdaValString(&#39;cmo_type&#39;) + &#39; contact&#39;</producer>
					</column>
				</computedColumns>
				<reduceES allColumns="true">
					<reduceColumns/>
				</reduceES>
			</guiTab>
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression></inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_contact" name="party_source_id" elemId="62366"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="10554"/>
					<column nmeMapping="src_value" name="cmo_value" elemId="10555"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_party_party" elemId="12692" label="Master party to party relations" entityRole="silver" instanceTable="rel_party2party" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="36520" label="id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="parent_id" elemId="36592" label="parent_id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="child_id" elemId="36590" label="child_id" type="long_int" size="30"/>
				<column isCmo="true" refData="rel_pty2pty_type" isPk="false" isFk="false" description="" name="p2p_rel_type" elemId="36593" label="p2p_rel_type" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="103869">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="103871" label="Party to Party relation">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="103872" format=""/>
									<column lookupType="" name="eng_active" elemId="103873" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="103874" format=""/>
									<column lookupType="" name="parent_id" elemId="103875" format=""/>
									<column lookupType="" name="child_id" elemId="103876" format=""/>
									<column lookupType="" name="cmo_p2p_rel_type" elemId="103877" format=""/>
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
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>(party_parent_cio_type = &#39;C&#39; and party_child_cio_type = &#39;P&#39;) or (party_parent_cio_type = &#39;P&#39; and party_child_cio_type = &#39;C&#39;)</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="organisation_has_person" name="child_source_id" elemId="10612"/>
					<parentColumn relationship="person_has_organisation" name="parent_source_id" elemId="21364"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_rel_type" name="cmo_p2p_rel_type" elemId="10224"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_org_org" elemId="12693" label="Master party to party relations" entityRole="silver" instanceTable="rel_party2party" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="36520" label="id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="parent_id" elemId="36592" label="parent_id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="child_id" elemId="36590" label="child_id" type="long_int" size="30"/>
				<column isCmo="true" refData="rel_pty2pty_type" isPk="false" isFk="false" description="" name="p2p_rel_type" elemId="36593" label="p2p_rel_type" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="104280">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="104282" label="Org to Org relation">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="104283" format=""/>
									<column lookupType="" name="eng_active" elemId="104284" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="104285" format=""/>
									<column lookupType="" name="parent_id" elemId="104286" format=""/>
									<column lookupType="" name="child_id" elemId="104287" format=""/>
									<column lookupType="" name="cmo_p2p_rel_type" elemId="104288" format=""/>
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
			<advanced groupColumn="" customActivity="true">
				<inputFilterExpression>(party_parent_cio_type = &#39;C&#39; and party_child_cio_type = &#39;C&#39;) or (party_parent_cio_type = &#39;C&#39; and party_child_cio_type = &#39;C&#39;)</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_child_party_org" name="child_source_id" elemId="43257"/>
					<parentColumn relationship="party_has_parent_party_org" name="parent_source_id" elemId="43258"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_rel_type" name="cmo_p2p_rel_type" elemId="10224"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_per_per" elemId="36496" label="Master party to party relations" entityRole="silver" instanceTable="rel_party2party" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="36520" label="id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="parent_id" elemId="36592" label="parent_id" type="long_int" size="30"/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="child_id" elemId="36590" label="child_id" type="long_int" size="30"/>
				<column isCmo="true" refData="rel_pty2pty_type" isPk="false" isFk="false" description="" name="p2p_rel_type" elemId="36593" label="p2p_rel_type" type="string" size="100"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="26375491">
						<groups>
							<labeledGroup templatePosition="left" name="basic" elemId="26375492" label="Person to Person relation">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="26375493" format=""/>
									<column lookupType="" name="parent_id" elemId="26375494" format=""/>
									<column lookupType="" name="child_id" elemId="26375495" format=""/>
									<column lookupType="" name="cmo_p2p_rel_type" elemId="26375496" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="relation_party_has_instance_per" templatePosition="bottom" name="list" elemId="103483" label="Instances">
								<viewCondition></viewCondition>
								<lists/>
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
				<inputFilterExpression>(party_parent_cio_type = &#39;P&#39; and party_child_cio_type = &#39;P&#39;) or (party_parent_cio_type = &#39;P&#39; and party_child_cio_type = &#39;P&#39;)</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_child_party_per" name="child_source_id" elemId="43257"/>
					<parentColumn relationship="party_has_parent_party_per" name="parent_source_id" elemId="43258"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_rel_type" name="cmo_p2p_rel_type" elemId="10224"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="id_document" elemId="26377244" label="ID Document" entityRole="silver" instanceTable="id_document" topLevel="false">
			<description>Identification Document - usually driving licence, ID card, or Passport</description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="26373988" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="party_id" elemId="26374577" label="" type="long_int" size=""/>
				<column isCmo="true" refData="id_document_type" isPk="false" isFk="false" description="" name="type" elemId="26373989" label="" type="string" size="30"/>
				<column isCmo="true" refData="" isPk="false" isFk="false" description="" name="value" elemId="26373990" label="" type="string" size="100"/>
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
									<column lookupType="" name="party_id" elemId="26374212" format=""/>
								</columns>
							</labeledGroup>
							<listGrid relationship="id_document_has_instance" templatePosition="bottom" name="list" elemId="154687" label="Instances">
								<viewCondition></viewCondition>
								<lists>
									<list name="src" elemId="35244" label="Instances: source columns" columnMask="^src_*">
										<columns>
											<column name="source_id" elemId="49892"/>
											<column name="eng_source_system" elemId="45893"/>
										</columns>
									</list>
									<list name="std" elemId="35245" label="Instances: standardized columns" columnMask="^std_*">
										<columns>
											<column name="source_id" elemId="49494"/>
											<column name="eng_source_system" elemId="49495"/>
										</columns>
									</list>
									<list name="all" elemId="35246" label="Instances: all columns" columnMask="">
										<columns/>
									</list>
								</lists>
							</listGrid>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="35247">
						<columns>
							<column name="cmo_value" elemId="35248"/>
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
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="use global setting (from GUI Configuration)">
				<parentColumns>
					<parentColumn relationship="party_has_id_document" name="party_source_id" elemId="63233"/>
				</parentColumns>
				<editColumns>
					<column nmeMapping="src_type" name="cmo_type" elemId="10717"/>
					<column nmeMapping="src_value" name="cmo_value" elemId="10718"/>
				</editColumns>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_per_cntrct_i" elemId="9385" label="Instance person to contract roles" entityRole="silver" instanceTable="rel_party2contract" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="12710" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="pty_id" elemId="13257" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="contract_source_id" elemId="13258" label="" type="string" size="1000"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="110992">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="110993" label="Details">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="110994" format=""/>
									<column lookupType="" name="eng_active" elemId="110995" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="110996" format=""/>
									<column lookupType="" name="pty_id" elemId="110997" format=""/>
									<column lookupType="" name="contract_source_id" elemId="110998" format=""/>
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
			<advanced groupColumn="" customActivity="false">
				<inputFilterExpression>party_parent_cio_type = &#39;P&#39;</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="Read-Only">
				<parentColumns/>
				<editColumns/>
			</guiEdit>
		</masterTable>
		<masterTable name="rel_org_cntrct_i" elemId="9666" label="Instance organisation to contract roles" entityRole="silver" instanceTable="rel_party2contract" topLevel="false">
			<description></description>
			<columns>
				<column isCmo="false" refData="" isPk="true" isFk="false" description="" name="id" elemId="12985" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="pty_id" elemId="13539" label="" type="long_int" size=""/>
				<column isCmo="false" refData="" isPk="false" isFk="true" description="" name="contract_source_id" elemId="13540" label="" type="string" size="1000"/>
			</columns>
			<guiTab>
				<views>
					<detailView elemId="111404">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="110993" label="Details">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="110994" format=""/>
									<column lookupType="" name="eng_active" elemId="110995" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="110996" format=""/>
									<column lookupType="" name="pty_id" elemId="110997" format=""/>
									<column lookupType="" name="contract_source_id" elemId="110998" format=""/>
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
			<advanced groupColumn="" customActivity="false">
				<inputFilterExpression>party_parent_cio_type = &#39;C&#39;</inputFilterExpression>
				<specialColumns/>
			</advanced>
			<guiEdit guiReadOnly="Read-Only">
				<parentColumns/>
				<editColumns/>
			</guiEdit>
		</masterTable>
	</masterTables>
	<instanceTables>
		<instanceTable name="party_instance" elemId="22862" label="Instance party" instanceTable="party" topLevel="false">
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
				<column customLabel="ID" name="id" elemId="211582"/>
				<column customLabel="Firstname" name="src_first_name" elemId="211585"/>
				<column customLabel="Firstname" name="std_first_name" elemId="211586"/>
				<column customLabel="Lastname" name="src_last_name" elemId="211593"/>
				<column customLabel="Lastname" name="std_last_name" elemId="211594"/>
				<column customLabel="Company Name" name="src_company_name" elemId="26380077"/>
				<column customLabel="" name="src_business_number" elemId="26380078"/>
				<column customLabel="" name="src_legal_form" elemId="26380079"/>
				<column customLabel="" name="src_established_date" elemId="26380080"/>
				<column customLabel="" name="src_gender" elemId="211597"/>
				<column customLabel="" name="src_birth_date" elemId="211601"/>
				<column customLabel="" name="std_birth_date" elemId="211602"/>
				<column customLabel="" name="exp_birth_date" elemId="211603"/>
				<column customLabel="" name="sco_birth_date" elemId="211604"/>
				<column customLabel="" name="src_sin" elemId="211605"/>
				<column customLabel="" name="std_sin" elemId="211606"/>
				<column customLabel="" name="exp_sin" elemId="211607"/>
				<column customLabel="" name="sco_sin" elemId="211608"/>
				<column customLabel="" name="uni_rule_name" elemId="657845"/>
				<column customLabel="Source Data ID" name="source_id" elemId="211583"/>
				<column customLabel="Master Party ID" name="master_id" elemId="211584"/>
			</columns>
		</instanceTable>
		<instanceTable name="contact_instance" elemId="36790" label="Instance contact" instanceTable="contact" topLevel="false">
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
				<column customLabel="" name="id" elemId="510184"/>
				<column customLabel="" name="source_id" elemId="510185"/>
				<column customLabel="" name="master_id" elemId="510186"/>
				<column customLabel="" name="src_type" elemId="509827"/>
				<column customLabel="" name="src_value" elemId="509831"/>
				<column customLabel="" name="std_value" elemId="509832"/>
				<column customLabel="" name="exp_value" elemId="509833"/>
				<column customLabel="" name="sco_value" elemId="509834"/>
				<column customLabel="" name="party_master_id" elemId="658070"/>
			</columns>
		</instanceTable>
		<instanceTable name="address_instance" elemId="36923" label="Instance address" instanceTable="address" topLevel="false">
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
								</columns>
							</labeledGroup>
							<labeledGroup templatePosition="left" name="source" elemId="26373349" label="Source Data">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="eng_source_system" elemId="18081449" format=""/>
									<column lookupType="" name="eng_origin" elemId="18081914" format=""/>
									<column lookupType="" name="src_type" elemId="26373767" format=""/>
									<column lookupType="" name="src_street" elemId="26373768" format=""/>
									<column lookupType="" name="src_city" elemId="26373769" format=""/>
									<column lookupType="" name="src_zip" elemId="26373771" format=""/>
									<column lookupType="" name="src_state" elemId="26373770" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="18081450" format=""/>
									<column lookupType="" name="eng_active" elemId="18081915" format=""/>
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
				<column customLabel="ID" name="id" elemId="658295"/>
				<column customLabel="Address id" name="source_id" elemId="658296"/>
				<column customLabel="Party id" name="party_source_id" elemId="658298"/>
				<column customLabel="Street" name="src_street" elemId="177816"/>
				<column customLabel="Street" name="cio_street" elemId="177817"/>
				<column customLabel="City" name="src_city" elemId="177818"/>
				<column customLabel="City" name="cio_city" elemId="177819"/>
				<column customLabel="State" name="src_state" elemId="180252"/>
				<column customLabel="State" name="cio_state" elemId="658299"/>
				<column customLabel="ZIP" name="src_zip" elemId="658300"/>
				<column customLabel="ZIP" name="cio_zip" elemId="658301"/>
				<column customLabel="Cleansing Explanation" name="exp_address" elemId="658302"/>
				<column customLabel="Cleansing Score" name="sco_address" elemId="658303"/>
				<column customLabel="Party master_id" name="party_master_id" elemId="658304"/>
				<column customLabel="Address Component" name="cio_address_comp" elemId="26375003"/>
				<column customLabel="Verified Address Type" name="dic_type" elemId="26375638"/>
				<column customLabel="Address master_id" name="master_id" elemId="172557"/>
				<column customLabel="Type" name="src_type" elemId="172897"/>
			</columns>
		</instanceTable>
		<instanceTable name="rel_party_party_instance" elemId="78553" label="Instance party to party relations" instanceTable="rel_party2party" topLevel="false">
			<guiTab>
				<views>
					<detailView elemId="110191">
						<groups>
							<labeledGroup templatePosition="left" name="grp" elemId="110192" label="Attributes">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="110193" format=""/>
									<column lookupType="" name="eng_active" elemId="110194" format=""/>
									<column lookupType="" name="eng_origin" elemId="110195" format=""/>
									<column lookupType="" name="eng_source_system" elemId="110196" format=""/>
									<column lookupType="" name="eng_last_update_date" elemId="110197" format=""/>
									<column lookupType="" name="master_id" elemId="110198" format=""/>
									<column lookupType="" name="source_id" elemId="110199" format=""/>
									<column lookupType="" name="parent_source_id" elemId="110200" format=""/>
									<column lookupType="" name="child_source_id" elemId="110201" format=""/>
									<column lookupType="" name="src_rel_type" elemId="110202" format=""/>
									<column lookupType="" name="src_p2p_valid_from" elemId="110203" format=""/>
									<column lookupType="" name="std_p2p_valid_from" elemId="110204" format=""/>
									<column lookupType="" name="cio_p2p_valid_from" elemId="110205" format=""/>
									<column lookupType="" name="exp_p2p_valid_from" elemId="110206" format=""/>
									<column lookupType="" name="sco_p2p_valid_from" elemId="110207" format=""/>
									<column lookupType="" name="src_p2p_valid_to" elemId="110208" format=""/>
									<column lookupType="" name="std_p2p_valid_to" elemId="110209" format=""/>
									<column lookupType="" name="cio_p2p_valid_to" elemId="110210" format=""/>
									<column lookupType="" name="exp_p2p_valid_to" elemId="110211" format=""/>
									<column lookupType="" name="sco_p2p_valid_to" elemId="110212" format=""/>
									<column lookupType="" name="dic_rel_type" elemId="110214" format=""/>
									<column lookupType="" name="uni_rule_name" elemId="110217" format=""/>
									<column lookupType="" name="party_child_master_id" elemId="110219" format=""/>
									<column lookupType="" name="party_child_cio_type" elemId="110220" format=""/>
									<column lookupType="" name="party_parent_master_id" elemId="110221" format=""/>
									<column lookupType="" name="party_parent_cio_type" elemId="110222" format=""/>
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
				<column customLabel="" name="id" elemId="127730"/>
				<column customLabel="" name="master_id" elemId="127731"/>
				<column customLabel="" name="parent_source_id" elemId="127745"/>
				<column customLabel="" name="child_source_id" elemId="127746"/>
				<column customLabel="" name="party_child_master_id" elemId="127755"/>
				<column customLabel="" name="party_parent_master_id" elemId="127756"/>
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
		<instanceTable name="contract_instance" elemId="111414" label="Instance contract" instanceTable="contract" topLevel="true">
			<guiTab>
				<views>
					<detailView elemId="123613">
						<groups>
							<labeledGroup templatePosition="left" name="party_basic" elemId="87506" label="Contract instance information">
								<viewCondition></viewCondition>
								<columns>
									<column lookupType="" name="id" elemId="19163" format=""/>
									<column lookupType="" name="source_id" elemId="19164" format=""/>
									<column lookupType="" name="src_sale_point" elemId="19166" format=""/>
									<column lookupType="" name="src_status" elemId="19167" format=""/>
									<column lookupType="" name="src_type" elemId="19168" format=""/>
									<column lookupType="" name="src_variant" elemId="19169" format=""/>
									<column lookupType="" name="src_valid_from" elemId="19170" format=""/>
									<column lookupType="" name="src_valid_to" elemId="19171" format=""/>
								</columns>
							</labeledGroup>
							<labeledRelatedMNList relationship="contract_has_party_org" entity_out="organisation" templatePosition="left" name="c2o" elemId="123614" relationship_out="org_has_contract" label="Organisation">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ParentId:${pty_id}</firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Organisation: </firstColumnFormat>
									<secondColumnFormat>${cmo_company_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
							<labeledRelatedMNList relationship="contract_has_party_per" entity_out="person" templatePosition="right" name="c2p" elemId="130114" relationship_out="per_has_contract" label="Person">
								<viewCondition></viewCondition>
								<MNrelationParams>
									<firstColumnFormat>ParentId:${pty_id} </firstColumnFormat>
									<secondColumnFormat>Active: ${eng_active} | Updated: ${eng_mtdt}</secondColumnFormat>
								</MNrelationParams>
								<MNlinkedRecordsParams>
									<firstColumnFormat>Person: </firstColumnFormat>
									<secondColumnFormat>${cmo_first_name} ${cmo_last_name}</secondColumnFormat>
								</MNlinkedRecordsParams>
							</labeledRelatedMNList>
						</groups>
					</detailView>
					<breadcrumbView allColumns="false" elemId="125898">
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
				<column customLabel="ID" name="id" elemId="132473"/>
				<column customLabel="Contract Number" name="source_id" elemId="132474"/>
				<column customLabel="Contract Sale Point" name="src_sale_point" elemId="132475"/>
				<column customLabel="Contract Status" name="src_status" elemId="132480"/>
				<column customLabel="Contract Type" name="src_type" elemId="132484"/>
				<column customLabel="Valid From" name="src_valid_from" elemId="132489"/>
				<column customLabel="Valid From" name="cio_valid_from" elemId="132490"/>
				<column customLabel="Valid To" name="src_valid_to" elemId="132491"/>
				<column customLabel="Valid To" name="cio_valid_to" elemId="132492"/>
				<column customLabel="Product Family" name="product_source_id" elemId="170476"/>
			</columns>
		</instanceTable>
	</instanceTables>
	<guiConfig enableGui="false" guiSystem="mda" guiMode="Read-Only">
		<hierarchies>
			<hierarchy1N relationship="party_has_address" elemId="38989" label="Person has Address">
				<startPoint position="1,0.5,0.5,0" label="Adr"/>
				<endPoint position="0,0.5,-0.5,0" label="Per"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
			</hierarchy1N>
			<hierarchy1N relationship="party_has_address_2" elemId="35630" label="Organization has Address">
				<startPoint position="1,0.5,0.5,0" label="Adr"/>
				<endPoint position="0,0.5,-0.5,0" label="Org"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
			</hierarchy1N>
			<hierarchyMN tableMN="rel_party_party" elemId="39741" label="Person has Organization">
				<startPoint position="0.33,1,0,0.2" label="Org"/>
				<endPoint position="0.33,0,0,-0.2" label="Per"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel>cmo_p2p_rel_type</connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${cmo_p2p_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_per_per" elemId="39742" label="Person has Person">
				<startPoint position="0.66,1,0,0.2" label="Per"/>
				<endPoint position="0.66,0,0,-0.2" label="Per"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel>cmo_p2p_rel_type</connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${cmo_p2p_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_org_org" elemId="35631" label="Organization has Organization">
				<startPoint position="0.5,1,0,0.2" label="Org"/>
				<endPoint position="0.5,0,0,-0.2" label="Org"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel>cmo_p2p_rel_type</connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${cmo_p2p_rel_type}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_org_cntrct_i" elemId="37866" label="Organzation has Contract">
				<startPoint position="0,0.5,-0.5,0" label="Ctr"/>
				<endPoint position="1,0.33,0.5,0" label="Org"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${contract_source_id}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
			<hierarchyMN tableMN="rel_per_cntrct_i" elemId="35632" label="Person has Contract">
				<startPoint position="0,0.66,-0.5,0" label="Ctr"/>
				<endPoint position="1,0.66,0.5,0" label="Per"/>
				<connection connectionShape="Bezier" connectionColour="#BABABA">
					<connectionLabel></connectionLabel>
				</connection>
				<hierarchyDisplaySettings>
					<relationshipLabel>${contract_source_id}</relationshipLabel>
				</hierarchyDisplaySettings>
			</hierarchyMN>
		</hierarchies>
		<actions hierarchies="false" revert="false" manualExceptions="true" edit="false" deactivate="false" create="false"/>
		<indicators dqi="false"/>
		<batchOperations guiInitialLoad="false" guiFullLoad="false" guiLoadAllEntities="true">
			<loadedEntities/>
		</batchOperations>
	</guiConfig>
</masterModel>