	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>

<%@ page import = "java.util.*" %>
<%@ page import = "com.salesmanager.core.util.*" %>
<%@ page import = "com.salesmanager.core.constants.*" %>
<%@ page import = "com.salesmanager.central.tax.*"%>

<html>

<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.tax.taxbasis.setup" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>
</head>


<body id="taxbasis">

<div id="page">

	    <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">




			<s:fielderror template="smfielderror" />

			<%=MessageUtil.displayMessages(request)%>
			<p>
                		<fieldset>
                		<legend>
                			<s:text name="label.tax.taxbasis.setup" />
                        </legend>






<form id="configuretax" name="taxoptions" action="<%=request.getContextPath() %>/tax/edittaxbasis.action" method="post">
<table width="90%" border="0">
<tr>
<td>
<%

String taxbasis = (String)request.getAttribute("taxbasis");
if(taxbasis==null) {
	taxbasis=TaxConstants.STORE_TAX_BASIS;
}
String schemeid = (String)request.getAttribute("scheme");
if(schemeid==null) {
	schemeid = "0";
}


LabelUtil label = LabelUtil.getInstance();
String taxupper = label.getText("label.tax.taxbasis.salestax");
String taxlower = label.getText("label.tax.taxbasis.salestaxlower");
if(schemeid.equals("3")) {
	taxupper = label.getText("label.tax.taxbasis.vat");
	taxlower = taxupper;
}
%>


<b><%=taxupper%></b>&nbsp;<%=label.getText("label.tax.taxbasis.description") %>
<!--
<br>
<%=label.getText("label.tax.taxbasis.description2") %>&nbsp;<%=taxlower %>&nbsp;
<%=label.getText("label.tax.taxbasis.description3") %>
<br>

<%=label.getText("label.tax.taxbasis.description4") %>&nbsp;<%=taxlower %>&nbsp;
<%=label.getText("label.tax.taxbasis.description5") %>
<br>

<%=label.getText("label.tax.taxbasis.description6") %>&nbsp;<%=taxlower %>&nbsp;
<%=label.getText("label.tax.taxbasis.description7") %>
<br>
-->
</td>
</tr>

<tr>
<td>
<table border="0">
<!--
<tr>
<td><%=label.getText("label.tax.taxbasis.store")%></td><td><input type="radio" name="taxbasis" value="<%=TaxConstants.STORE_TAX_BASIS %>" <%if(taxbasis.equals(TaxConstants.STORE_TAX_BASIS)) {%>CHECKED<%} %>></td>
</tr>
-->
<tr>
<td><%=label.getText("label.generic.shipping")%></td>
<td><input type="radio" name="taxbasis" value="<%=TaxConstants.SHIPPING_TAX_BASIS %>" <%if(taxbasis.equals(TaxConstants.SHIPPING_TAX_BASIS)) {%>CHECKED<%} %>></td>
</tr>

<tr>
<td><%=label.getText("label.generic.billing")%></td>
<td><input type="radio" name="taxbasis" value="<%=TaxConstants.BILLING_TAX_BASIS %>" <%if(taxbasis.equals(TaxConstants.BILLING_TAX_BASIS)) {%>CHECKED<%} %>></td>
</tr>

</table>
<input type="hidden" name="SCHEMEID" value="<%=request.getAttribute("SCHEMEID")%>">


</td></tr>
<tr><td>
<div align="right">
<input type="submit" id="updatetaxbasis" value="<s:text name="button.tax.label.setbasis" />"/>
</div>

</td></tr>








</table>
</form>




</fieldset>
</div>
<s:include value="taxleftmenu.jsp"/>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>

