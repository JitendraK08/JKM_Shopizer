	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
    <%@ page import="com.salesmanager.core.entity.system.CentralFunction" %>
    <%@ page import="com.salesmanager.central.web.*" %>
    <%@ page import="com.salesmanager.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.system.name" /> - <s:text name="label.dashboard.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
    <s:include value="../common/headerinc.jsp"/>
    <s:include value="../common/geomap.jsp" />

</head>
<body id="dashboard">

<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">





<s:fielderror template="smfielderror" />

<%=MessageUtil.displayMessages(request)%>
<p>
                		<fieldset>
                		<legend>
                			<s:text name="label.dashboard.title" />
                        </legend>

				<s:if test="statusMessageCode==0">

				 <div class="notes">
					<h4><s:property value="configurationMessageTitle" escape="false"/>&nbsp;
					<s:text name="label.payment.generic.information" /></h4>
					<p class="last">
						<s:iterator value="configurationMessages">
							<s:property escape="false"/><br>
						</s:iterator>
					</p>
				  </div>

				</s:if>



<s:action id="refAction" namespace="/ref" name="ref"/>


<table border="0" width="50%">
<tr>

<td NOWRAP width="50%">


<div class="profile">
<div>

<h3><s:property value="store.storename" /></h3>
</div>
</div>
<div class='profile-inner-section'>
<s:if test="store!=null">
<p>
<s:text name="label.merchant.view.merchantid" /> <b><s:property value="store.merchantId" /></b>
<br>
<s:text name="label.merchant.apiKey" /> <b><s:property value="apiKey" /></b>
<p>
<s:property value="store.storeaddress" />
<br>
<s:property value="store.storecity" />
<br>
<s:property value="store.storepostalcode" />
<br>
<s:property value="store.storestateprovince" />
<br>
<s:property value="store.countryName" />
</s:if>

<p>
<b><s:text name="label.storeadministrator" /></b>
<br>
<s:property value="userInformation.userfname" />&nbsp;<s:property value="userInformation.userlname" />
<br>
<s:property value="userInformation.adminEmail" />
</div>
</td>

<!-- Messages -->

<s:if test="statusMessageCode==99">

<td valign="top" width="50%">
<div class="icon-error"><s:property value="message" /></div>
</td>

</s:if>

</tr>
</table>



<table width="100%" border="0">
<tr>

<td width=100% valign="top">
<h3><s:text name="label.dashboard.orders" /></h3>
</td>
</tr>
<td width=100% valign="top">

<!-- Order Summary -->
<table width="100%" id="list-table">
<thead>
	<tr>
		<th><s:text name="label.dashboard.channel" /></th>
		<th><s:text name="label.dashboard.date" /></th>
		<th><s:text name="label.dashboard.customer" /></th>
		<th><s:text name="label.dashboard.total" /></th>
	</tr>
</thead>
<tbody>
<s:iterator value="orders">
	<tr>
	<td><s:property value="orderChannelText" /></td>
	<td><s:property value="datePurchasedString" /></td>
	<s:if test="channel==1">
		<td><a href="<%=request.getContextPath() + "/orders/orderdetails.action?order.orderId="%><s:property value="orderId" />"><s:property value="customerName" /></a></td>
	</s:if>
	<s:else>
		<td><a href="<%=request.getContextPath() + "/invoice/showeditinvoice.action?order.orderId="%><s:property value="orderId" />"><s:property value="customerName" /></a></td>
	</s:else>
	<td><s:property value="orderTotalText" /></td></tr>
</s:iterator>
</tbody>
</table>


</td>
</tr>
<tr>
<td>
<br>
<br>
<table width="100%" border="0" valign="top">
<tr>
	<td colspan="3">

		<h3><s:text name="label.generic.sales" /></h3>

	</td>
</tr>
<tr>
	<td><div id='map_canvas'></div> </td>
</tr>
</table>



</td>
</tr>
</table>


</fieldset>
</div>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>



