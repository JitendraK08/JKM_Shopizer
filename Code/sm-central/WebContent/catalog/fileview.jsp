<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.salesmanager.central.util.*" %>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
//FileUploadDirective fu = (FileUploadDirective)request.getAttribute("fileuploadderective");
LabelUtil ctxlabel = LabelUtil.getInstance();
%>


<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="%{fileuploadderective.title}" /></title>
    <script type="text/javascript" src='<%=request.getContextPath()%>/common/js/upload.js'> </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/common/js/prototype.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jsProgressBarHandler.js"></script>
    <script src='dwr/interface/UploadMonitor.js'> </script>
    <script src='dwr/interface/ProcessMonitor.js'> </script>
    <script src='dwr/engine.js'> </script>
    <script src='dwr/util.js'> </script>

    <s:include value="../common/headerinc.jsp"/>


    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
         <style type="text/css">


            div.progress-container {
  				border: 1px solid #ccc;
  				width: 100px;
  				margin: 2px 5px 2px 0;
  				padding: 1px;
  				float: left;
  				background: white;
			}

			div.progress-container > div {
  				background-color: #ACE97C;
  				height: 12px
			}



            #processBar { padding-top: 5px; }
            #progressBar { padding-top: 5px; }
            #progressBarBox { width: 350px; height: 20px; border: 1px inset; background: #eee;}
            #progressBarBoxContent { width: 0; height: 20px; border-right: 1px solid #444; background: #9ACB34; }
        </style>
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
                <s:text name="label.product.options.configure.imaganddown" />
                </legend>

				<s:form name="upload" action="uploadproduct" method="post" enctype="multipart/form-data" enctype="multipart/form-data" method="post" onsubmit="startProgress()" theme="simple">



                    <s:hidden name="product.productId" value="%{product.productId}"/>
					<table width="300" border="0">



                    <!-- Virtual -->

     				<tr>
					<td class="tdLabel"><label for="" class="label">&nbsp;</td>
            			<td>&nbsp</td>
     				</tr>


				    <%
						request.setAttribute("fieldname","uploadfile");
						request.setAttribute("filelabel",ctxlabel.getText("label.product.uploadfile"));
						request.setAttribute("virtualfilename","uploadfilename");
						request.setAttribute("subcontext","catalog");
						request.setAttribute("showimage","false");
				        request.setAttribute("paramname","product.productId");
						request.setAttribute("paramvalue",String.valueOf(request.getAttribute("product.productId")));
					%>




					<s:include value="../common/upload.jsp"/>








					<tr><td colspan="2" align="right"><div align="right"><s:submit key="button.label.submit" /></div></td></tr>

					<tr><td colspan="2" align="center">
					<div id="progressBar" style="display: none;">



					<img src="<%=request.getContextPath()%>/common/img/ajax-loader.gif">
					&nbsp;
					<s:text name="label.generic.uploading" />



					</div>
					</div></td></tr>

					</table>

				</s:form>
				</fieldset>

                <hr />
            </div><!-- end main -->


			<s:include value="productleftmenu.jsp"/>

        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->

</body>
</html>