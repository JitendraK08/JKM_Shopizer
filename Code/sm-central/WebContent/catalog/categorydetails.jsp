	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>

<%@ page import = "java.util.*" %>
<%@ page import = "com.salesmanager.core.entity.catalog.*" %>
<%@ page import = "com.salesmanager.central.profile.*" %>
<%@ page import = "com.salesmanager.central.web.*"  %>
<%@ page import = "com.salesmanager.core.util.*"  %>
<%@ page import = "java.math.*"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.category.categogydetails" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
    <s:include value="../common/headerinc.jsp"/>


    <script type="text/javascript" src="../common/js/calendarDateInput.js"></script>
</head>

<%


Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);

List histories = (List)request.getAttribute("histories");
if(histories==null) {
	histories = new ArrayList();
}

Locale loc = request.getLocale();

%>


<body id="profile">

<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">


            <div id="main">

				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>
                <fieldset>
                <legend>
                <s:text name="label.category.categogydetails" />
                </legend>

                <b><s:property value="%{categoryname}"/></b>
                <p>

				<s:form name="savecategoryspecialsdetails" enctype="multipart/form-data" action="savecategoryspecialsdetails" method="post" enctype="multipart/form-data">

    			<s:hidden name="categoryid" value="%{categoryid}"/>

				<tr><td>
				<a href="<s:url action="downloadmultiplefile">
				<s:param name="categoryId" value="%{categoryid}"/>
				</s:url>"><s:text name="label.product.generatexmlforall"/></a>
				</td></tr>
				</table>

                <table>
                <tr>
					<td class="tdLabel">&nbsp;</td>
            		<td>&nbsp;</td>
    			</tr>

                <%
					String classlabel = "label";
					String message = MessageHelper.displayFormErrorMessage(request,"productdiscountprice");
					if(message!=null && !message.equals("")) {
						classlabel = "errorLabel";
				%>
					<%=message %>
				<%
					}
				%>

			   <tr>
					<td class="tdLabel"><label for="price" class="<%=classlabel %>"><s:text name="label.product.discountprice" /><span class="required">*</span>:</label></td>
            		<td>
            		<select name="discount" id="discount">
            		<option value="-1">--</option>
            		<%for(int count=1;count<100;count++) { %>
            		<option value="<%=count %>"><%=count %></option>
            		<%} %>
            		</select><s:text name="label.generic.percentsign" />&nbsp;<s:text name="label.generic.off"/>
            		</td>
    			</tr>

    			<!--  Start Date(calendar)  -->

				<%
				    String sdate = (String)request.getAttribute("sdate");
				%>

				<tr>
					<td class="tdLabel"><label for="date" class="label"><s:text name="label.generic.startdate" />:</label></td>
					<td>
					<%if(sdate!=null){ %>
					<script>DateInput('dstartdate', true, 'YYYY-MM-DD','<%=sdate%>')</script>
					<%}else{ %>
					<script>DateInput('dstartdate', true, 'YYYY-MM-DD')</script>
					<%} %>
					</td>
				</tr>

				 <!--  End Date(calendar)  -->

				<%
				    String edate = (String)request.getAttribute("edate");
				%>

				<tr>
					<td class="tdLabel"><label for="date" class="label"><s:text name="label.generic.enddate" />:</label></td>
					<td>
					<%if(edate!=null){ %>
					<script>DateInput('denddate', true, 'YYYY-MM-DD','<%=edate%>')</script>
					<%}else{ %>
					<script>DateInput('denddate', true, 'YYYY-MM-DD')</script>
					<%} %>
					</td>
				</tr>

				            <s:submit value="%{getText('button.label.submit')}"/>
                			<s:submit action="deletecategoryspecialsdetails" value="%{getText('label.category.deletealldiscounts')}"/>


				</s:form>

				<s:form name="savecategorypropertiesdetails" action="savecategorypropertiesdetails" method="post" enctype="multipart/form-data">

    			<s:hidden name="categoryid" value="%{categoryid}"/>


				<tr>
					<td class="tdLabel">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td class="tdLabel">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td class="tdLabel"><label for="pc" class="label"><s:text name="label.product.properties.Color" />:</label></td>
            		<td>&nbsp;</td>
    			</tr>

				<%

    			request.setAttribute("propertylistcolumncount",3);
    			request.setAttribute("fieldname","colorproperties");
    			Map colormap = (Map)request.getAttribute("colorlist");
    			request.setAttribute("propertylist",colormap);

    			%>

    			<s:include value="properties_selection.jsp"/>

    			<tr>
					<td class="tdLabel">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
    			<tr>
					<td class="tdLabel"><label for="ps" class="label"><s:text name="label.product.properties.Size" />:</label></td>
            		<td>&nbsp;</td>
    			</tr>

    			<%

    			request.setAttribute("propertylistcolumncount",1);
    			request.setAttribute("fieldname","sizeproperties");
    			Map suservals = (Map)request.getAttribute("sizeuservalues");
    			Map sizemap = (Map)request.getAttribute("sizelist");
    			request.setAttribute("propertylist",sizemap);

    			%>

    			<s:include value="properties_selection.jsp"/>


                <s:submit value="%{getText('button.label.submit')}"/>
                <s:submit action="deletecategorypropertiesdetails" value="%{getText('label.category.deleteallproperties')}"/>

		    </s:form>

				<table width="600">
				<%
				Iterator it = histories.iterator();
				while(it.hasNext()) {
					com.salesmanager.central.entity.catalog.MerchantCategoriesHistory history = (com.salesmanager.central.entity.catalog.MerchantCategoriesHistory)it.next();
					%>
					<tr>
					<td>
					<%=DateUtil.formatDate(history.getDateAdded()) %></td>
					<td><%=history.getHistory() %></td>
					</tr>

					<%
				}


				%>
                        </table>


                </fieldset>


                <hr />
            	</div><!-- end main -->

        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>