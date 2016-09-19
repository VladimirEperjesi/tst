<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="fn">
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

<h1>GUI documentation content</h1>
<h2>Top Level Entities</h2>
<p>Following tables enlist top level entities and their views</p>
<p>
<xsl:for-each select="entities/entity[@topLevel='true']">
<br/>
<h2>Top Level Entity: <xsl:value-of select="@label"/></h2>
<table width="100%">
<tr>
	<th>Label</th>
	<th>Name</th>
	<th>Description</th>
</tr>


<tr>
	<td class="lowerCase"><a href="gui_documentation/tables/{@label}.html"><xsl:value-of select="@label"/></a></td>
	<td><xsl:value-of select="@name"/></td>
	<td><xsl:value-of select="@desc|desc"/></td>
</tr>


</table> 

<p>This top level entity has defined following views:</p>

<table width="100%">
<tr>
	<th>View type</th>
	<th>Description</th>
</tr>

<xsl:for-each select="*">
<tr>
	<td class="lowerCase"><a href="gui_documentation/views/{local-name(.)}.html"><xsl:value-of select="local-name(.)"/></a></td>
	<td><xsl:value-of select="./@desc|desc"/></td>
</tr>
</xsl:for-each>

</table> 

</xsl:for-each>
</p>
<br/>
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
