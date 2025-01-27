<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.payment.methods.title.authorizenet" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>
</head>

<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">


           <div id="main">
               <s:actionerror template="smactionerror" />
				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>

				<fieldset>
                <legend>
                <s:text name="label.payment.methods.title.authorizenet" />
                </legend>

                <s:action id="refAction" namespace="/ref" name="ref"/>

				<s:form name="authorizenet" action="authorizenet_save.action" method="post">

				<s:checkbox id="enableservice" name="moduleEnabled" value="%{moduleEnabled}" template="smcheckbox" label="%{getText('label.payment.enablemodule')}"/>

				<s:textfield name="keys.userid" value="%{keys.userid}" label="%{getText('label.payment.methods.authorizenet.username')}" size="40" required="true"/>
				<s:textfield name="keys.transactionKey" value="%{keys.transactionKey}" label="%{getText('label.payment.methods.authorizenet.transactionkey')}" size="40" required="true"/>

				<s:select list="#refAction.creditpmactions" label="%{getText('label.payment.gateway.transactiontype')}"
			               value="%{properties.properties1}" name="properties.properties1"  required="true"/>

				<s:radio label="%{getText('label.payment.gateway.usecvv')}" name="properties.properties3" list="#refAction.cvvmap" value="properties.properties3" required="true"/>
				<s:radio label="%{getText('label.payment.methods.environment')}" name="properties.properties2" list="#refAction.environments" value="%{properties.properties2}" required="true"/>


                    <s:submit value="%{getText('button.label.submit')}"/>
                    <s:submit action="authorizenet_delete" value="%{getText('button.label.removeservice')}"/>

				</s:form>
                <hr />
                </fieldset>
            </div><!-- end main -->




        </div><!-- end content -->

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>
