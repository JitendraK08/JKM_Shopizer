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
    <title><s:text name="label.payment.methods.title.paypal" /></title>
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
                <s:text name="label.payment.methods.title.paypal" />
                </legend>

                <div class="notes">
					<h4><s:text name="label.payment.methods.title.paypal" />&nbsp;<s:text name="label.payment.generic.information" /></h4>
					<p class="last">
					<s:text name="label.payment.methods.text.paypal" />
					</p>
				</div>

				<s:action id="refAction" namespace="/ref" name="ref"/>

				<s:form name="paypal" action="paypal_save.action" method="post">

					<s:checkbox id="enableservice" name="moduleEnabled" value="%{moduleEnabled}" template="smcheckbox" label="%{getText('label.payment.generic.use')}"/>

					<s:textfield name="keys.properties1" value="%{keys.properties1}" label="%{getText('label.payment.methods.paypal.userid')}" size="40" required="true"/>
					<s:textfield name="keys.properties2" value="%{keys.properties2}" label="%{getText('label.payment.methods.paypal.password')}" size="40" required="true"/>
					<s:textfield name="keys.properties3" value="%{keys.properties3}" label="%{getText('label.payment.methods.paypal.signature')}" size="40" required="true"/>



					<s:select list="#refAction.creditpmactions" label="%{getText('label.payment.gateway.transactiontype')}"
			               value="%{keys.properties4}" name="keys.properties4"  required="true"/>


					<s:radio label="%{getText('label.payment.methods.environment')}" name="keys.properties5" list="#refAction.environments" value="%{keys.properties5}" required="true"/>

                    <s:submit value="%{getText('button.label.submit')}"/>
                    <s:submit action="paypal_delete" value="%{getText('button.label.removeservice')}"/>

					</s:form>
                <hr />
                </fieldset>

                <center><!-- Begin PayPal Logo --><a href="https://www.paypal.com/row/mrb/pal=YXJJ7DUXDQSRN" target="_blank"><img  src="http://images.paypal.com/en_US/i/bnr/paypal_mrb_banner.gif" BORDER="0" ALT="Sign up for PayPal and start accepting credit card payments instantly."></a><!-- End PayPal Logo --></center>


            </div><!-- end main -->




        </div><!-- end content -->

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>