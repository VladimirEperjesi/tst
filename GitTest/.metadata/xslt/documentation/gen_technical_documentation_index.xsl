<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/*">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<style type="text/css">
@media print {
h1{page-break-before:always;}}

<!-- classes -->
.footNote {
	font-size: 11px;
	}  
.tableVerticalHeader {
	text-align:left;
	}
.tableVerticalHeader {
	text-align:left;
	}
.border{
	border-bottom:1px solid #D9D9D9;
	}
.lowerCase {
	text-transform:lowercase;
	}

	
body {
    counter-reset: section_h1;
	}	
p   {font:13px Candara,Calibri,Seoge,Optima,Arial,sans-serif;
		}
h1  {font:100% Candara,Calibri,Seoge,Optima,Arial,sans-serif;
		font-weight:bold;
		font-size: 16px;
		margin-bottom:13px;
		padding-left:9px;
		background-color:#595959;
		color:white;
		text-transform:uppercase;
		counter-increment: section_h1;	
		counter-reset: sub-section_h2;
		page-break-after: avoid;
	}
h1:before {
        content: counter(section_h1) " ";
  }
h2	{font:100% Candara,Calibri,Seoge,Optima,Arial,sans-serif;
		font-weight:bold;
		font-size: 15px;
		margin-bottom:10px;
		text-transform:uppercase;
		border-bottom:1px solid #D9D9D9;
		counter-increment: sub-section_h2;
		counter-reset: sub-section_h3;
	}
h2:before {
        content: counter(section_h1) "." counter(sub-section_h2) " ";
  }
h3	{font:100% Candara,Calibri,Seoge,Optima,Arial,sans-serif;
		font-weight:bold;
		font-size: 14px;
		margin-bottom:10px;
		background-color:#F2F2F2;
		counter-increment: sub-section_h3;
		counter-reset: sub-section_h4;
	}
h3:before {
        content: counter(section_h1) "." counter(sub-section_h2) "." counter(sub-section_h3) " ";
  }	
h4  {font:100% Candara,Calibri,Seoge,Optima,Arial,sans-serif;
		font-weight:bold;
		font-size: 13px;
		margin-bottom:10px;
		counter-increment: sub-section_h4;
	}
h4:before {
        content: counter(section_h1) "." counter(sub-section_h2) "." counter(sub-section_h3) "." counter(sub-section_h4) " ";
  }
table {
		width:635px;

	}
table,tr,td {
		font-size:12px;
		border-width:1px;
		border-style:solid;
		border-color:#BFBFBF;
		padding:2px 5px 2px 5px;
		margin:0;
		border-collapse:collapse;
		text-decoration:none;
		background-color:transparent
	}
th	{font-size:12px;
		
		border-width:1px;
		border-style:solid;
		border-color:#BFBFBF;
		padding:2px 5px 2px 5px;
		margin:0;
		border-collapse:collapse;
		text-decoration:none;
		background-color:#D9D9D9;
	}
ul {
	font-size:12px;
	}
</style>
</head>




<body>



<!-- logo -->
<img src="img/logo.png" alt="logo" align="right"/> 
<br/>
<br/>
<p class="border"></p>

<!-- documentation EN -->

<!-- <h1>Technical documentation content</h1> -->
<h1>Technical documentation</h1>
<h2>Connected Systems</h2>
<p>Following table enlists all used Connected Systems</p>
<p>

<table width="100%">
<tr>
	<th>Name</th>
	<th>Description</th>
</tr>

<xsl:for-each select="sourceSystems/sourceSystem">
<tr>
	<!-- <td class="lowerCase"><a href="technical_documentation/sourceSystems/{@name}.html"><xsl:value-of select="@name"/></a></td> -->
	<td class="lowerCase"><xsl:value-of select="@name"/></td>
	<td><xsl:value-of select="@desc|desc"/></td>
</tr>
</xsl:for-each>

</table> 

</p>
<br/>
<h3>Load Operations</h3>
<p>Following table enlists all load operation configured per each Connected System</p>
<p>

<table width="100%">
<tr>
	<th>Name</th>
	<th>Description</th>
	<th>Connected System</th>
</tr>

<xsl:for-each select="sourceSystems/sourceSystem">
	<xsl:variable name="system" select="@name"/>
	<xsl:for-each select="plans/plan">
<tr>
	<!-- <td class="lowerCase"><a href="technical_documentation/sourceSystems/{@name}.html"><xsl:value-of select="@name"/></a></td> -->
	
	<td><xsl:value-of select="@name"/></td>
	<td><xsl:value-of select="@desc|desc"/></td>
	<td class="lowerCase"><xsl:value-of select="//sourceSystems/sourceSystem[@name=$system]/@name"/></td>
</tr>
	</xsl:for-each>
</xsl:for-each>

</table> 

</p>
<br/>
<h2>Export Operations</h2>
<p>Following table enlists all export operations</p>
<p>

<table width="100%">
<tr>
	<th>Name</th>
	<th>Description</th>
</tr>

<xsl:for-each select="exportOperations/exportOperation">
<tr>
	<!-- <td class="lowerCase"><a href="technical_documentation/exportOperations/{@name}.html"><xsl:value-of select="@name"/></a></td> -->
	<td class="lowerCase"><xsl:value-of select="@name"/></td>
	<td><xsl:value-of select="@desc|desc"/></td>
</tr>
</xsl:for-each>

</table> 

</p>
<br/>

<h2>Event Handler</h2>
<p>Following table enlists Event Handler settings:</p>
<p>

<table width="100%">
<tr>
	<th>Name</th>
	<th>Description</th>
	<th>Publishers</th>
</tr>

<xsl:for-each select="eventHandlers/eventHandler">
<tr>
	<!-- <td><a href="technical_documentation/eventHandler/{@name}.html"><xsl:value-of select="@name"/></a></td> -->
	<td><xsl:value-of select="@name"/></td>
	<td><xsl:value-of select="@desc|desc"/></td>
	
	<td>
		
			<xsl:for-each select="publishers/publisher">
				
				<xsl:value-of select="@name"/><xsl:text>: </xsl:text><xsl:value-of select="@desc|desc"/>
				<br/>
			</xsl:for-each>
			
	</td>
</tr>
</xsl:for-each>

</table> 

</p>
<br/>

<h2>Other settings</h2>
<p>Following table enlists other settings:</p>
<p>
<h3>Reprocess Settings</h3>
<table width="100%">
<tr>
	<th>Name</th>
	<th>Type</th>
	<th>Description</th>
</tr>

<xsl:for-each select="other/reprocess/plan">
<tr>
	<!--  <td class="lowerCase"><a href="technical_documentation/sourceSystems/{@name}.html"><xsl:value-of select="@name"/></a></td> -->
	<td class="lowerCase"><xsl:value-of select="@name"/></td>
	<td class="lowerCase"><xsl:value-of select="@type"/><xsl:text> reprocess</xsl:text></td>
	<td><xsl:value-of select="@desc|desc"/></td>
</tr>
</xsl:for-each>

</table> 

</p>
<xsl:if test="other/@taskInfo='true'">
<p>
<h3>Execution Status Export</h3>
<p>
<p>Execution status export is configured as <i><xsl:value-of select="other/@taskInfoPlan"/></i> export operation.</p>
</p>
</p>
</xsl:if>
<br/>
</body>


</html>
</xsl:template>

<xsl:template match="owner" mode="ownerName">
				<a href="mailto:{@email}">
					<xsl:choose>
						<xsl:when test="@lastName!=''"><xsl:value-of select="@firstName"/><xsl:text> </xsl:text><xsl:value-of select="@lastName"/></xsl:when>
						<xsl:when test="@fullName!=''"><xsl:value-of select="@fullName"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
					</xsl:choose>
				</a>
</xsl:template>
</xsl:stylesheet>
