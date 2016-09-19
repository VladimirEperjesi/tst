<?xml version='1.0' encoding='UTF-8'?>
<eventHandler>
	<handlers>
		<handler desc="Capture Data Changes" persistenceDir="../storage/eventHandler" name="" enable="true" elemId="26373348" class="EventHandlerAsync">
			<publishers>
				<stdOutPublisher enable="true" elemId="26380561">
					<description>Standard Output Publisher - simple event publisher useful for demonstration purposes</description>
					<transformers>
						<simpleXmlTransformer includeOldValues="true" indent="true" name="Simple transformation of data change events into XML format" elemId="26380562"/>
					</transformers>
					<advanced>
						<filteringPublisher filter="false">
							<expression></expression>
							<filteredEntities>
								<entity name="party (instance)" elemId="26385822">
									<expression>new.src_first_name != old.src_first_name</expression>
								</entity>
							</filteredEntities>
						</filteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</advanced>
				</stdOutPublisher>
				<eventPlanPublisher enable="false" elemId="12459" layerName="masters" suffix="">
					<description>Sample of Generic Plan Publisher - Party Masters</description>
					<planAdvancedSettings>
						<planFilteringPublisher filter="false">
							<expression></expression>
						</planFilteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</planAdvancedSettings>
					<entityName allColumns="false" entity="party"/>
					<columnsMeta>
						<columnMeta name="meta_id" elemId="13009"/>
						<columnMeta name="meta_event_type" elemId="13010"/>
						<columnMeta name="meta_entity" elemId="13011"/>
						<columnMeta name="meta_layer" elemId="13012"/>
						<columnMeta name="meta_master_view" elemId="13013"/>
						<columnMeta name="meta_origin" elemId="13014"/>
						<columnMeta name="meta_source_system" elemId="13015"/>
						<columnMeta name="meta_activation_date" elemId="13016"/>
						<columnMeta name="meta_creation_date" elemId="13017"/>
						<columnMeta name="meta_deactivation_date" elemId="13018"/>
						<columnMeta name="meta_deletion_date" elemId="13019"/>
						<columnMeta name="meta_last_update_date" elemId="13020"/>
						<columnMeta name="meta_last_source_update_date" elemId="13021"/>
						<columnMeta name="meta_activation_tid" elemId="13022"/>
						<columnMeta name="meta_creation_tid" elemId="13023"/>
						<columnMeta name="meta_deactivation_tid" elemId="13024"/>
						<columnMeta name="meta_deletion_tid" elemId="13025"/>
						<columnMeta name="meta_last_update_tid" elemId="13026"/>
						<columnMeta name="meta_last_source_update_tid" elemId="13027"/>
					</columnsMeta>
					<columns>
						<column old="true" new="true" name="eng_active" elemId="12990"/>
						<column old="true" new="true" name="eng_last_update_date" elemId="12991"/>
						<column old="true" new="true" name="eng_creation_date" elemId="12992"/>
						<column old="true" new="true" name="eng_deletion_date" elemId="12993"/>
						<column old="true" new="true" name="eng_activation_date" elemId="12994"/>
						<column old="true" new="true" name="eng_deactivation_date" elemId="12995"/>
						<column old="true" new="true" name="cmo_type" elemId="12996"/>
						<column old="true" new="true" name="cmo_first_name" elemId="12997"/>
						<column old="true" new="true" name="cmo_last_name" elemId="12998"/>
						<column old="true" new="true" name="cmo_gender" elemId="12999"/>
						<column old="true" new="true" name="cmo_birth_date" elemId="13000"/>
						<column old="true" new="true" name="cmo_sin" elemId="13001"/>
						<column old="true" new="true" name="cmo_company_name" elemId="13002"/>
						<column old="true" new="true" name="cmo_business_number" elemId="13003"/>
						<column old="true" new="true" name="cmo_established_date" elemId="13004"/>
						<column old="true" new="true" name="cmo_legal_form" elemId="13005"/>
						<column old="true" new="true" name="dq_indicator" elemId="13007"/>
						<column old="true" new="true" name="dq_indicator_name" elemId="13008"/>
					</columns>
				</eventPlanPublisher>
				<eventPlanPublisher enable="false" elemId="158703" layerName="instance" suffix="">
					<description>Sample of Generic Plan Publisher - Party Instance</description>
					<planAdvancedSettings>
						<planFilteringPublisher filter="false">
							<expression></expression>
						</planFilteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</planAdvancedSettings>
					<entityName allColumns="true" entity="party"/>
					<columnsMeta/>
					<columns/>
				</eventPlanPublisher>
				<jmsPublisher enable="false" elemId="26380846" contentType="text/plain" connectionName="esbEvents" destination="dynamicQueues/esb.event.queue">
					<description>Sample of JMS publisher configuration.
