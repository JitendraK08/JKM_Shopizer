	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.changepassword" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

</head>


     <s:include value="../common/headerinc.jsp"/>











<body id="profile">

<div id="page">

	    <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">




			<s:fielderror template="smfielderror" />

			<%=MessageUtil.displayMessages(request)%>
			<p>
                		<fieldset>
                		<legend>
                			<s:text name="label.changepassword" />
                        </legend>



<form name="password"  action="<%=request.getContextPath() %>/profile/savePassword.action" method="post">
<table class="wwFormTable" id="mainform" >
    <s:password name="merchantProfile.adminPass" value="" label="%{getText('customer.changepassword.currentpassword.label')}" size="10" required="true"/>
    <s:password name="newPassword" value="" label="%{getText('customer.changepassword.newpassword.label')}" size="10" required="true"/>
    <s:password name="repeatNewPassword" value="" label="%{getText('customer.changepassword.confirmnewpassword.label')}" size="10" required="true"/>

    <s:submit value="%{getText('button.label.submit')}"/>
</table>
</form>





</fieldset>
</div>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>
