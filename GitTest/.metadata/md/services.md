<?xml version='1.0' encoding='UTF-8'?>
<nativeServices>
	<basicServices getModel="false" listInstance="false" searchInstance="true" searchMaster="true" getMaster="true" processDelta="true" getInstance="true" rwControl="true" listMaster="false" genTraversal="true" batchControl="true" modelStat="false" processMatch="true"/>
	<configurableServices>
		<identify desc="" name="identifyParty" masterLayer="masters" entity="party" enable="true" elemId="255724"/>
		<processUpsert system="mda" desc="" entity="party" enable="true" elemId="269063"/>
		<processUpsert system="mda" desc="" entity="address" enable="true" elemId="279164"/>
		<processDeltaAdv desc="Complex example of processDelta service where both Partial Mode and Delta Dependecy Mode is configured" name="example" enable="false" elemId="71826">
			<partialTables>
				<partialTable name="contact" elemId="20185">
					<partialColumns>
						<partialColumn name="src_type" elemId="49226"/>
						<partialColumn name="src_value" elemId="49227"/>
					</partialColumns>
				</partialTable>
			</partialTables>
			<dependencySettings deletionStrategy="use global setting (from Preferences)">
				<tableSettings>
					<table keyColumn="source_id" name="party" elemId="40866" mode="central">
						<partialColumns/>
					</table>
					<table keyColumn="party_source_id" name="address" elemId="40867" mode="party">
						<partialColumns>
							<partialColumn name="src_city" elemId="44312"/>
						</partialColumns>
					</table>
					<table keyColumn="" name="id_document" elemId="80359" mode="autonomous">
						<partialColumns>
							<partialColumn name="src_type" elemId="80360"/>
						</partialColumns>
					</table>
				</tableSettings>
			</dependencySettings>
		</processDeltaAdv>
	</configurableServices>
	<endpointsDefinition>
		<httpEndpoint pathPrefix="soapOverHttp" listenerNames="all" enable="true" elemId="271980" format="SOAP"/>
		<httpEndpoint pathPrefix="xmlRpcOverHttp" listenerNames="all" enable="true" elemId="271981" format="XML RPC"/>
		<jmsEndpoint pathPrefix="soapOverJms" activityByReadWriteMode="false" listenerNames="all" enable="false" elemId="271982" inputDestination="in_queue" format="SOAP" connectionName="jms" outputDestination="out_queue">
			<outputParameters/>
		</jmsEndpoint>
	</endpointsDefinition>
</nativeServices>