
<%@ include file="../common/specialheader.jsp" %>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%


LabelUtil label = LabelUtil.getInstance();



%>


<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.system.name" /> - <s:text name="label.storefront.contentsectionlist" /></title>
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
				<s:actionerror/>
				<s:actionmessage/>
				<s:fielderror />
				<%=MessageUtil.displayMessages(request)%>
				<p>
                		<fieldset>
                		<legend>
                		<s:text name="label.storefront.contentsectionlist" />
                        </legend>

<table width="100%" bgcolor="#ffffe1">
<tr>
	<td>
		<a href="<s:url action="pageContentDetails"/>"><s:text name="label.storefront.createcontentsection"/></a>
	</td>
</tr>
</table>
<br>
<br>

			<s:form name="storePageList" action="updateStoreContentList" theme="simple">
						               
			<table  width="100%" border="1" id="list-table">
				<thead>
               			<tr>
                				<th><s:text name="label.prodlist.visible" /></th>
						<th><s:text name="label.storefront.contentsectionid" /></th>
						<th><s:text name="label.storefront.contentsectiontitle" /></th>
                				<th>&nbsp;</th>
                			</tr>
				</thead>
				
				<tbody>
                			<s:iterator value="pages">
					<tr>
						<td><s:checkbox name="visible" fieldValue="%{dynamicLabelId}" value="visible"/></td>
						<td><s:property value="dynamicLabelId" /></td>
						<td><a href="<%=request.getContextPath() %>/merchantstore/pageContentDetails.action?label.dynamicLabelId=<s:property value="dynamicLabelId" />"><s:property value="title" /></a></td>
						<td>	<a href="<%=request.getContextPath() %>/merchantstore/deletePageContent.action?label.dynamicLabelId=<s:property value="dynamicLabelId" />" onClick="if (! confirm('<s:text name="messages.delete.entity" />')) return false;">
								<img src="<%=request.getContextPath() %>/common/img/icon_delete.gif" border="0" alt="<s:text name="label.invoice.button.delete" />">
							</a>
						</td>
					</tr>
		   			</s:iterator>

			 	</tbody>
			 	<tfoot>

				</tfoot>


          		</table>

			<s:if test="pages.size>0">

			<table class="wwFormTable">

					<tr>
						<td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td>
					</tr>

			</table>

			</s:if>
	
			</s:form>



		   </fieldset>


            </div><!-- end main -->




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>



