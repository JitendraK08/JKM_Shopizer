	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>

<%@ page import = "java.util.*" %>
<%@ page import = "com.salesmanager.core.entity.catalog.*" %>
<%@ page import = "com.salesmanager.central.profile.Context" %>
<%@ page import = "com.salesmanager.core.service.ServiceFactory"  %>
<%@ page import = "com.salesmanager.central.web.CategoryHelper"  %>

<%@taglib prefix="s" uri="/struts-tags" %>

<%
	CatalogService cservice = (CatalogService)ServiceFactory.getService(ServiceFactory.CatalogService);
	Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);
%>

<s:form name="choosecategory" action="selectcategory" method="post">
	<table bgcolor="#cccccc">
	<%
		String scategfilter = (String)request.getAttribute("categoryfilter");
		String ssubcategfilter = (String)request.getAttribute("subcategoryfilter");
	%>
	<tr>
		<td>
			<s:text name="label.choosecategory" />
		</td>
		<%
		//List supercateg = RefCache.getSubcategories(0,request.getLocale().getLanguage());
		List supercateg = cservice.getCategoriesDescriptionByCategoryAndLang(ctx.getMerchandId(),0,request.getLocale().getLanguage());
		if(supercateg!=null && supercateg.size()>0) {
			Iterator isup = supercateg.iterator();
			if(scategfilter==null) {
				%>
				<td>
				<b><font color="red">*</font></b>
				</td>
				<%
			}
			%>
			<td>
			<select rel="dropdown" name="categ" onChange="this.document.choosecategory.submit();">
		 	<option value="-1">-- <s:text name="label.choosecategory" /> --</option>
			<%
			String selected = "";
			while(isup.hasNext()) {
			    selected = "";
				CategoryDescription c = (CategoryDescription)isup.next();
				if(scategfilter!=null && scategfilter.equals(String.valueOf(c.getCategory().getCategoryId()))) {
					selected = "SELECTED";
				}
			  %>
			  <option value="<%=c.getCategory().getCategoryId()%>" <%=selected%>><%=c.getName() %></option>
			  <%
			}
			%>
			</select>
			</td>
			<%
		}
		%>


		<td>
			<s:text name="label.choosesubcategory" />
		</td>
		<%
		List subcateg = new ArrayList();
		if(scategfilter!=null) {
			//subcateg = RefCache.getSubcategories(Integer.parseInt(scategfilter),request.getLocale().getLanguage());
			//subcateg = RefCache.getSubcategories(Integer.parseInt(scategfilter),request.getLocale().getLanguage());
			subcateg = cservice.getCategoriesDescriptionByCategoryAndLang(ctx.getMerchandId(),Integer.parseInt(scategfilter)request.getLocale().getLanguage())
		} else {
		%>
		<td>
				<b><font color="red">*</font></b>
		</td>
		<%
		}
		%>
		<td>
			<select rel="dropdown" name="subcateg" >
		 	<option value="-1">-- <s:text name="label.choosesubcategory" /> --</option>
		<%

		if(subcateg.size()>0) {
			Iterator isup = subcateg.iterator();

			String selected = "";
			while(isup.hasNext()) {
			    selected = "";
				Category c = (Category)isup.next();
				if(ssubcategfilter!=null && ssubcategfilter.equals(String.valueOf(c.getCategory().getCategoryId()))) {
					selected = "SELECTED";
				}
			  %>
			  <option value="<%=c.getCategory().getCategoryId()%>" <%=selected%>><%=c.getName() %></option>
			  <%
			}
		}
		%>
			</select>
		</td>

	</tr></table>
	<s:hidden name="merchantid" value="%{merchantProfile.merchantid}"/>
</s:form>