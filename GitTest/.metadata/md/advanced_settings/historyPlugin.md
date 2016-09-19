<?xml version='1.0' encoding='UTF-8'?>
<historyPlugin enable="true">
	<instanceTables>
		<instanceTable allColumns="true" elemId="1583" entityName="party">
			<instanceColumns/>
		</instanceTable>
		<instanceTable allColumns="false" elemId="1581" entityName="contract">
			<instanceColumns>
				<instanceColumn trace="true" name="cio_valid_to" elemId="1582" searchable="false"/>
			</instanceColumns>
		</instanceTable>
		<instanceTable allColumns="false" elemId="71236" entityName="product">
			<instanceColumns>
				<instanceColumn trace="true" name="cio_name" elemId="17419" searchable="false"/>
				<instanceColumn trace="false" name="cio_type" elemId="17420" searchable="false"/>
			</instanceColumns>
		</instanceTable>
	</instanceTables>
	<masterTables>
		<masterTable allColumns="true" elemId="155412" entityName="party (masters)">
			<masterColumns/>
		</masterTable>
		<masterTable allColumns="false" elemId="90668" entityName="contact (masters)">
			<masterColumns>
				<masterColumn trace="true" name="party_id" elemId="90670" searchable="false"/>
				<masterColumn trace="false" name="cmo_type" elemId="22018" searchable="false"/>
				<masterColumn trace="true" name="cmo_value" elemId="22019" searchable="false"/>
			</masterColumns>
		</masterTable>
		<masterTable allColumns="true" elemId="132057" entityName="address (masters)">
			<masterColumns/>
		</masterTable>
		<masterTable allColumns="true" elemId="6671" entityName="address (norm)">
			<masterColumns/>
		</masterTable>
	</masterTables>
	<referenceDataTables>
		<referenceDataTable allColumns="true" elemId="70616" entityName="rd_address_type">
			<referenceDataColumns/>
		</referenceDataTable>
		<referenceDataTable allColumns="false" elemId="70617" entityName="rd_contact_type">
			<referenceDataColumns>
				<referenceDataColumn trace="true" name="master_code" elemId="70618" searchable="false"/>
				<referenceDataColumn trace="true" name="master_name" elemId="70619" searchable="false"/>
				<referenceDataColumn trace="false" name="source_id" elemId="70620" searchable="false"/>
			</referenceDataColumns>
		</referenceDataTable>
	</referenceDataTables>
</historyPlugin>