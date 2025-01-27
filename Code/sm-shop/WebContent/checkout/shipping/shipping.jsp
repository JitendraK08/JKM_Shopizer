
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>








			  		<div id="wrapper" class="clearfix" >



					<div id="maincol" >





					<div id="checkoutform" class="formcontent">





<s:form name="ShippingForm" theme="simple" method="post" action="selectShippingMethod">



		<!-- Summary -->
		<s:include value="../components/summary.jsp"/>

		<!-- Shipping -->
		<s:include value="../components/shipping.jsp"/>


	  <br/>
	  <fieldset>
	  <s:if test="shippingMethods!=null && shippingMethods.size">

			

			<a href="javascript:document.ShippingForm.submit();">
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


