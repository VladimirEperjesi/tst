<?xml version='1.0' encoding='UTF-8'?>
<dictionary>
	<tables>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="gender" loadInst="false" elemId="332820" label="" loadMas="true">
			<description>Maps all different gender values from various Connected Systems and translates them to one mastered value</description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="party_type" loadInst="true" elemId="332948" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:digit:][:letter:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="currency" loadInst="false" elemId="109103" label="" loadMas="true">
			<description></description>
			<columns>
				<column name="country_name" elemId="26386749" label="Country Name" type="string" instance="false" master="true" size="200">
					<comment></comment>
				</column>
			</columns>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:letter:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="contract_type" loadInst="false" elemId="109531" label="" loadMas="true">
			<description></description>
			<columns>
				<column name="description_EN" elemId="15682" label="" type="string" instance="false" master="true" size="1024">
					<comment></comment>
				</column>
			</columns>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="sale_point" loadInst="false" elemId="109683" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="rel_pty2ctr_type" loadInst="false" elemId="109848" label="" loadMas="true">
			<description>Dictionary value check for different relationship types between Party and Contract entities</description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="rel_pty2pty_type" loadInst="false" elemId="110021" label="" loadMas="true">
			<description>Dictionary value check for different relationship types between two Party entities</description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="none" sourceCodeType="string" masterCodeType="string" usageValidation="cleansing" name="rel_pty2pty_ctg" loadInst="false" elemId="11437770" label="" loadMas="true">
			<description>Dictionary value check for different relationship categories between two Party entities. One category groups various relationship types</description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="integer" usageValidation="none" name="address_type" loadInst="false" elemId="110588" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="contact_type" loadInst="false" elemId="110793" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="legal_form" loadInst="false" elemId="105855" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="id_document_type" loadInst="false" elemId="26374568" label="" loadMas="true">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
		<table instUse="cleansing" sourceCodeType="string" masterCodeType="string" usageValidation="none" name="product_type" loadInst="false" elemId="12252" label="" loadMas="false">
			<description></description>
			<columns/>
			<lookupSettings substituteWith="" removeRepeatedChars="false" duplicities="ACCEPT" supportedChars="[:all:]" squeezeWS="true" bestDistanceIndex="false" upperCase="true" removeAccents="true" bidirectApproxIndex="false" approxIndex="false"/>
		</table>
	</tables>
</dictionary>