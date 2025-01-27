
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>








			  		<div id="wrapper" class="clearfix" >



					<div id="maincol" >





					<div id="checkoutform" class="formcontent">





<s:form name="PaymentForm" theme="simple" method="post" action="selectPaymentMethod">



		<!-- Summary -->
		<s:include value="../components/summary.jsp"/>

		<!-- Payment -->
		<s:include value="../components/payment.jsp"/>


	  <br/>
	  <fieldset>
	  <s:if test="paymentMethods!=null && paymentMethods.size">
        
			<a href="javascript:document.PaymentForm.submit();">
				<div class="href-button-checkout">
					<span class="button1-box1"></span>
					<span class="button1-box2a"><s:text name="label.generic.continue" /></span>
					<span class="button1-box3"></span>
				</div>
			</a>
	  </s:if>
	  </fieldset>

</s:form>

		</div>
		</div>
		</div>


