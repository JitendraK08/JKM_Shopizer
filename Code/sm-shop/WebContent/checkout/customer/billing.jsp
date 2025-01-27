
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>






			  		<div id="wrapper" class="clearfix" >



						<div id="maincol" >


							<div id="checkoutform" class="formcontent">


								<s:form name="CheckoutPaymentForm" theme="simple" method="post" action="validateCustomer">

									<!-- Summary -->
									<s:include value="../components/summary.jsp"/>

		
									<!-- Customer -->
									<s:include value="../components/customer.jsp"/>


									<!-- Payment -->
									<s:if test="hasCreditCardPayment==true">

										<s:include value="../components/creditCard.jsp"/>

									</s:if>

									<br/>
									<fieldset>
									<a href="javascript:document.CheckoutPaymentForm.submit();">
										<div class="href-button-checkout">
											<span class="button1-box1"></span>
											<span class="button1-box2a"><s:text name="label.generic.continue" /></span>
											<span class="button1-box3"></span>
										</div>
									</a>
									</fieldset>


		


								</s:form>

							</div>
						</div>
					</div>



