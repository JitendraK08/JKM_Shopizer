<%@ page import = "com.salesmanager.core.util.PropertiesUtil"  %>
<%@ page import = "org.apache.commons.configuration.Configuration"  %>          

<%
Configuration conf = PropertiesUtil.getConfiguration();

%>  

	  <div id="footer" class="clearfix">
            <p><b><%=conf.getString("core.systemname")%></b></p>
        </div><!-- end footer -->