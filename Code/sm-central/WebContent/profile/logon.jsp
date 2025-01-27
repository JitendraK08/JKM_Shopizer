<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>

<%

response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);

%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>

<%

Locale locale = request.getLocale();

String lang = request.getParameter("lang");

if(!StringUtils.isBlank(lang)) {
	if(lang.equals("fr")) {
		locale = Locale.FRENCH;
	}
}


String errormessage = request.getParameter("error_message");
ResourceBundle bundle = ResourceBundle.getBundle("central", locale);

//System.out.println("******************Logon Box*********************");
//System.out.println(errormessage );
//System.out.println("************************************************");



%>



<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<title><%=bundle.getString("label.system.name")%> - <%=bundle.getString("button.label.logon")%></title>

<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/cookie.js"></script>

<style type=text/css>

body {

	font-size: 11px; background: #ffffff; margin: 20px 0px 0px; line-height: 15px; font-family: Arial, Helvetica, sans-serif;

}

#logon {

	margin: 0px auto; width: 550px

}

#logon .left {

	float: left; margin-bottom: 5px; width: 375px; mergin-height: 20px

}

#logon .right {

	float: left; margin-bottom: 5px; width: 125px

}

#logon input {
		margin-right:20px;
		border:1px solid #999999;
		float:left;
		clear:right;
		background:#f7f7f7;
}
	
#logon input:focus,#logon input:hover {
		border:1px solid #333333;
}

.error{
	color:red;
	font-weight:bold;
}

p {

	padding-bottom: 10px

}

table.logon {

padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px

}

table.logon td {

padding-right: 5px; padding-left: 0px; font-size: 11px; padding-bottom: 5px; line-height: 15px; padding-top: 0px

}


a {

 color: #2c3034

}

a:visited {

 color: #333

}

a:hover {

 color: #015bae

}

a.light {

 color: #999; text-decoration: none

}


h4 {

border-top: #ddd 1px solid; color: #4c555a; padding-top: 20px

}


h2 {

 padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; color: #2c3034; padding-top: 0px; font-family: arial, helvetica, sans-serif

}

h2 {

 padding-right: 0px; padding-left: 0px; font-size: 21px; padding-bottom: 5px; margin: 0px 0px 15px; COLOR: #2c3034; line-height: 21px; padding-top: 0px;   border-bottom: #eee 3px solid; letter-spacing: -1px

}


.bottomlinks {

border-top: #ddd 1px solid; padding-top: 20px

}

.grey {

font-size: 10px; color: #666

}


.left {

 float: left; width: 200px; margin-right: 20px

}

.right {

 float: left; width: 605px

}


.clr {

 clear: both

}

</style>

<script language="javascript">

  function toggleDiv(divid,display){
	document.getElementById(divid).style.display = display;
  }


  function check_form(form_name) {

	  error = false;
	  var error_message = '';


	    if (form_name.elements['username'].value == '' || form_name.elements['username'].value < 1 || form_name.elements['password'].value == '' || form_name.elements['password'].value < 1) {
	      error_message = "* " +  '<%=bundle.getString("label.logonform")%>' + "\n";
	    }


	  if (error_message != '') {
	    alert(error_message);
	    return false;
	  } else {
	    submitted = true;
	    return true;
	  }
}


</script>
</script>




</head>

<body>


<br><br>

<div id=logon>






	<div class=left>

	<h2><%=bundle.getString("button.label.logon")%></h2>

	<form id="loginform" method="post" action="<%=request.getContextPath()%>/profile/logon.action" onSubmit="return check_form(loginform);">

	<table class=logon cellSpacing=0 cellPadding=0>

	<tbody>
	<tr>
		<td colspan="2">
							<%
							if(!StringUtils.isBlank(errormessage)) {
							%>

									<p><b><font color="red"><%=errormessage %></font></b></p>

							<%
							}
							%>

		</td>
	</tr>


	<tr>

		<td align=right width="30%">
			<b><%=bundle.getString("username") %>:</b>
		</td>

		<td width="70%">
			<input type="text" name="username" tabindex="1" id="username" />
		</td>
	</tr>

	<tr>
		<td align=right>
			<b><%=bundle.getString("password") %>:</b>
		</td>

		<td>
			<input type="password" name="password" tabindex="2" id="password" />
		</td>
	</tr>



	<tr>

		<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 15px; padding-top: 0px">&nbsp;</td>

		<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 15px; padding-top: 0px">

			<div>

				<div class=button>
					<input name="Submit" type="submit" id="submit" tabindex="4" value="<%=bundle.getString("button.label.logon") %>" />
				</div>
			</div>

			<div class=clr></div>
		</td>
	</tr>

</tbody>

</table>

</form>

	</div><!-- left -->



	<div class=right>

	<p>

		<a title="" href="">

			<img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" alt="go to www.shopizer.com" src="<%=request.getContextPath()%>/common/img/shopizer_small.jpg">
		</a>

	</p>

	<p style="padding-top: 25px">

		<a href="javascript:toggleDiv('lostpassword','block');return false;"><s:text name="customer.lost.password"/></a></p>

	</div><!--right-->


	<div class=clr></div>

	<div class=bottomlinks id=lostpassword style="display:none">

	<div class=left>
		<form id="lost_password_form" name="login" action="<%=request.getContextPath()%>/sendLogonInformation.action" method=post>


		<table class=logon cellSpacing=0 cellPadding=0>

			<tbody>
				<tr>
					<td colspan="2">

					</td>

				<tr>

					<td align=right width="20%"><b><s:text name="username"/>:</b></td>

					<td width="80%"><input type="text" name="username" tabindex="1" id="username" /></td>

				</tr>

				<tr>

				<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 15px; padding-top: 0px">&nbsp;</td>

				<td style="padding-right: 0px; padding-left: 0px; padding-bottom: 15px; padding-top: 0px">

					<div>

						<div class=button>
							<input class="submitbutton" type="submit" value="<s:text name="button.label.logon"/>"   name="sign_in_submit">
						</div>
					</div>

					<div class=clr></div>
				</td>


				</tr>

			</tbody>

		</table>

	</form>

	</div><!-- right -->







</div><!-- / login container-->


</body>
</html>

