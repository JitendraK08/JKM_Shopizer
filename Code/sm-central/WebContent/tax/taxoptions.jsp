	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
    <%@ page import="com.salesmanager.central.tax.*" %>
    <%@ page import="com.salesmanager.core.constants.*" %>
    <%@ page import="com.salesmanager.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.taxoptions.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>

</head>



<body id="choosetaxoption">


<div id="page">

	    <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">




			<s:fielderror template="smfielderror" />

			<%=MessageUtil.displayMessages(request)%>
			<p>
                		<fieldset>
                		<legend>
                			<s:text name="label.tax.options" />
                        </legend>



<form name="taxoptions" action="<%=request.getContextPath() %>/tax/configuretax.action" method="post">
<table>
<tr>
<td width=70% valign="top">
<%

Integer schemeid = (Integer)request.getAttribute("SCHEMEID");


%>

</td>
</tr>
</table>

<table>
<tr>
<td><s:text name="label.tax.options.custom" /></td><td><input type="radio" name="configurationScheme" value="<%=TaxConstants.NO_SCHEME %>" <%if(schemeid==TaxConstants.NO_SCHEME) {%>CHECKED<%} %>></td>
</tr>

<tr>
<td><s:text name="label.tax.options.us" /></td><td><input type="radio" name="configurationScheme" value="<%=TaxConstants.US_SCHEME %>" <%if(schemeid==TaxConstants.US_SCHEME) {%>CHECKED<%} %>></td>
</tr>

<tr>
<td><s:text name="label.tax.options.ca" /></td><td><input type="radio" name="configurationScheme" value="<%=TaxConstants.CA_SCHEME %>" <%if(schemeid==TaxConstants.CA_SCHEME) {%>CHECKED<%} %>></td>
</tr>

<tr>
<td><s:text name="label.tax.options.eu" /></td><td><input type="radio" name="configurationScheme" value="<%=TaxConstants.EU_SCHEME %>" <%if(schemeid==TaxConstants.EU_SCHEME) {%>CHECKED<%} %>></td>
</tr>

<tr>
<td></td><td><input type="submit" id="updatetaxoptions" value="<s:text name="label.tax.options.configure" />"/></td>
</tr>
</table>
</form>


</fieldset>
</div>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>