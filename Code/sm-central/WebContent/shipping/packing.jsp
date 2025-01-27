<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.salesmanager.central.shipping.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.shipping.packing.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
     <s:include value="../common/headerinc.jsp"/>
</head>

<body id="page-home">

    <div id="page">

	  <s:include value="../common/header.jsp"/>


        <div id="content" class="clearfix">


           <div id="main">
               <s:actionerror template="smactionerror" />
				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>

				<fieldset>
                <legend>
                <s:text name="label.shipping.packing.title" />
                </legend>


				<s:form name="packing" action="/shipping/editPacking.action" theme="simple" method="post">

					<table id="packing" width="75%">

					<!--iterate through packing modules-->

					<s:iterator value="services">


					<tr>
					<td class="tdLabel">
						<label for="packingType" class="label">
							<s:property value="description" />
						</label>
					</td>
					<td class="tdLabel">
						<s:if test="coreModuleName == moduleSelected">
						<input type="radio"  id="selectedPacking" name="service.coreModuleName" value="<s:property value="coreModuleName"/>" checked>
						</s:if>
						<s:else>
						<input type="radio"  id="selectedPacking" name="service.coreModuleName" value="<s:property value="coreModuleName"/>">
						</s:else>
					   </td>
					</tr>




					<s:if test="pageInformation[coreModuleName]!= null">
						<s:include value="%{pageInformation[coreModuleName]}"/>
					</s:if>



					</s:iterator>



					<tr><td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td></tr>


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