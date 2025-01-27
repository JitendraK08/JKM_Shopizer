	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.media.binmanagement" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>



	<!-- links from headerinc.jsp -->
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/dropdown.css"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/hoverIntent.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/stuHover.js"></script>


	<script src="<%=request.getContextPath()%>/common/js/jqueryFileTree.js" type="text/javascript"></script>
      <script src="<%=request.getContextPath()%>/common/js/screenshot.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/common/styles/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />




		<style type="text/css">
	
			.container {
				width: 340px;
				height: 280px;
				border-top: solid 1px #BBB;
				border-left: solid 1px #BBB;
				border-bottom: solid 1px #FFF;
				border-right: solid 1px #FFF;
				background: #FFF;
				overflow: scroll;
				padding: 5px;
			}
			

		 .dropHover 
     {
	 		 border:dashed 2px black;
     } 
     
     #screenshot
     {
			position:absolute;
			border:1px solid #ccc;
			background:#333;
			padding:5px;
			display:none;
			color:#fff;
	}
     
    
		</style>



<script language="javascript">


/** enable page items **/
function start() {

	screenshotPreview();
}	

<% 
	Integer merchantid = (Integer)request.getSession().getAttribute(ProfileConstants.merchant);
	String dirPath =  FileUtil.getFileTreeBinPath();
	String serverBinUrl = FileUtil.getBinServerUrl(merchantid,true);
%>

//var selectedFile ="";
function loadFileTree() {
	$('#fileTree').fileTree({ root: '<%=dirPath%>', script: '<%=request.getContextPath()%>/common/fileTree.jsp?isMediaBin=true&serverUrl=<%=serverBinUrl%>', loadedCallBack: 'start()'}, function(file) { selectedFile = file});
}

function deleteFile(selectedFile){
	if(selectedFile != ""){
		if(confirm('<s:text name="messages.delete.file" />')){
			$('#deleteFilePath').val(selectedFile);
			$('#deleteForm').submit();
		}
	}
}
	
	
$(document).ready(function()	{
	loadFileTree();
});
</script>




</head>


<body id="mediabin">






		<div id="page">



	  		<s:include value="../common/header.jsp"/>


        		<div id="content" class="clearfix">

            	<div id="main">





<fieldset>

<legend>
	<s:text name="label.media.bin" />
</legend></p>


 <table>
	<tr>
		<td colspan="2">
		            <s:actionerror template="smactionerror" />
				<s:fielderror template="smfielderror" />
				<%=MessageUtil.displayMessages(request)%>
		</td>
	</tr>
	<tr>
		<td>
			<div id="fileTree" class="container"></div>
		</td>
		<td valign="top">
							<img id="loading" src="<%=request.getContextPath()%>/common/img/loading.gif" style="display:none;"> 
							<br />	
							<s:form action="binAdd" method="POST" enctype="multipart/form-data" onsubmit="startProgress()">
							<s:text name="label.bin.upload"/>:<input type="file" id="upload" name="upload" value=''/>&nbsp;<input type="submit" value='<s:text name="label.upload.submit"/>'/>
							</s:form> 
		</td>

	</tr>
	
</table>
<form id="deleteForm" action="<%=request.getContextPath()%>/merchantstore/binDelete.action" method="POST">
	<input type="hidden" id="deleteFilePath" name="deleteFilePath" />
</form>
</fieldset




			</div><!-- end main -->
		</div><!-- end content -->
<s:include value="../common/footer.jsp"/>
</div><!-- end page -->
</body>
</html>





