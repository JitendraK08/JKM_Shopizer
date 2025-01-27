<%@ page import = "java.util.Locale" %>
<%@ page import = "com.salesmanager.core.constants.Constants" %>
<%

response.setCharacterEncoding("UTF-8");//@todo, create a filter that will set this in each request

%>
<%@taglib prefix="s" uri="/struts-tags" %>
        <div id="header" class="clearfix">


            <div id="branding">
			<img src="<%=request.getContextPath()%>/common/img/shopizer_small.jpg">
            </div><!-- end branding -->
		&nbsp;&nbsp;

		
		<div id="search">
					<table border="0" width="100%">
					<tr>
						<td align="right">
							<b><font color="black">
							<s:if test="locale.language=='fr'">

								<a href="<%=request.getContextPath()%>/profile/changeLanguage.action?lang=en"><s:text name="label.language.en" /></a>

							</s:if>
							<s:else>
								<a href="<%=request.getContextPath()%>/profile/changeLanguage.action?lang=fr"><s:text name="label.language.fr" /></a>
							</s:else>
							</font></b> |
						&nbsp;<b><font color="black">
						<a href="<%=request.getContextPath()%>/profile/logout.action"><s:text name="button.label.logout"/></a>
						</font></b></td>
					</tr>
					</table>
            </div>
		

	  <center>
	  <div style="align:center;margin-top:75px;">
		<table>
			<tr><td>
			<s:include value="../common/menu.jsp"/>
	  		</td></tr>
		</table>
	  </div>
	  </center>

        </div><!-- end header -->