To run this publisher, JMS server component must be configured in the MDC server config!</description>
					<transformers>
						<expressionTemplateTransformer name="Sample tamplate for Party Instance" elemId="26380847" entityName="party (instance)">
							<template>Instance party src_company_name changed from ${toString(old.src_company_name)} to ${toString(new.src_company_name)}. ID: ${toString(meta.id)} Change type: ${meta.event_type}</template>
						</expressionTemplateTransformer>
						<expressionTemplateTransformer name="Sample tamplate for Party Master" elemId="26380848" entityName="party (masters)">
							<template>Attribute cmo_company_name changed from  ${old.cmo_company_name} to  ${new.cmo_company_name}. ID: ${toString(meta.id)} Change type: ${meta.event_type}</template>
						</expressionTemplateTransformer>
					</transformers>
					<headers/>
					<advanced>
						<filteringPublisher filter="true">
							<expression></expression>
							<filteredEntities>
								<entity name="party (instance)" elemId="23706237">
									<expression>new.src_company_name is not null</expression>
								</entity>
								<entity name="party (masters)" elemId="23707268">
									<expression>new.cmo_company_name is not null</expression>
								</entity>
							</filteredEntities>
						</filteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</advanced>
				</jmsPublisher>
				<httpSoapPublisher urlResourceName="soapPublisher" soapAction="SOAP_ACTION" encoding="UTF-8" enable="false" elemId="26381426" soapVersion="SOAP_1_1" delay="0" timeout="5000">
					<description>Sample of SOAP publisher configuration</description>
					<advanced>
						<filteringPublisher filter="false">
							<expression></expression>
							<filteredEntities/>
						</filteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</advanced>
					<transformers>
						<expressionTemplateTransformer name="XML output" elemId="26381427" entityName="party (instance)">
							<template>&lt;![CDATA[&lt;soapenv:Envelope xmlns:soapenv=&quot;http://schemas.xmlsoap.org/soap/envelope/&quot; xmlns:sam=&quot;http://www.example.org/sample/&quot;&gt;
&lt;soapenv:Header/&gt;
&lt;soapenv:Body&gt;
	&lt;sam:test&gt;
		&lt;text&gt;XML content&lt;/text&gt;
	&lt;/sam:test&gt;
&lt;/soapenv:Body&gt;
&lt;/soapenv:Envelope&gt; ]]&gt;</template>
						</expressionTemplateTransformer>
					</transformers>
				</httpSoapPublisher>
				<eventSqlPublisher dataSource="esb_db" enable="false" elemId="26381711">
					<description>Sample of SQL publisher configuration</description>
					<sqlTemplates>
						<template name="party (instance)" elemId="26381713">
							<template>insert into PARTY (SOURCE_ID, N_SRC_COMP_NAME, O_SRC_COMP_NAME) values (${new.source_id}, ${new.src_company_name}, ${old.src_company_name})</template>
						</template>
						<template name="party (masters)" elemId="26381712">
							<template>insert into PARTY_MAS (N_CMO_COMP_NAME, O_CMO_COMP_NAME) values (${new.cmo_company_name}, ${old.cmo_company_name})</template>
						</template>
					</sqlTemplates>
					<advanced>
						<filteringPublisher filter="true">
							<expression></expression>
							<filteredEntities>
								<entity name="party (instance)" elemId="23689318">
									<expression>new.cio_type = &#39;C&#39; and new.src_company_name is not null</expression>
								</entity>
								<entity name="party (masters)" elemId="23691255">
									<expression>new.cmo_type = &#39;C&#39; and new.cmo_company_name is not null</expression>
								</entity>
							</filteredEntities>
						</filteringPublisher>
						<retryingPublisher maxRetries="30" consecutiveSuccess="10" retryDelay="20" retry="false" globalRetries="5"/>
					</advanced>
				</eventSqlPublisher>
			</publishers>
			<filter>
				<expression>meta.event_type = &#39;INSERT&#39; or meta.event_type = &#39;UPDATE&#39;</expression>
				<entities>
					<entity name="party (instance)" elemId="23699621">
						<expression></expression>
					</entity>
					<entity name="party (masters)" elemId="1906">
						<expression>meta.event_type = &#39;INSERT&#39; and meta.master_view = &#39;masters&#39;</expression>
					</entity>
					<entity name="contact (masters)" elemId="26379710">
						<expression>meta.event_type = &#39;UPDATE&#39;</expression>
					</entity>
				</entities>
			</filter>
		</handler>
	</handlers>
</eventHandler>