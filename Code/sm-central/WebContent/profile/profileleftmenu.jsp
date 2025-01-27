<%@ page import="com.salesmanager.core.util.*" %>
<%@taglib prefix="s" uri="/struts-tags" %>


<%@ page import="com.salesmanager.central.profile.Context" %>
<%@ page import="com.salesmanager.central.profile.ProfileConstants" %>

<%

Context usercontext = (Context)request.getSession().getAttribute(ProfileConstants.context);

%>


		<div id="local">
                <h2><s:text name="label.generic.options" /></h2>
                <ul>
                	<%if(SecurityUtil.isMerchantInRole(request,"superuser")){%>
			<%if(usercontext.isExistingStore()) {%>
                    <li><a href="<%=request.getContextPath()%>/merchantstore/editmerchantstore.action"><s:text name="label.profile.createstore" /></a></li>
                    <li><a href="<%=request.getContextPath()%>/merchantstore/viewMerchantStores.action"><s:text name="label.profile.editstore" /></a></li>
                   <%}%> 
			 <%}%>
                    <li><a href="<%=request.getContextPath()%>/profile/displayPassword.action"><s:text name="label.changepassword" /></a></li>
                </ul>


         </div><!-- local -->

