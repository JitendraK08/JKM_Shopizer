<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.core.service.cache.RefCache" %>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.entity.reference.*" %>
<%@ page import="com.salesmanager.core.entity.merchant.*" %>
<%@ page import="com.salesmanager.core.service.ServiceFactory" %>
<%@ page import="com.salesmanager.core.service.shipping.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.shipping.rates.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>



     <script language="javascript">



  		function toggleDiv(divid,display){
				document.getElementById(divid).style.display = display;
  		}


  	</script>

</head>

<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">


 <%



 Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);


 String country = CountryUtil.getCountryIsoCodeById(ctx.getCountryid());




 Map shippingrtmodule = (Map)request.getAttribute("shippingrtmodule");
 String shippingcosts = (String)request.getAttribute("shippingcosts");
 String shippingcountries = (String)request.getAttribute("shippingcountries");
 if(shippingrtmodule==null) {
 	shippingrtmodule = new HashMap();
 }

 ShippingService sservice = (ShippingService)ServiceFactory.getService(ServiceFactory.ShippingService);
 List services = sservice.getRealTimeQuoteShippingServices(country);


 boolean shippingrtind = false;

 String shippingzoneindicator = (String)request.getAttribute("shippingzoneindicator");
 boolean shippingzoneind = false;
 if(shippingzoneindicator!=null) {
 	if(shippingzoneindicator.equals("true")) {
 		shippingzoneind = true;
 	}
 }

ResourceBundle bundle = ResourceBundle.getBundle("modules", request.getLocale());



 %>
            <div id="main">


            	<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>

				<fieldset>
                <legend>
                <s:text name="label.shipping.rates.title" />
                </legend>

				<s:form name="savemethoddetails" action="savemethoddetails" method="post" enctype="multipart/form-data" theme="simple">

				<%
				if(services.size()>0) {

				%>
                	<table width="100%" border=0>
                	<tr>
                		<td colspan="3" bgcolor="#cccccc"><s:text name="label.shipping.rates.rt.title" /></td>
                	</tr>
                	<%
                	if(services.size()>1) {
                	%>
                	<tr>
                		<td colspan="3"><font color="red"><s:text name="label.shipping.rates.rt.note" /></font></td>
                	</tr>
                	<%
                	}
                	%>
                	<%



                	Iterator sit = services.iterator();
					while(sit.hasNext()) {
						CoreModuleService cis = (CoreModuleService)sit.next();
						if(cis.getCoreModuleServiceSubtype()==0) {

							String name = bundle.getString("module." + cis.getCoreModuleName());

					%>

                	<tr>
                				<td width="30">
                				<%

                				MerchantConfiguration conf = (MerchantConfiguration )shippingrtmodule.get(cis.getCoreModuleName());
                				if(conf!=null && conf.getConfigurationValue().equals("true")) {
								%>
									<img src="<%=request.getContextPath()%>/common/img/green-check.jpg">
								<%
								} else {
								%>
									<img src="<%=request.getContextPath()%>/common/img/red-dot.jpg">
								<%
								}
								%>

                				</td>


                				<td align="left">
                				<a href="<%=request.getContextPath()%>/shipping/<%=cis.getCoreModuleName()%>_display.action"><%=name%></a>
                				</td>
                				<td align="left"><img src="<%=request.getContextPath()%>/common/img/<%=request.getLocale().getLanguage()%><%=cis.getCoreModuleServiceLogoPath()%>"></td>

                	</tr>

                	<%
						}
                	}

                	%>
                	<tr>
                		<td align="left" colspan="3">
                				  		  <s:if test="displayQuoteDeliveryTime==1">
										 <input type="radio" name="displayQuoteDeliveryTime" checked id="displayQuoteDeliveryTime" value="1" onClick="javascript:toggleDiv('text','none');"/><label for="quoteDisplayType"><s:text name="label.shipping.displayquote.1" /></label>
								  </s:if>
								  <s:else>
										 <input type="radio" name="displayQuoteDeliveryTime" id="displayQuoteDeliveryTime" value="1" onClick="javascript:toggleDiv('text','none');"/><label for="quoteDisplayType"><s:text name="label.shipping.displayquote.1" /></label>
								  </s:else>
						</td>
                	</tr>
                	<tr>
                		<td align="left" colspan="3">
                				              <s:if test="displayQuoteDeliveryTime==0">
										<input type="radio" name="displayQuoteDeliveryTime" id="displayQuoteDeliveryTime" checked value="0" onClick="javascript:toggleDiv('text','block');"/><label for="quoteDisplayType"><s:text name="label.shipping.displayquote.0" /></label>
								  </s:if>
								  <s:else>
										 <input type="radio" name="displayQuoteDeliveryTime" id="displayQuoteDeliveryTime" value="0" onClick="javascript:toggleDiv('text','block');"/><label for="quoteDisplayType"><s:text name="label.shipping.displayquote.0" /></label>
								  </s:else>
						<br><br>
						<s:if test="displayQuoteDeliveryTime==0">
							<div id="text" style="display:block">
						</s:if>
						<s:else>
							<div id="text" style="display:none">
						</s:else>

							<s:iterator value="languages" status="lang">

								<!-- Shipping text -->
								<s:text name="%{getText('label.shipping.displayquote.text')} (%{code})"/>:<br>
								<s:textarea id="shippingText" name="shippingText[%{#lang.index}]" label="%{getText('label.shipping.displayquote.text')} (%{code})" rows="4" cols="50" value="%{shippingText[#lang.index]}"></s:textarea>
								<br><br>
							</s:iterator>
						</div>
				</td>
                	</tr>


			<tr>
						<td colspan="3">&nbsp;</td>
			</tr>

                	<tr>
                		<td align="left" colspan="3">
                			      <s:radio label="" id="quoteDisplayType" name="quoteDisplayType" list="displayQuoteOrder" value="%{quoteDisplayType}"/>
                		</td>
                	</tr>
					<tr>
						<td colspan="3" align="right">
							<s:submit value="%{getText('button.label.submit')}"/>
						</td>
					</tr>
                	<!--</table>-->
                <%
                } else {
                %>
                <table>
                <%
                }
                %>
                	<tr>
                		<td colspan=3>&nbsp;</td>
                	</tr>
                	<tr>
                		<td colspan=3>&nbsp;</td>
                	</tr>

		            <!--<table width="100%" border=1>-->
                	<tr>
                		<td colspan="3" bgcolor="#cccccc" align="left"><s:text name="label.shipping.rates.manual.title" /></td>
                	</tr>
                	<tr>
                		<td width="30">
                	<%
                	if(shippingcosts!=null && shippingcountries!=null && shippingzoneind) {

                		%>
							<img src="<%=request.getContextPath()%>/common/img/green-check.jpg">
						<%
						} else {
						%>
							<img src="<%=request.getContextPath()%>/common/img/red-dot.jpg">
						<%
						}
						%>
                		</td>
                		<td align="left"><a href="<%=request.getContextPath()%>/shipping/ratetable.action"><s:text name="label.shipping.rates.manual.ratetable" /></a></td>
                		<td>&nbsp</td>
                	</tr>
                </table>

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
