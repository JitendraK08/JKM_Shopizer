<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.salesmanager.core.util.*"  %>
<%@ page import = "com.salesmanager.core.entity.reference.*"  %>
<%@ page import = "java.util.*"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.storefront.portletsconfig" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>




    <s:include value="../common/headerinc.jsp"/>


    <s:include value="../common/js/formvalidation.jsp"/>






</head>


<body id="portlets">

<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">


            <div id="main">

				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
				<p>
                <fieldset>
                <legend>
                <s:text name="label.storefront.portletsconfig" />
                </legend>

			<br><br>
                	<s:form action="saveStoreFrontPortlets" method="post" theme="simple">
					<table class="wwFormTable">


					<tr>
						<td class="tdLabel" colspan="2">
							<s:text name="label.storefront.portletconfigtext" /><br><br>	
						</td>
					</tr>


					<s:iterator value="portlets">

					<tr>
						<td class="tdLabel">
							<s:if test="selectedPortlets[coreModuleName]!=null" >
								<s:checkbox name="selection" fieldValue="%{coreModuleName}" checked="checked"/>
							</s:if>
							<s:else>
								<s:checkbox name="selection" fieldValue="%{coreModuleName}"/>
							</s:else>
						</td>
						<td class="tdLabel">

							<table>
								<tr>
									<td>
										<s:if test="coreModuleServiceConfigurable==true" >
											<a href="#"><b><s:text name="module.%{coreModuleName}" /></b></a>
										</s:if>
										<s:else>
											<b><s:text name="module.%{coreModuleName}" /></b>											
										</s:else>
									</td>
									<td>
										<s:if test="coreModuleServiceConfigurable==true" >
												<s:if test="configuredPortlets[coreModuleName]!=null" >
													<img src="<%=request.getContextPath()%>/common/img/green-check.jpg">
												</s:if>
												<s:else>
													<img src="<%=request.getContextPath()%>/common/img/red-dot.jpg">
												</s:else>
										</s:if>
										<s:else>
											<img src="<%=request.getContextPath()%>/common/img/green-check.jpg">
										</s:else>
									</td>
									<td>
										<s:if test="coreModuleServiceLogoPath!=null && coreModuleServiceLogoPath!=''">
											<s:property value="coreModuleServiceLogoPath" />
										</s:if>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					</s:iterator>

					<tr>
						<td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td>
					</tr>
					</table>
			</s:form>




			<br><br>
			<table width="100%" bgcolor="#ffffe1">
				<tr>
					<td>
						<a href="<s:url action="customPortletDetails"/>"><s:text name="label.storefront.createportlet"/></a>
					</td>
				</tr>
			</table>
			<br><br>

			<s:text name="label.storefront.custome.portletsconfig" />
	
			<br><br>
			<s:form action="updateCustomPortletsList" method="post" theme="simple">


			<table  width="100%" border="1" id="list-table">
				<thead>
               			<tr>
                				<th><s:text name="label.prodlist.visible" /></th>
						<th><s:text name="label.storefront.portletpageid" /></th>
                				<th>&nbsp;</th>
                			</tr>
				</thead>
				
				<tbody>
                			<s:iterator value="customPortlets">
					<tr>
						<td><s:checkbox name="selectionCustomPortlets" fieldValue="%{dynamicLabelId}" value="visible"/></td>
						<td><a href="<%=request.getContextPath() %>/merchantstore/customPortletDetails.action?label.dynamicLabelId=<s:property value="dynamicLabelId" />"><s:property value="title" /></a></td>
						<td>	<a href="<%=request.getContextPath() %>/merchantstore/deleteCustomPortlet.action?label.dynamicLabelId=<s:property value="dynamicLabelId" />" onClick="if (! confirm('<s:text name="messages.delete.entity" />')) return false;">
								<img src="<%=request.getContextPath() %>/common/img/icon_delete.gif" border="0" alt="<s:text name="label.invoice.button.delete" />">
							</a>
						</td>
					</tr>
		   			</s:iterator>

			 	</tbody>
			 	<tfoot>

				</tfoot>


          		</table>

			<s:if test="customPortlets.size>0">

			<table class="wwFormTable">

					<tr>
						<td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td>
					</tr>

			</table>

			</s:if>
			</s:form>


                </fieldset>


                <hr />
            	</div><!-- end main -->

        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>





