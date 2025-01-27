<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.catalog.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.entity.catalog.*" %>
<%@ page import="com.salesmanager.central.entity.reference.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">



<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.product.productprices.discount" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
    <script type="text/javascript" src="../common/js/calendarDateInput.js"></script>

    <s:include value="../common/headerinc.jsp"/>


    <s:include value="../common/js/formvalidation.jsp"/>

   	<script type='text/javascript'>



function check_discount(form_name) {

	  error = false;
	  error_message_prefix = '<s:text name="messages.errorsoccured" />';
	  var error_message = '';



	  error_message = check_input(error_message,form_name,"productNewPrice", 1, '<s:text name="error.message.price.required" />');

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
                <s:text name="label.product.productprices.discount" />
                </legend>

                <s:form name="discount" action="editproductpricediscount" onsubmit="return check_discount(discount);" method="post" enctype="multipart/form-data">


                <s:hidden name="product.productId" value="%{product.productId}"/>
                <s:hidden name="price.productPriceId" value="%{price.productPriceId}"/>

                <tr>
					<td class="tdLabel"><label for="pn" class="label"><s:text name="label.productedit.productname" />:</label></td>
            		<td><b><s:property value="%{productName}"/></b></td>
    			</tr>

    			<tr>
					<td class="tdLabel"><label for="pp" class="label"><s:text name="label.generic.price" />:</label></td>
            		<td><b><s:property value="%{productPrice}"/></b></td>
    			</tr>

    			<s:textfield id="productNewPrice" key="productNewPrice" label="%{getText('label.product.discountprice')}" name="productNewPrice" value="%{productNewPrice}" size="6" required="true"/>


    			<!--  Start Date(calendar)  -->

				<%
				    String sdate = (String)request.getAttribute("sdate");
				%>

				<tr>
					<td class="tdLabel"><label for="date" class="label"><s:text name="label.generic.startdate" />:</label></td>
					<td>
					<s:if test="%{sdate!=null}">
					<script>DateInput('dstartdate', true, 'YYYY-MM-DD','<s:property value="%{sdate}"/>')</script>
					</s:if>
					<s:else>
					<script>DateInput('dstartdate', true, 'YYYY-MM-DD')</script>
					</s:else>
					</td>
				</tr>

				 <!--  End Date(calendar)  -->


				<tr>

					<td class="tdLabel"><label for="date" class="label"><s:text name="label.generic.enddate" />:</label></td>
					<td>
					<s:if test="%{edate!=null}">
					<script>DateInput('denddate', true, 'YYYY-MM-DD','<s:property value="%{edate}"/>')</script>
					</s:if>
					<s:else>
					<script>DateInput('denddate', true, 'YYYY-MM-DD')</script>
					</s:else>
					</td>

				</tr>

				<tr>
					<td class="tdLabel" bgcolor="#ffffe1" colspan="2"><center><label for="or" class="label"><b><s:text name="label.generic.or" /></b></label></center></td>
				</tr>



					<s:select list="%{days}" id="day" label="%{getText('label.product.productprices.discount.numberofdays')}"
               			value="%{day}" name="day"/>



                <s:submit value="%{getText('button.label.submit')}"/>
                <s:submit action="deletepricediscount" value="%{getText('label.generic.delete')}"/>

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