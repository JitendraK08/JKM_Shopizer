<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.core.service.cache.RefCache" %>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.salesmanager.core.entity.reference.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.constants.ShippingConstants" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.shipping.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>

<script language="javascript">

  function toggleDiv(divid,display){
	document.getElementById(divid).style.display = display;
  }

  function submitShipping() {

  }
</script>

</head>

<%

Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);
String shipzone = (String)request.getAttribute("shippingzone");
LabelUtil label = LabelUtil.getInstance();

int countryid = ctx.getCountryid();
Map countries = RefCache.getAllcountriesmap(LanguageUtil.getLanguageNumberCode(ctx.getLang()));
Map countriesstatus = RefCache.getCountriesStatus();
Country currentcountry = (Country)countries.get(countryid);

Map zonesskipped = (Map)request.getAttribute("zonesskipped");
if(zonesskipped==null) {
	zonesskipped = new HashMap();
}


%>

<body id="Shipping Main">

    <div id="pagecontent">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">

            <div id="main">
				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>


				<fieldset>
                			<legend>
                				<s:text name="leftmenu.shipping.shippingzones" />
               			 </legend>


				<form name="shippingzones" action="<%=request.getContextPath()%>/shipping/selectshippingzones.action" method="post">

					<table border=0><tr>
					<%
					String checked="";
					if(shipzone==null || shipzone.equals(ShippingConstants.DOMESTIC_SHIPPING)) {
						checked = "CHECKED";
					}
					%>
					<td><s:text name="shipzone.domestic" />&nbsp;<s:text name="shipzone.prefix" /><%=currentcountry.getCountryIsoCode2()%><s:text name="shipzone.suffix" /></td>
					<td align="right"><input type="radio" name="shippingzone" value="<%=ShippingConstants.DOMESTIC_SHIPPING%>" <%=checked%> onClick="javascript:toggleDiv('zones','none');"></td>
					</tr>
					<tr>
					<%
					checked="";
					if(shipzone!=null && shipzone.equals(ShippingConstants.INTERNATIONAL_SHIPPING)) {
						checked = "CHECKED";
					}
					%>
					<td valign="top"><s:text name="shipzone.countriesunselected" /></td>
					<td align="right"><input type="radio" name="shippingzone" value="<%=ShippingConstants.INTERNATIONAL_SHIPPING%>" <%=checked%> onClick="javascript:toggleDiv('zones','block');">
					</td>


					</tr>

					<tr>
					<td>


					</td>
					<td align="right" valign="top"><input type="button" name="<%=label.getText("button.label.submit")%>" value="<%=label.getText("button.label.submit")%>" onClick="javascript:document.shippingzones.submit();"></td>
					</tr>
					<tr>





					<td colspan="2">
						<%
						if(shipzone!=null && shipzone.equals(ShippingConstants.INTERNATIONAL_SHIPPING)) {
						%>
							<div id="zones" style="display:block">
						<%} else {%>
							<div id="zones" style="display:none">

						<%}%>


							<%
							Map allcountriesmap = RefCache.getAllcountriesmap(LanguageUtil.getLanguageNumberCode(ctx.getLang()));
							if(allcountriesmap!=null && allcountriesmap.size()>0) {


							%>

							<p><s:text name="label.shipping.selectexcludedcountries" />
							<br>
							</p>



							<%
								int maxcols = 2;
								int i = 0;
								%>

								<table><tr>
								<%

								Iterator allcountriesit = allcountriesmap.keySet().iterator();
								while(allcountriesit.hasNext()) {

									int cid = (Integer)allcountriesit.next();

									Country c = (Country)allcountriesmap.get(cid);


									String displaystatus="";
									CentralCountryStatus status = (CentralCountryStatus)countriesstatus.get(c.getCountryId());
									if(status!=null) {
										if(status.getCentralCountryStatusCode()==ShippingConstants.SHIPPING_SAFE) {
											displaystatus="<font color=\'green\'>"+label.getText("label.shipping.safe")+"</font>";
										} else if(status.getCentralCountryStatusCode()==ShippingConstants.SHIPPING_RISK) {
											displaystatus="<font color=\'red\'>"+label.getText("label.shipping.risk")+"</font>";
										}
									}
									if(i==maxcols) {
										i=0;
										%>
										</tr><tr>
										<%
									}
									String name="";

									name = c.getCountryName();
									String schecked = "";
									if(zonesskipped.containsKey(c.getCountryIsoCode2())) {
										schecked="checked=\'checked\'";
									}
									%>
									<td><%=name%></td><td><input type="checkbox" name="excludezones" value="<%=c.getCountryIsoCode2()%>" <%=schecked%>></td><td><%=displaystatus%></td>
									<%

									i++;
								}
							%>
							</tr>
							</table>

							<%
							}
							%>

						</div>
					</td>



					</tr>
					</table>
				</form>


                <hr />
                </fieldset>



            </div><!-- end main -->



		 <s:include value="shippingleftmenu.jsp"/>




        </div><!-- end content -->

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->


</body>
</html>