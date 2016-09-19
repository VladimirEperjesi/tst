<?xml version='1.0' encoding='UTF-8'?>
<exportModel>
	<fullInstanceExport scope="use global scope (from Preferences)" allEntities="false" sourceSystem="crm" name="full_instance_crm_export" elemId="199915">
		<description></description>
		<selectedTables>
			<instanceTable allColumns="true" name="party" elemId="199916">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="address" elemId="199917">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="false" name="contact" elemId="199918">
				<columns>
					<column name="src_type" elemId="9938"/>
					<column name="sco_type" elemId="9939"/>
					<column name="cio_value" elemId="9940"/>
				</columns>
			</instanceTable>
		</selectedTables>
		<advanced enableTID="false">
			<pathVariables/>
			<additionalParameters/>
		</advanced>
	</fullInstanceExport>
	<complexExport scope="use global scope (from Preferences)" name="complex_export" elemId="282942">
		<description></description>
		<dataSources>
			<instanceDataSource scope="use scope of parent export operation" allEntities="false" sourceSystem="" prefix="instD" elemId="282943" mode="delta">
				<selectedTables>
					<instanceTable allColumns="true" name="party" elemId="282944">
						<columns/>
					</instanceTable>
					<instanceTable allColumns="false" name="address" elemId="282945">
						<columns>
							<column name="id" elemId="161204"/>
							<column name="eng_source_timestamp" elemId="161205"/>
							<column name="eng_active" elemId="161206"/>
							<column name="eng_origin" elemId="161207"/>
							<column name="eng_source_system" elemId="161208"/>
							<column name="eng_last_update_date" elemId="161209"/>
							<column name="eng_last_source_update_date" elemId="161210"/>
							<column name="eng_creation_date" elemId="161211"/>
							<column name="eng_deletion_date" elemId="161212"/>
							<column name="eng_activation_date" elemId="161213"/>
							<column name="eng_deactivation_date" elemId="161214"/>
							<column name="eng_change_type" elemId="161215"/>
							<column name="eng_activity_change_type" elemId="161216"/>
							<column name="master_id" elemId="161217"/>
							<column name="source_id" elemId="161218"/>
							<column name="party_source_id" elemId="161219"/>
							<column name="src_type" elemId="161220"/>
							<column name="std_type" elemId="161221"/>
							<column name="exp_type" elemId="161222"/>
							<column name="sco_type" elemId="161223"/>
							<column name="dic_type" elemId="161224"/>
							<column name="src_street" elemId="161225"/>
							<column name="cio_street" elemId="161226"/>
							<column name="src_city" elemId="161227"/>
							<column name="cio_city" elemId="161228"/>
							<column name="src_state" elemId="161229"/>
							<column name="cio_state" elemId="161230"/>
							<column name="src_zip" elemId="161231"/>
							<column name="cio_zip" elemId="161232"/>
							<column name="exp_address" elemId="161233"/>
							<column name="sco_address" elemId="161234"/>
							<column name="cio_address_comp" elemId="161236"/>
							<column name="tmp_validity_level" elemId="161238"/>
							<column name="tmp_address_validity" elemId="161239"/>
							<column name="uni_rule_name" elemId="161241"/>
							<column name="party_master_id" elemId="161243"/>
						</columns>
					</instanceTable>
					<instanceTable allColumns="true" name="contact" elemId="282946">
						<columns/>
					</instanceTable>
				</selectedTables>
			</instanceDataSource>
			<masterDataSource scope="use scope of parent export operation" allEntities="false" prefix="masF" elemId="282947" layerName="masters" mode="full">
				<selectedTables>
					<table allColumns="true" name="party" elemId="283052">
						<columns/>
					</table>
					<table allColumns="true" name="address" elemId="283053">
						<columns/>
					</table>
					<table allColumns="false" name="contact" elemId="283054">
						<columns>
							<column name="id" elemId="160410"/>
							<column name="eng_active" elemId="160411"/>
							<column name="eng_last_update_date" elemId="160412"/>
							<column name="eng_creation_date" elemId="160413"/>
							<column name="eng_deletion_date" elemId="160414"/>
							<column name="eng_activation_date" elemId="160415"/>
							<column name="eng_deactivation_date" elemId="160416"/>
							<column name="party_id" elemId="160417"/>
							<column name="cmo_type" elemId="160418"/>
							<column name="cmo_value" elemId="160419"/>
						</columns>
					</table>
					<table allColumns="true" name="rel_party_party" elemId="283055">
						<columns/>
					</table>
				</selectedTables>
			</masterDataSource>
			<masterDataSource scope="active" allEntities="false" prefix="masD" elemId="160804" layerName="masters" mode="delta">
				<selectedTables>
					<table allColumns="true" name="party" elemId="160805">
						<columns/>
					</table>
					<table allColumns="false" name="address" elemId="160806">
						<columns>
							<column name="id" elemId="160807"/>
							<column name="eng_active" elemId="160808"/>
							<column name="eng_last_update_date" elemId="160809"/>
							<column name="eng_creation_date" elemId="160810"/>
							<column name="eng_deletion_date" elemId="160811"/>
							<column name="eng_activation_date" elemId="160812"/>
							<column name="eng_deactivation_date" elemId="160813"/>
							<column name="eng_change_type" elemId="160814"/>
							<column name="eng_activity_change_type" elemId="160815"/>
							<column name="party_id" elemId="160816"/>
							<column name="cmo_type" elemId="160817"/>
							<column name="cmo_street" elemId="160818"/>
							<column name="cmo_city" elemId="160819"/>
							<column name="cmo_state" elemId="160820"/>
							<column name="cmo_zip" elemId="160821"/>
						</columns>
					</table>
				</selectedTables>
			</masterDataSource>
			<instanceDataSource scope="use scope of parent export operation" allEntities="false" sourceSystem="" prefix="instF" elemId="161624" mode="full">
				<selectedTables>
					<instanceTable allColumns="true" name="party" elemId="161625">
						<columns/>
					</instanceTable>
					<instanceTable allColumns="false" name="address" elemId="161626">
						<columns>
							<column name="id" elemId="161627"/>
							<column name="eng_source_timestamp" elemId="161628"/>
							<column name="eng_active" elemId="161629"/>
							<column name="eng_origin" elemId="161630"/>
							<column name="eng_source_system" elemId="161631"/>
							<column name="eng_last_update_date" elemId="161632"/>
							<column name="eng_last_source_update_date" elemId="161633"/>
							<column name="eng_creation_date" elemId="161634"/>
							<column name="eng_deletion_date" elemId="161635"/>
							<column name="eng_activation_date" elemId="161636"/>
							<column name="eng_deactivation_date" elemId="161637"/>
							<column name="master_id" elemId="161638"/>
							<column name="source_id" elemId="161639"/>
							<column name="party_source_id" elemId="161640"/>
							<column name="src_type" elemId="161641"/>
							<column name="std_type" elemId="161642"/>
							<column name="exp_type" elemId="161643"/>
							<column name="sco_type" elemId="161644"/>
							<column name="dic_type" elemId="161645"/>
							<column name="src_street" elemId="161646"/>
							<column name="cio_street" elemId="161647"/>
							<column name="src_city" elemId="161648"/>
							<column name="cio_city" elemId="161649"/>
							<column name="src_state" elemId="161650"/>
							<column name="cio_state" elemId="161651"/>
							<column name="src_zip" elemId="161652"/>
							<column name="cio_zip" elemId="161653"/>
							<column name="exp_address" elemId="161654"/>
							<column name="sco_address" elemId="161655"/>
							<column name="cio_address_comp" elemId="161657"/>
							<column name="tmp_validity_level" elemId="161659"/>
							<column name="tmp_address_validity" elemId="161660"/>
							<column name="uni_rule_name" elemId="161662"/>
							<column name="party_master_id" elemId="161664"/>
						</columns>
					</instanceTable>
				</selectedTables>
			</instanceDataSource>
			<conditionalInstanceDataSource scope="use scope of parent export operation" sourceSystem="" allColumns="true" prefix="cond_full" elemId="23663802" mode="full" entityName="party">
				<conditions>
					<condition value="P" elemId="23670677" column="cio_type" operator="=">
						<description></description>
					</condition>
				</conditions>
				<columns/>
			</conditionalInstanceDataSource>
			<conditionalMasterDataSource scope="use scope of parent export operation" allColumns="true" prefix="cond_delta_mas" elemId="23666464" layerName="masters" mode="delta" entityName="party">
				<conditions>
					<condition value="P" elemId="23671060" column="cmo_type" operator="=">
						<description></description>
					</condition>
				</conditions>
				<columns/>
			</conditionalMasterDataSource>
		</dataSources>
		<advanced enableTID="false">
			<pathVariables/>
			<additionalParameters/>
		</advanced>
	</complexExport>
	<fullMasterExport scope="use global scope (from Preferences)" allEntities="false" name="full_master_export" elemId="367374" layerName="masters">
		<description></description>
		<selectedTables>
			<table allColumns="true" name="party" elemId="367378">
				<columns/>
			</table>
			<table allColumns="true" name="address" elemId="367379">
				<columns/>
			</table>
			<table allColumns="false" name="contact" elemId="367380">
				<columns>
					<column name="id" elemId="10715"/>
					<column name="party_id" elemId="10716"/>
				</columns>
			</table>
		</selectedTables>
		<advanced enableTID="false">
			<pathVariables/>
			<additionalParameters/>
		</advanced>
	</fullMasterExport>
	<fullInstanceExport scope="use global scope (from Preferences)" allEntities="false" sourceSystem="" name="full_instance_export" elemId="35808">
		<description></description>
		<selectedTables>
			<instanceTable allColumns="true" name="party" elemId="35809">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="address" elemId="35810">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="contact" elemId="35811">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="rel_party2party" elemId="35812">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="rel_party2contract" elemId="35813">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="contract" elemId="35814">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="id_document" elemId="35815">
				<columns/>
			</instanceTable>
			<instanceTable allColumns="true" name="product" elemId="35816">
				<columns/>
			</instanceTable>
		</selectedTables>
		<advanced enableTID="false">
			<pathVariables/>
			<additionalParameters/>
		</advanced>
	</fullInstanceExport>
	<complexExport scope="use global scope (from Preferences)" name="history_export" elemId="34744">
		<description></description>
		<dataSources>
			<historyInstanceEntityDataSource sourceSystem="" allColumns="true" prefix="instHistP" entity="party" elemId="34745">
				<historyInstanceColumns/>
			</historyInstanceEntityDataSource>
			<historyInstanceEntityDataSource sourceSystem="life" allColumns="true" prefix="instHist" entity="contract" elemId="40617">
				<historyInstanceColumns/>
			</historyInstanceEntityDataSource>
			<historyMasterEntityDataSource allColumns="true" prefix="masHist" entity="party (masters)" elemId="156182">
				<historyMasterColumns/>
			</historyMasterEntityDataSource>
			<historyMasterEntityDataSource allColumns="false" prefix="masNormHist" entity="address (norm)" elemId="35558">
				<historyMasterColumns>
					<historyMasterColumn name="eng_valid_from" elemId="157326"/>
					<historyMasterColumn name="eng_valid_to" elemId="157327"/>
					<historyMasterColumn name="id" elemId="157328"/>
					<historyMasterColumn name="eng_active" elemId="157329"/>
					<historyMasterColumn name="cmo_type" elemId="157332"/>
					<historyMasterColumn name="cmo_street" elemId="157711"/>
				</historyMasterColumns>
			</historyMasterEntityDataSource>
			<historyMasterEntityDataSource allColumns="true" prefix="mastHist" entity="contact (masters)" elemId="42594">
				<historyMasterColumns/>
			</historyMasterEntityDataSource>
		</dataSources>
		<advanced enableTID="false">
			<pathVariables/>
			<additionalParameters/>
		</advanced>
	</complexExport>
</exportModel>