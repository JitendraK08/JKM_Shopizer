<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.salesmanager.central.shipping.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.shipping.rates.fedex.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
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
                <s:text name="label.shipping.rates.fedexground.title" />
                </legend>

                <p><s:text name="label.shipping.fedex.activation" /></p>



				<s:action id="refAction" namespace="/ref" name="ref"/>

					<s:form name="fedex" action="/shipping/fedexground_save.action" method="post">

    				<s:checkbox id="enableservice" name="moduleEnabled" value="%{moduleEnabled}" template="smcheckbox" label="%{getText('label.shipping.enablertquote')}"/>


                    <s:textfield name="keys.key1" value="%{keys.key1}" label="%{getText('label.shipping.rates.fedex.key')}" size="40" required="true"/>
    				<s:textfield name="keys.userid" value="%{keys.userid}" label="%{getText('label.shipping.rates.fedex.userid')}" size="40" required="true"/>
    				<s:textfield name="keys.password" value="%{keys.password}" label="%{getText('label.shipping.rates.fedex.password')}" size="40" required="true"/>
                    <s:textfield name="keys.key2" value="%{keys.key2}" label="%{getText('label.shipping.rates.fedex.meter')}" size="40" required="true"/>
                    <s:select label="%{getText('label.payment.methods.environment')}" name="properties.properties1" list="#refAction.environments" value="properties.properties1" required="true"/>

                     <!-- include service selection -->
                    <s:include value="shippingpackagesservicesinc.jsp"/>


                    <s:submit value="%{getText('button.label.submit')}"/>
				    <s:submit action="fedexground_delete" value="%{getText('button.label.removeservice')}"/>
				</s:form>


                <hr />
                </fieldset>
            </div><!-- end main -->


		 <s:include value="shippingleftmenu.jsp"/>



        </div><!-- end content -->

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>