<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />


<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.central.payment.*" %>
<%@ page import="com.salesmanager.central.entity.reference.*" %>
<%@ page import="java.util.*" %>
<%@taglib prefix="s" uri="/struts-tags" %>


<%

Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);
LabelUtil ctxlabel = LabelUtil.getInstance();
FileUploadDirective fu = (FileUploadDirective)request.getAttribute("fileuploadderective");

%>



<!-- Virtual -->

     <tr>
		<td class="tdLabel"><label for="price" class="label">&nbsp;</td>
            <td>&nbsp</td>
     </tr>


    <%
		request.setAttribute("fieldname","uploadfile");
		request.setAttribute("filelabel",ctxlabel.getText("label.product.uploadfile"));
		request.setAttribute("virtualfilename","uploadfilename");
		request.setAttribute("subcontext","catalog");
		request.setAttribute("showimage","false");
        request.setAttribute("pid",String.valueOf(fu.getProductid()));
	%>


		<%
		String classlabel = "label";
		String message = MessageUtil.displayFormErrorMessage(request,"uploadfile");
		if(message!=null && !message.equals("")) {
			classlabel = "errorLabel";
			request.setAttribute("errorfile",classlabel);
		%>
			<%=message %>
		<%
		}
		%>

		<s:include value="../common/upload.jsp"/>

