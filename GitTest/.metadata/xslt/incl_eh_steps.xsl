<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:mrg="http://www.ataccama.com/dqc/plan-merge"
	xmlns:comm="http://www.ataccama.com/purity/comment"
	exclude-result-prefixes="sf fn mrg comm">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:template name="eh_steps">
	 	<step id="eh_subtasks" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
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
	        <visual-constraints bounds="5,72,-1,-1" layout="vertical"/>
	    </step> 
	    
		<step id="eh_tasks" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL">
	        <properties>
	            <columns>
	                <columnDef name="id" type="LONG"/>
	                <columnDef name="task_id" type="LONG"/>
					<columnDef name="type_id" type="STRING"/>
	                <columnDef name="name" type="STRING"/>
	                <columnDef name="started" type="DATETIME"/>
	                <columnDef name="finished" type="DATETIME"/>
	                <columnDef name="duration" type="LONG"/>
	            </columns>
	            <shadowColumns/>
	            <comm:comment>
	            	<xsl:call-template name="generated_step"/>
	            </comm:comment>
	        </properties>
	        <visual-constraints bounds="5,120,-1,-1" layout="vertical"/>
	    </step>	
	</xsl:template>

</xsl:stylesheet>
