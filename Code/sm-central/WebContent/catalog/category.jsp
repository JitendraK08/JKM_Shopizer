<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.util.*" %>
<%@ page import = "java.util.Map.Entry" %>
<%@ page import = "com.salesmanager.core.entity.catalog.*" %>
<%@ page import = "com.salesmanager.core.util.*"  %>
<%@ page import = "com.salesmanager.core.service.catalog.*"  %>
<%@ page import = "com.salesmanager.central.profile.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.allcategories" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
	<s:include value="../common/headerinc.jsp"/>

</head>


<body id="categories">

<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">


			<s:fielderror template="smfielderror" />

			<%=MessageUtil.displayMessages(request)%>

				<p>
				<fieldset>
                <legend>
                <s:text name="label.allcategories" />
                <s:if test="%{categoryid>0}">
                &nbsp[<s:property value="%{categoryname}"/>]
                </s:if>
                </legend>






<%

Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);

CatalogService service = new CatalogService();

try {

%>

<table border="0" width="90%">
<tr>
<td valign="top">
<%

LabelUtil label = LabelUtil.getInstance();

String sCategoryId = (String)request.getAttribute("CATEGORYID");
long categoryId = Long.parseLong(sCategoryId);

List categoriespath = CategoryUtil.getCategoryPath(ctx.getLang(),ctx.getMerchantid(),categoryId);
StringBuffer categorypath = new StringBuffer();
categorypath.append("<a href='" + request.getContextPath() + "/catalog/category.action\'>").append(label.getText(request.getLocale(),"label.generic.root")).append("</a>");


if(categoriespath!=null && categoriespath.size() >0) {

	//Collections.reverse(categoriespath);

	Iterator i = categoriespath.iterator();
	while(i.hasNext()) {
		Category c = (Category)i.next();
		categorypath.append(" > ").append("<a href='" + request.getContextPath() + "/catalog/category.action?categoryid="+c.getCategoryId()+"\'>").append(c.getName()).append("</a>");
	}



}


%>

<%=categorypath.toString() %>
</td>
</tr>
</table>
<br>
</td>
</tr>
</table>

<br>




<table width="100%" bgcolor="#ffffe1">
<tr>
<td>
<a href="<%=request.getContextPath()%>/catalog/showeditcategory.action?parentcategoryid=<s:property value="%{categoryid}"/>"><s:text name="label.category.createcategory"/></a>

</td>
</tr>
<s:if test="%{categoryid>0}">
<tr>
<td>
<a href="<s:url action="showeditcategory">
		  <s:param name="categoryid" value="%{categoryid}"/>
		  </s:url>"><s:text name="label.category.categogydetails"/> (<s:property value="%{categoryname}"/>)</a>
</td>
</tr>
<tr>
<td>
<a href="<s:url action="showmovecategory">
		  <s:param name="categoryid" value="%{categoryid}"/>
		  </s:url>"><s:text name="label.category.movecategory"/> (<s:property value="%{categoryname}"/>)</a>
</td>
</tr>
<tr>
<td>
<a href="<%=request.getContextPath()%>/catalog/showcreateproduct.action?categoryId=<s:property value="%{categoryid}"/>"><s:text name="button.label.newproduct"/></a>
</td>
</tr>
</s:if>
</table>


<br><br>


<table border="0" width="90%">
<tr>
<td valign="top">
<%
int maxrows=15;
int currow=0;
Map categs = (Map)request.getAttribute("CATEGORIES");
if(categs!=null) {


%>

<%

	if(categs.size()<maxrows) {
		maxrows = categs.size();
	}
%>


<%

	Iterator categsit = categs.keySet().iterator();
	int categcount = categs.size();
	while(categsit.hasNext()) {

		if( currow==0) {

    %>
		<table>
	<%
		}
	%>
		<tr>
		<td valign="top">

		<%

		Long key = (Long)categsit.next();

		Category categ = (Category)categs.get(key);

		String name = categ.getName();


		if(key!=0) {
		%>


		- <a href="<s:url action="category"/>?categoryid=<%=String.valueOf(categ.getCategoryId())%>"><%=name%></a>


		<%=CategoryUtil.getItemPerCategoryCount(request,ctx.getLang(),categ) %>

		<%

		}
		currow++;
		categcount--;
		%>
		</td>
		</tr>
		<%
		if(currow==maxrows || categcount==0) {
			currow=0;
			%>
			</table></td><td valign="top">
			<%
		}
	}
}

} catch(Exception e) {
	e.printStackTrace();
}

%>

</td>
</tr>
</table>





    </fieldset>

        </div><!-- end content -->
		</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>