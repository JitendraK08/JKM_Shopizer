	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.menu.group.store" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UpdateZones.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
    
  <s:include value="../common/headerinc.jsp"/>

<s:include value="../common/js/formvalidation.jsp"/><!--ie does not see that script ... -->



    
</head>


<body>
<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">
<s:actionerror template="smactionerror"/>
<s:fielderror template="smfielderror"/>
<s:actionmessage/>

	<%=MessageUtil.displayMessages(request)%>
		<fieldset>
		<legend>
			<s:text name="label.menu.group.merchant.store.view"/>
        </legend>
<table id="mainform" >
  <tr>
  	<th><s:text name="label.merchant.view.merchantid"/></th>
  	<th><s:text name="label.merchant.view.adminname"/></th>
  	<th><s:text name="label.merchant.view.adminemail"/></th>
  	<th><s:text name="label.merchant.view.storename"/></th>
  </tr>
   <s:iterator value="merchantStoreHeaderList">
	<tr>
  		<td><s:property value="merchantId"/></td>
  		<td><s:property value="adminName"/></td>
  		<td><s:property value="adminEmail"/></td>
  		<td><s:property value="storename"/></td>
		<td><a href='<%=request.getContextPath()%>/merchantstore/editmerchantstore.action?merchantId=<s:property value="merchantId"/>'>Edit</a></td>
  	</tr>   
    
   </s:iterator>
  
</table>        
 </fieldset>
</div>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>
     