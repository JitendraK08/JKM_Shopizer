<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
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

			<s:form name="SelectCard" id="SelectCard" theme="simple" method="post" action="selectInvoicePaymentMethod">

			<s:if test="hasPayment==true && paymentMethods.size>0 && order.orderStatus==20">
	
	
			<s:include value="../components/creditCard.jsp"/>
	


			

			<br><br>
			<a href="#" onClick="javascript:document.SelectCard.submit();" id="postItems">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="label.generic.continue" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	 		

			</s:if>

			<br><br>
			<a href="<%=request.getContextPath()%>/checkout/printInvoice.action" id="printInvoice">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="invoice.print" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	 		


			</s:form>


		</div>
	  </div>
	</div>






