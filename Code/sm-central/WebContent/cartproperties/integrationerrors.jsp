	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.core.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.shoppingcartproperties.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

<s:include value="../common/headerinc.jsp"/>



</head>



<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">

            <div id="main">


			<s:fielderror template="smfielderror" />


				<%=MessageUtil.displayMessages(request)%>
				<p>
				<fieldset>
                <legend>
                <s:text name="label.shoppingcartproperties.title" />
                </legend>

                <table width="100%">
                <tr>
                <td><b><s:text name="label.generic.date" /></b></td>
                <td><b><s:text name="label.integrationerror.description" /></b></td>
                </tr>

                <s:iterator value="integrationerrors">

                <tr>
					<td><s:property value="dateAddedString" /></td>
					<td><s:property value="centralIntegrationErrorDescription" /></td>
				</tr>

				</s:iterator>
				</table>

				</fieldset>

        </div><!-- end content -->
		</div>

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->

</body>
</html>
