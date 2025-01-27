<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<%@ page import = "com.salesmanager.core.entity.merchant.MerchantStore" %>
<%@ page import = "com.salesmanager.core.entity.payment.PaymentMethod" %>
<%@ page import = "com.salesmanager.core.util.PaymentUtil" %>
<%@ page import = "com.salesmanager.core.util.CreditCardUtil" %>
<%@ page import = "java.util.*" %>


<%

Locale locale = (Locale)request.getAttribute("LOCALE");

MerchantStore store = (MerchantStore)session.getAttribute("STORE");

Map paymentMethods = PaymentUtil.getPaymentMethods(store.getMerchantId(),locale);



%>



					<div class="section">
						<div class="section-header"><font class="section-header-1stword"><s:text name="label.generic.accepted" /></font> <s:text name="label.generic.payments" /></div>
						
						<div class="line-10px">

							<%
								boolean cardsDisplayed=false;
								Iterator paymentsIterator = paymentMethods.keySet().iterator();
								while(paymentsIterator.hasNext()) {

									String paymentKey = (String)paymentsIterator.next();
									PaymentMethod method = (PaymentMethod)paymentMethods.get(paymentKey);
									
									if(method.getType()==1) {


										if(!cardsDisplayed) {

											List cardsLink = CreditCardUtil.getCreditCardStripImages();
											Iterator cardsLinkIterator = cardsLink.iterator();
											while(cardsLinkIterator.hasNext()) {
												String cardLink = (String)cardsLinkIterator.next();
							%>
												<img src="<%=request.getContextPath()%>/common/img/payment/<%=cardLink%>">&nbsp;
							<%
											
											}
											cardsDisplayed = true;

										}
							%>

											<br>
							<%

									} else {

										if(method.getPaymentImage()!=null && !method.getPaymentImage().equals("")) {

							%>

											<img src="<%=request.getContextPath()%>/common/img/<%=method.getPaymentImage()%>">&nbsp;
							<%

										} else {

							%>
											<%=method.getPaymentMethodName()%>&nbsp;

							<%


										}
									}


								}

							%>

						</div>
					</div>




