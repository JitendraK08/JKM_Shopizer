	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><s:text name="label.menu.group.store" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>

    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UpdateZones.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>

  <s:include value="../common/headerinc.jsp"/>

<s:include value="../common/js/formvalidation.jsp"/><!--ie does not see that script ... -->


<%

Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);
int langId = LanguageUtil.getLanguageNumberCode(ctx.getLang());

%>


<script type='text/javascript'>

	  //per form defined values
        var formtableid = 'mainform';//The id of the table surrounding the form
	  var statesfieldlabel = '<s:text name="label.state" /><span class="required">*</span>:';//The label in the first <td>LABEL</td><td>FORM FIELD</td>
	  var statesfielddefaultvalue = '<s:property value="merchantUserInfo.userstate" />';//The default state value when using a text field <td>LABEL</td><td>FORM FIELD [default value]</td>
	  var statesfieldname = 'merchantUserInfo.userstate';
	  var statesfieldindex = 9;
	  var langId = <%=langId%>;



	function setcountry() {

	   var country = document.getElementById('country').value;
	   UpdateZones.updateZones(country,langId,updateZones);
	}

	function updateZones(data) {
		if(data.length==0) {
			removeBlock();
			var value = statesfielddefaultvalue;
			if(IsNumeric(value)) {
				value = '';
			}
			var acell = '<label for=\"state\"class=\"label\">' + statesfieldlabel + ':</label>';
			var bcell = '<input type=\"text\"  id=\"states\" name=\"' + statesfieldname + '\" size=\"40\" value=\"' + value + '\"/>';
	            addBlock(acell,bcell);
			document.getElementById('formstate').value = 'text';
	      } else {
	        	var fstate = document.getElementById('formstate').value;
	            if(fstate=='text') {//reset options
					removeBlock();
					var acell = '<label for=\"state\" class=\"label\">' + statesfieldlabel + ':</label>';
					var bcell = '<select name=\"' + statesfieldname + '\" id="states"><option value="-1">---</option></select>';
					addBlock(acell,bcell);
					document.getElementById('formstate').value = 'list';

				}
	          	DWRUtil.removeAllOptions('states');
		  		DWRUtil.addOptions('states',data,'zoneId','zoneName');
	            var el=document.getElementById("states")
			   	var found = 0;


			      for(var i=0;i<el.options.length;i++){

				 	if(el.options[i].value==statesfielddefaultvalue) {

	                			document.getElementById('states').selectedIndex=i;
						found = 1;
						break
					}
			      }
			    if(found==0) {
				document.getElementById('states').selectedIndex=0;
			 }

	      }

	}


	function deleteAction(){
		<s:if test="#request.savedMerchantId != null">
			window.location = '<%=request.getContextPath()%>/merchantstore/deleteMerchantStore.action?merchantId='+<s:property value="#request.savedMerchantId"/>;
		</s:if>
	}

	function removeBlock() {
		  var table = document.getElementById(formtableid);
	        table.deleteRow(statesfieldindex);
	}

	function addBlock(acell,bcell) {
	            var newtable=document.getElementById(formtableid);
	            var row = newtable.insertRow(statesfieldindex);
			var a=row.insertCell(0);
	            var b=row.insertCell(1);
			a.innerHTML=acell;
			b.innerHTML=bcell;
	}

		function IsNumeric(sText) {
			var ValidChars = "0123456789.";
			var IsNumber=true;
			var Char;
		 	for (i = 0; i < sText.length && IsNumber == true; i++) {
				Char = sText.charAt(i);
			 	if (ValidChars.indexOf(Char) == -1) {
					IsNumber = false;
			 	}
		 	}
		 	return IsNumber;

		}

		function check_form() {
			if(!IsNumeric(statesfielddefaultvalue)) {
					removeBlock();
					var acell = '<label for=\"state\" class=\"label\">' + statesfieldlabel + ':</label>';
					var bcell = '<input type=\"text\" id=\"states\" name=\"' + statesfieldname + '\" size=\"40\" value=\"'+ statesfielddefaultvalue + '\"/>';
					addBlock(acell,bcell);
					document.getElementById('formstate').value = 'text';
			}
		}

