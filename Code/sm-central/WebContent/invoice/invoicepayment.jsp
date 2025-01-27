


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.salesmanager.central.entity.reference.*" %>
<%@ page import="com.salesmanager.central.entity.payment.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">





<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.system.name" /> - <s:text name="label.invoice.button.payment" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
	<script type="text/javascript" src="../common/js/calendarDateInput.js"></script>
</head>


<s:include value="../common/headerinc.jsp"/>



<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">


            <div id="main">
				<s:actionerror/>
				<s:actionmessage/>
				<s:fielderror template="smfielderror"/>
				<%=MessageUtil.displayMessages(request)%>
				<p>
           <fieldset>
                		<legend>
                		<s:text name="label.invoice.button.payment" />
                        </legend>



                        <!-- Invoice details -->
                        <table>
                        <tr>
                        	<td><b><s:text name="label.invoice.invoiceid" />:</b></td>
                        	<td><b><s:property value="order.orderId" /></b></td>
                        </tr>
                        <tr>
                        	<td><s:text name="label.customer.name" />:</td>
                        	<td><s:property value="order.customerName" /></td>
                        </tr>
                        <tr>
                        	<td><s:text name="label.invoice.invoicetotal" />:</td>
                        	<td><s:property value="order.orderTotalText" /></td>
                        </tr>

                        </table>
				<br>
				<br>


                        <s:action id="refAction" namespace="/ref" name="ref"/>



                        <!-- payment method selection -->
						<s:form action="processinvoicepayment" method="post" theme="simple">


                            	<table class="wwFormTable">
								<tr>
									<td class="tdLabel"><label for="method" class="label"><s:text name="label.invoice.slectpayment" />:</label></td>
									<td class="tdLabel"><s:select list="applicablePayments" listKey="paymentModuleName" listValue="paymentMethodName" label="%{getText('label.invoice.slectpayment')}"
               						value="" name="paymentModule" required="true"/></td>
								</tr>

								<tr>
									<td class="tdLabel"><label for="date" class="label"><s:text name="label.invoice.payment.receptiondate" />:</label></td>
									<td class="tdLabel">
									<script>DateInput('invoiceDate', true, 'YYYY-MM-DD','<%=DateUtil.formatDate(new Date())%>')</script>
									</td>
								</tr>
								<!--
								<tr>
									<td class="tdLabel"><label for="status" class="label"><s:text name="label.invoice.payment.paymentstatus" />:</label></td>
									<td class="tdLabel">

									<s:checkboxlist name="paymentStatus"
                               				list="#refAction.successfail"
                               				label="%{getText('label.invoice.payment.paymentstatus')}"
                               				value="1"
                               				required="true"/>

									</td>
								</tr>
								-->


								<tr>
									<td colspan="2" align="right"><div align="right"><s:submit value="%{getText('button.label.submit')}"/></div></td>
								</tr>


								<s:hidden name="order.orderId" value="%{order.orderId}" />

                            	</table>











                        </s:form>




		   </fieldset>


            </div><!-- end main -->




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>