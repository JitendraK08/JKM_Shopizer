<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.common.util.UrlUtil" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>


	<style type="text/css">
	/*<![CDATA[*/
 		div.c1 {clear:both}
	/*]]>*/
	</style>


	<div id="wrapper" class="clearfix" >



		<div id="maincol" >


			<div id="checkoutform" class="formcontent">

			<s:form name="InvoicePaymentForm" id="InvoicePaymentForm" theme="simple" method="post" action="/checkout/initInvoiceCheckout.action">


			<s:if test="hasPayment==true && paymentMethods.size>0 && order.orderStatus==20">
	
			<s:include value="../components/paymentSelection.jsp"/>

			</s:if>
	


			<s:if test="hasPayment==true && paymentMethods.size>0 && order.orderStatus==20">
			<div>
			

			
			<a href="#" onClick="javascript:document.InvoicePaymentForm.submit();" id="postItems">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="invoice.pay" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	 		

			</s:if>

			<div>
			<br><br>
			<a href="<%=UrlUtil.getUnsecuredDomain(request)%><%=request.getContextPath()%>/cart/printInvoice.action" id="printInvoice">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="invoice.print" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	 		</div>
			</div>


			</s:form>


		</div>
	  </div>
	</div>






