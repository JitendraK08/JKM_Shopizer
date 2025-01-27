	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.web.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.branding.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

<s:include value="../common/headerinc.jsp"/>


<s:include value="../common/js/formvalidation.jsp"/><!--ie does not see that script ... -->

<%

LabelUtil label = LabelUtil.getInstance();
%>

<script type='text/javascript'>



function check_cart(form_name) {

	  error = false;
	  error_message_prefix = '<s:text name="messages.errorsoccured" />';
	  var error_message = '';

	  
	  if (error_message != '') {
	    alert(error_message_prefix + '\n' + error_message);
	    return false;
	  } else {
	    submitted = true;
	    return true;
	  }
}
</script>



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
                <s:text name="label.branding.title" />
                </legend>


    <s:action id="refAction" namespace="/ref" name="ref"/>


    <s:form action="savecart" method="POST" enctype="multipart/form-data" onsubmit="return check_cart(savecart);">


    <s:textfield name="merchantStore.continueshoppingurl" value="%{merchantStore.continueshoppingurl}" label="%{getText('label.continueshoppingurl')}" size="40"/>


        <%
		//input text name
		request.setAttribute("fieldname","uploadlogo");
		//field label
		request.setAttribute("filelabel",label.getText("file.logo.label"));
		//will build request using request.getContextPath() + subcontext if any defined
		request.setAttribute("subcontext","cartproperties");


		DynamicImage di2 = (DynamicImage)request.getAttribute("LOGO");
		if(di2!=null) {
			//under which name will it be retreived

			request.setAttribute("imagelookupkey","logo");
			//need the image in the http session, it will be removed once consumed
			request.getSession().setAttribute("logo",di2);
			//need to have a struts action delete_file
			//This is the name of the item displayed. If no virtualfilename, then assume the upload box is shown
			request.setAttribute("virtualfilename","logo");
			request.setAttribute("logo", di2.getImageName());
			//displays the image or not
                  request.setAttribute("imagewidth","200");
			request.setAttribute("showimage","true");
	    	      request.setAttribute("paramname","imageId");
			request.setAttribute("paramvalue","1");

		}
	%>

     <s:include value="../common/upload.jsp"/>



    <%
		//input text name
		request.setAttribute("fieldname","uploadbanner");
		//field label
		request.setAttribute("filelabel",label.getText("label.storebanner"));
		//will build request using request.getContextPath() + subcontext if any defined
		request.setAttribute("subcontext","cartproperties");


		DynamicImage di = (DynamicImage)request.getAttribute("BANNER");
		if(di!=null) {
			//under which name will it be retreived

			request.setAttribute("imagelookupkey","banner");
			//need the image in the http session, it will be removed once consumed
			request.getSession().setAttribute("banner",di);
			//need to have a struts action delete_file
			//This is the name of the item displayed. If no virtualfilename, then assume the upload box is shown
			request.setAttribute("virtualfilename","banner");
			request.setAttribute("banner", di.getImageName());
			//displays the image or not
			request.setAttribute("showimage","true");
                  request.setAttribute("imagewidth","200");
                  request.setAttribute("imageheight","50");
	    	      request.setAttribute("paramname","imageId");
			request.setAttribute("paramvalue","0");
		}
	%>

     <s:include value="../common/upload.jsp"/>


         <s:select list="languages" listKey="code" listValue="description" label="%{getText('label.storefront.defaultlanguage')}"
               value="%{merchantStore.defaultLang}" name="merchantStore.defaultLang" required="true"/>



	   <s:submit value="%{getText('button.label.submit')}"/>



    </s:form>
    </fieldset>

        </div><!-- end content -->
		</div>

        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->

</body>
</html>

