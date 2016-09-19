<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn comm">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:param name="taskInfo" select="document('param:taskInfo')/*"/>

<xsl:include href="incl_constants.xsl"/>
<xsl:include href="_constants.xsl"/>
<xsl:include href="incl_plan_comments.xsl"/>
<xsl:include href="incl_eh_steps.xsl"/>

<!--bound to /advancedSettings/taskInfoExport/plan  -->
<xsl:template match="/*">
	<purity-config xmlns:comm="http://www.ataccama.com/purity/comment" version="{$version}">
		<references/>
    <component-mappings>
        <propertyMappings/>
    </component-mappings>

<!-- (subtasks export) -->
	<step id="subtasks" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>
                <columnDef name="task_id" type="LONG"/>
                <columnDef name="name" type="STRING"/>
                <columnDef name="started" type="DATETIME"/>
                <columnDef name="finished" type="DATETIME"/>
                <columnDef name="duration" type="LONG"/>
                <columnDef name="detail" type="STRING"/>
                <columnDef name="volume" type="LONG"/>
                <columnDef name="parents" type="STRING"/>
            </columns>
            <shadowColumns/>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints bounds="300,72,-1,-1" layout="vertical"/>
    </step>

<!-- (tasks export) -->
	<step id="tasks" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
        <properties>
            <columns>
                <columnDef name="id" type="LONG"/>
				<columnDef name="type_id" type="STRING"/>
                <columnDef name="name" type="STRING"/>
                <columnDef name="result" type="STRING"/>
                <columnDef name="enqueued" type="DATETIME"/>
                <columnDef name="started" type="DATETIME"/>
                <columnDef name="finished" type="DATETIME"/>
                <columnDef name="duration" type="LONG"/>
            </columns>
            <shadowColumns/>
            <comm:comment>
            	<xsl:call-template name="generated_step"/>
            </comm:comment>
        </properties>
        <visual-constraints bounds="90,72,-1,-1" layout="vertical"/>
    </step>
    
    <!-- enable export eh status  -->
    <xsl:if test="$taskInfo/@ehStatus='true'">
    	<xsl:call-template name="eh_steps"/>      
    </xsl:if>
        
	</purity-config>	
</xsl:template>
</xsl:stylesheet>