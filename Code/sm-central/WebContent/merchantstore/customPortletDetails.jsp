
<%@ include file="../common/specialheader.jsp" %>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import = "com.salesmanager.core.entity.reference.*"  %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%


LabelUtil label = LabelUtil.getInstance();



%>


<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.system.name" /> - <s:text name="label.storefront.customportletdetails" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/common/ckeditor/compatibility.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/common/ckeditor/ckeditor.js"></script> 



    <s:include value="../common/headerinc.jsp"/>


    <s:include value="../common/js/formvalidation.jsp"/>


    <%

    	Collection languages = (Collection)request.getAttribute("languages");

    %>



	</script>


<script type='text/javascript'>
function check_form(form_name) {


	  error = false;
	  error_message_prefix = '<s:text name="messages.errorsoccured" />';
	  var error_message = '';


	  error_message = check_input(error_message,form_name,"label.title", 1, '<s:text name="error.message.storefront.portletidrequired" />');
	  error_message = check_is_numeric(error_message,form_name,"label.sortOrder", '<s:text name="invalid.fieldvalue.sortorder" />');




	  if (error_message != '') {
	    alert(error_message_prefix + '\n' + error_message);
	    return false;
	  } else {
	    submitted = true;
	    return true;
	  }


	return false;
}

</script>




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
                		<s:text name="label.storefront.customportletdetails" />
                        </legend>



			<s:form name="portletpage" action="savePortlet" enctype="multipart/form-data" method="post" theme="simple" onsubmit="return check_form(portletpage);">

				<table class="wwFormTable">


					<tr>
						<td class="tdLabel"><label for="name" class="label">
							<s:text name="label.storefront.portletpageid" />
							<span class="required">*</span>:</label>
						</td>
						<td>
							<s:textfield id="label.title" key="label.title" name="label.title" value="%{label.title}" size="30"/>
						</td>
					</tr>


					<tr>
						<td class="tdLabel"><label for="name" class="label">
							<s:text name="label.storefront.portletposition" />
							<span class="required">*</span>:</label>
						</td>
						<td>
						 <s:select list="portletsPositions" label="%{getText('label.storefront.portletposition')}"
               						value="%{label.position}" name="label.position" required="true"/>					
						</td>
					</tr>


					<tr>
						<td class="tdLabel"><label for="name" class="label">
							<s:text name="label.prodlist.visible" />
							<span class="required">*</span>:</label>
						</td>
						<td>
							<s:checkbox name="label.visible" value="%{label.visible}"/>
						</td>
					</tr>

					<tr>
						<td class="tdLabel"><label for="name" class="label">
							<s:text name="label.generic.sortorder" />
							<span class="required">*</span>:</label>
						</td>
						<td>
							<s:textfield id="label.sortOrder" key="label.sortOrder" name="label.sortOrder" value="%{label.sortOrder}" size="5"/>
						</td>
					</tr>
				


				<s:iterator value="languages" status="lang">



					<tr>
						<td colspan="2" class="tdLabel"><label for="parent" class="label"><s:text name="label.storefront.portletdescription" />&nbsp(<s:property value="code" />):</label></td>
					</tr>
					<tr>
						<td colspan="2"><s:textarea name="descriptions[%{#lang.index}]" id="html%{#lang.index}" cols="50" rows="10" value="%{descriptions[#lang.index]}" label="%{getText('label.storefront.portletdescription')} (%{lang.index})" />
						

						<script type="text/javascript">
						//<![CDATA[

							CKEDITOR.replace('html<s:property value="%{#lang.index}" />',
							{
								skin : 'office2003',
								height:'300', 
								width:'800',
								toolbar : 
								[
									['Source','-','Save','NewPage','Preview'], 
									['Cut','Copy','Paste','PasteText','-','Print'], 
									['Undo','Redo','-','Find','-','SelectAll','RemoveFormat'], '/', 
									['Bold','Italic','Underline','Strike','-','Subscript','Superscript'], 
									['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'], 
									['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'], 
									['Link','Unlink','Anchor'], 
									['Image','Flash','Table','HorizontalRule','SpecialChar','PageBreak'], '/', 
									['Styles','Format','Font','FontSize'], ['TextColor','BGColor'], 
									['Maximize', 'ShowBlocks'] 
									],
								filebrowserBrowseUrl : '<%=request.getContextPath()%>/merchantstore/displayFileBrowser.action',
								filebrowserWindowWidth : '200',
        							filebrowserWindowHeight : '420',
								filebrowserImageBrowseUrl :    '<%=request.getContextPath()%>/merchantstore/displayFileBrowser.action?Type=Images',
								filebrowserFlashBrowseUrl: '<%=request.getContextPath()%>//merchantstore/displayFileBrowser.action?Type=Flash'

							});



						//]]>
						</script>
						</td>
					</tr>

					</s:iterator>

					<s:hidden name="label.dynamicLabelId" value="%{label.dynamicLabelId}" />

					<tr>
						<td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td>
					</tr>
				</table>

				</s:form>
				






		   </fieldset>


            </div><!-- end main -->




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>