</script>


</head>


<body id="profile" onload="check_form()">
<div id="page">

	  <s:include value="../common/header.jsp"/>
        <div id="content" class="clearfix">

            <div id="main">
<s:actionerror template="smactionerror"/>
<s:fielderror template="smfielderror"/>
<s:actionmessage/>

	<%=MessageUtil.displayMessages(request)%>
		<fieldset>
		<legend>
			<s:text name="label.menu.group.merchant.store.information" />
        </legend>
 <s:action id="refAction" namespace="/ref" name="ref"/>
 <form name="merchant" action="<%=request.getContextPath() %>/merchantstore/saveMerchantStore.action" method="post">
<table class="wwFormTable" id="mainform" >

	<tr>
	<td class="tdLabel"><s:text name="label.merchant.view.storename" /></td>
	<td><b><s:property value="merchantStore.storename" /></b></td>
	</tr>
    <s:textfield name="merchantUserInfo.adminName" value="%{merchantUserInfo.adminName}" label="%{getText('username')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.adminEmail" value="%{merchantUserInfo.adminEmail}" label="%{getText('label.adminemail')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.userfname" value="%{merchantUserInfo.userfname}" label="%{getText('label.userfname')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.userlname" value="%{merchantUserInfo.userlname}" label="%{getText('label.userlname')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.userphone" value="%{merchantUserInfo.userphone}" label="%{getText('label.userphone')}" size="40" required="true" />
    <s:textfield name="merchantUserInfo.useraddress" value="%{merchantUserInfo.useraddress}" label="%{getText('label.address')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.usercity" value="%{merchantUserInfo.usercity}" label="%{getText('label.city')}" size="40" required="true"/>
    <s:textfield name="merchantUserInfo.userpostalcode" value="%{merchantUserInfo.userpostalcode}" label="%{getText('label.postalcode')}" size="40" required="true"/>
    <s:select list="zones" id="states" listKey="zoneId" listValue="zoneName" label="%{getText('label.state')}"
               value="%{merchantUserInfo.userstate}" name="merchantUserInfo.userstate" required="true"/>
    <s:select list="countries" id="country" listKey="countryId" listValue="countryName" label="%{getText('label.country')}"
               value="%{merchantUserInfo.usercountrycode}" name="merchantUserInfo.usercountrycode"  onchange="javascript:setcountry()" required="true"/>
    <s:select list="#refAction.languages" listKey="code" listValue="name" label="%{getText('label.userlang')}"
               value="%{merchantUserInfo.userlang}" name="merchantUserInfo.userlang" required="true"/>
	<s:select list="%{merchantRegistrationDefCodes}" label="%{getText('label.merchant.reg.def.code')}"
               value="%{merchantRegistration.merchantRegistrationDefCode}" name="merchantRegistration.merchantRegistrationDefCode" required="true"/>
     <input type="hidden" name="formstate" value="list" id="formstate">
     <input type="hidden" name="merchantUserInfo.merchantId" value='<s:property value="#request.savedMerchantId"/>'/>
     <input type="hidden" name="merchantUserInfo.merchantUserId" value='<s:property value="#request.savedmerchantUserId"/>'/>
    <s:submit value="%{getText('button.label.submit')}"/>
	<s:if test="#request.savedMerchantId != null">
 <tr>
    <td colspan="2"><div align="right"><input type="button" value="<s:text name="label.generic.delete" />" onClick="deleteAction()"/>
	</div>
	</td>
</tr>

	</s:if>
</table>
 </fieldset>
</div>
</div>
<s:include value="../common/footer.jsp"/>
</div>
</body>
</html>
