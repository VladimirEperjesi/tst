<?xml version='1.0' encoding='UTF-8'?>
<metadata xmlns:ame="http://www.ataccama.com/ame/md">
	<settings ame:include="md/settings.md"/>
	<systems>
		<system ame:include="md/connected_systems/system_ERP.md"/>
	</systems>
	<logicalModel>
		<instanceModel ame:include="md/logical_model/instance_model.md"/>
		<masterModels/>
		<dictionary ame:include="md/logical_model/reference_data_model.md"/>
	</logicalModel>
	<outputOperations>
		<exportModel ame:include="md/output_interfaces/export_operations.md"/>
		<eventHandler ame:include="md/output_interfaces/event_handler.md"/>
	</outputOperations>
	<nativeServices ame:include="md/services.md"/>
	<preview/>
	<documentationRoot calculateDoc="false"/>
	<advancedSettings>
		<manualMatch ame:include="md/advanced_settings/manualMatch.md"/>
		<taskInfoExport ame:include="md/advanced_settings/taskInfoExport.md"/>
		<reprocessSettings ame:include="md/advanced_settings/reprocessSettings.md"/>
		<historyPlugin ame:include="md/advanced_settings/historyPlugin.md"/>
		<migration ame:include="md/advanced_settings/migration.md"/>
	</advancedSettings>
</metadata>