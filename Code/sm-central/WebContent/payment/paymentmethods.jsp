<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.core.service.cache.RefCache" %>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.central.payment.*" %>
<%@ page import="com.salesmanager.core.entity.merchant.*" %>
<%@ page import="com.salesmanager.core.entity.reference.*" %>
<%@ page import="com.salesmanager.core.service.reference.*" %>
<%@ page import="com.salesmanager.core.service.payment.*" %>
<%@ page import="com.salesmanager.core.service.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.payment.methods.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>
</head>

<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">

<%


Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);


ReferenceService rservice = (ReferenceService)ServiceFactory.getService(ServiceFactory.ReferenceService);
Collection services = rservice.getPaymentMethodsList(ctx.getCountryid());


Map paymentmethods = (Map)request.getAttribute("paymentmethods");

if(paymentmethods==null) {
	paymentmethods = new HashMap();
}

ResourceBundle bundle = ResourceBundle.getBundle("modules", request.getLocale());

%>

            <div id="main">
				<s:actionerror template="smactionerror"/>
				<%=MessageUtil.displayMessages(request)%>
				<p>
                <fieldset>
                <legend>
                <s:text name="label.payment.methods.title" />
                </legend>

                <p><s:text name="label.payment.methods.text" /></p>


                <p>

				<%
				if(services!=null && services.size()>0) {

				%>
                	<table width="100%" border=0>
                	<%
                	Iterator sit = services.iterator();
					while(sit.hasNext()) {
						CoreModuleService cis = (CoreModuleService)sit.next();
						if(!cis.isCoreModuleServiceVisible()) {
							continue;
						}

						String name = bundle.getString("module." + cis.getCoreModuleName());


						String logo = cis.getCoreModuleServiceLogoPath();

					%>

                		<tr>
                		<td width="30">



                		<%



                		MerchantConfiguration conf = (MerchantConfiguration )paymentmethods.get(cis.getCoreModuleName());
                				if(conf!=null && conf.getConfigurationValue()!=null && conf.getConfigurationValue().equals("true")) {


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
                		<a href="<%=request.getContextPath()%>/payment/<%=cis.getCoreModuleName()%>_display.action"><%=name%></a></td>
                		<%
                		if(logo!=null && !logo.equals("") && !logo.startsWith("<")) {
                		%>
                			<td align="left"><img src="<%=request.getContextPath()%>/common/img/<%=request.getLocale().getLanguage()%><%=logo%>"></td>
                		<%
                		} else if(logo!=null && !logo.equals("")) {
                		%>
                			<td align="left"><%=logo%></td>
                		<%
                		}
                		%>
                		</tr>

                	<%
                	}
                	%>

                	</table>
                <%
                } else {
                %>

					<p><s:text name="label.payment.methods.displayerror" /></p>
				<%
				}
				%>



                </fieldset>
                <hr />
            </div><!-- end main -->




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>