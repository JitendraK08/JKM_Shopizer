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


			<s:include value="../components/invoiceConfirmation.jsp"/>
	


			<a href="<%=request.getContextPath()%>/checkout/printInvoice.action" id="printInvoice">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="invoice.print" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	 		





		</div>
	  </div>
	</div>






