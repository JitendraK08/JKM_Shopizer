<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.salesmanager.core.util.*"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.category.editcategory" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

	<s:include value="../common/headerinc.jsp"/>


</head>


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
                <s:text name="label.category.editcategory" />
                </legend>


                	<s:form action="savemovecategory" method="post" theme="simple">
					<table class="wwFormTable">


					<s:iterator value="languages" status="lang">


					<tr>
					<td class="tdLabel"><label for="name" class="label">
					<s:text name="label.productedit.categoryname" />

					&nbsp(<s:property value="code" />)<span class="required">*</span>:</label></td>
					<td>
					<s:property value="%{names[#lang.index]}"/>
					<s:hidden key="category.name" name="names[%{#lang.index}]" value="%{names[#lang.index]}"/>
					</td>
					</tr>


					<tr>
					<td class="tdLabel"><label for="description" class="label">
					<s:text name="label.category.categorydescription" />

					&nbsp(<s:property value="code" />):</label></td>
					<td>
					<s:property value="%{descriptions[#lang.index]}" escape="false"/>
					<s:hidden key="category.description" name="descriptions[%{#lang.index}]" value="%{descriptions[#lang.index]}"/>
					</td>
					</tr>



					</s:iterator>

					<%



					%>

					<tr>
						<td class="tdLabel"><label for="categoryname" class="label"><s:text name="label.category.moveundercategory" /><span class="required">*</span>:</label></td>
			            <td><s:include value="../common/categoriesselectbox.jsp"/></td>
			        </tr>




					<s:hidden key="category.parentId" name="category.parentId" value="%{category.parentId}"/>
					<s:hidden key="action" name="action" value="0"/>
					<s:hidden key="category.sortOrder" name="category.sortOrder" value="%{category.sortOrder}"/>
					<s:hidden key="category.visible" name="category.visible" value="%{category.visible}"/>
					<s:hidden key="category.categoryId" name="category.categoryId" value="%{category.categoryId}"/>
					<tr><td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td></tr>
					</table>
					</s:form>


                </fieldset>


                <hr />
            	</div><!-- end main -->

        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>