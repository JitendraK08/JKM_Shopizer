<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.central.catalog.*" %>
<%@ page import="com.salesmanager.central.profile.*" %>
<%@ page import="com.salesmanager.core.entity.catalog.*" %>
<%@ page import="com.salesmanager.core.entity.reference.*" %>
<%@ page import="com.salesmanager.core.service.cache.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.opensymphony.xwork2.*" %>
<%@ page import="com.opensymphony.xwork2.util.ValueStack" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">



<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.productedit.title" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <s:if test="%{product.productId>0}">
    	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-localleft.css"/>
    </s:if>
    <s:else>
    	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>
    </s:else>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>
    <script type="text/javascript" src="../common/js/calendarDateInput.js"></script>


 	<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.friendurl.min.js"></script>





    <s:include value="../common/headerinc.jsp"/>
    <s:include value="../common/js/formvalidation.jsp"/>
    


	
    


<%

Collection languages = (Collection)request.getAttribute("languages");
LabelUtil label = LabelUtil.getInstance();
label.setLocale(LocaleUtil.getLocale(request));
Context ctx = (Context)request.getSession().getAttribute(ProfileConstants.context);

%>


<script type='text/javascript'>
function check_form(form_name) {


	  error = false;
	  error_message_prefix = '<s:text name="messages.errorsoccured" />';
	  var error_message = '';

	  //check if a category exist
	  if(document.getElementById('categories')==null) {
			error_message = '<s:text name="messages.category.exist" />';
	  }


	  error_message = check_input(error_message,form_name,"price", 1, '<s:text name="error.message.price.format" />');

      <%
        if(languages!=null) {

	   		Iterator langiter = languages.iterator();
	  		int langcount = 0;
       		while(langiter.hasNext()) {
    	  	  	Language lang = (Language)langiter.next();


      %>

		  		error_message = check_input(error_message,form_name,"names[<%=langcount%>]", 1, '<s:text name="error.message.productname.required" /> (<%=lang.getCode()%>)');
		  		error_message = check_input(error_message,form_name,"descriptions[<%=langcount%>]", 1, '<s:text name="error.message.productdesc.required" /> (<%=lang.getCode()%>)');

	  <%
      			langcount++;
	 	 	}
	  	}
	  %>

	  		error_message = check_is_numeric(error_message,form_name,"product.productSortOrder", '<s:text name="invalid.fieldvalue.sortorder" />');
	  		error_message = check_input(error_message,form_name,"weigth", '<s:text name="invalid.fieldvalue.product.productWeight" />');
	  		error_message = check_input(error_message,form_name,"width", '<s:text name="invalid.fieldvalue.product.productWidth" />');
	  		error_message = check_input(error_message,form_name,"length", '<s:text name="invalid.fieldvalue.product.productLength" />');
	  		error_message = check_input(error_message,form_name,"heigth", '<s:text name="invalid.fieldvalue.product.productHeight" />');
	  		error_message = check_is_numeric(error_message,form_name,"product.productQuantity", '<s:text name="invalid.fieldvalue.product.productQuantity" />');
	  		error_message = check_is_numeric(error_message,form_name,"product.productQuantityOrderMax", '<s:text name="invalid.fieldvalue.product.productQuantityOrderMax" />');

	  if (error_message != '') {
	    alert(error_message_prefix + '\n' + error_message);
	    return false;
	  } else {
	    submitted = true;
	    return true;
	  }


	return false;
}



		function limitText(limitField, limitCount, textToModify, limitNum) {
			if (document.getElementById(limitField).value.length > limitNum) {
				document.getElementById(limitField).value = document.getElementById(limitField).value.substring(0, limitNum);
			} else {
				limitCount.value = limitNum - document.getElementById(limitField).value.length;
				newtext = '<s:text name="label.generic.youhave" /> <b>' +  limitCount.value + ' </b><s:text name="label.generic.characters" />';
				document.getElementById(textToModify).innerHTML=newtext;
			}
		}

</script>



	<script type="text/javascript">
	<!--
	$(function(){			
		<s:iterator value="languages" status="lang">
			$('#names<s:property value="#lang.index" />').friendurl({id : 'sefurl<s:property value="#lang.index" />'});
		</s:iterator>
	});
	-->
	</script>



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
                <s:text name="label.productedit.title" />
                </legend>


			<br/>


			<s:if test="%{product.productId>0 && productIsClone==false}">
			<table width="100%">

			<s:iterator value="languages" status="lang">

				<tr>
					<td>
						<font size="-2"><s:text name="label.productedit.producturl" /> (<s:property value="code" />)</font>
					</td>
					<td>
						<font size="-2"><s:property value="productUrl" /><s:property value="%{seo[#lang.index]}" />?request_locale=<s:property value="code" /></font>

					</td>
				</tr>

			</s:iterator>

			<s:if test="productImageUrl!=null">

				<tr>
					<td>
						<font size="-2"><s:text name="label.product.uploadimage" /></font>
					</td>
					<td>
						<font size="-2"><s:property value="productImageUrl" /></font>
					</td>
				</tr>

			</s:if>

			</table>
			<br/>	
			</s:if>

                  <s:action id="refAction" namespace="/ref" name="ref"/>

                  <s:form name="product" action="saveproduct" method="post" enctype="multipart/form-data" onsubmit="return check_form(saveproduct);">



			<s:if test="%{product.productId>0 && productIsClone==false}">
				<tr>
					<td class="tdLabel"><label for="productid" class="label"><s:text name="label.product.productid" />:</label></td>
            			<td><b><s:property value="%{product.productId}"/></b></td>
       			 </tr>
			</s:if>

<!-- Category -->

			<%
				String opt = label.getText("label.productedit.choosecategory");
				request.setAttribute("option1",opt);

			%>

			<tr>
				<td class="tdLabel"><label for="categoryname" class="label"><s:text name="label.productedit.categoryname" /><span class="required">*</span>:</label></td>
            		<td><s:include value="../common/categoriesselectbox.jsp"/></td>
        	</tr>

<!-- Type -->

			<s:select list="#refAction.productTypes" listKey="typeId" listValue="typeName" label="%{getText('label.productedit.producttype')}"
               		value="%{product.productType}" name="product.productType"/>

<!--  Visisble  -->

			<s:checkbox label="%{getText('label.product.visible')}" id="product.productStatus" name="product.productStatus" value="%{product.productStatus}"/>

<!--  Virtual  -->

			<s:checkbox label="%{getText('label.productedit.productvirtual')}" id="product.productVirtual" name="product.productVirtual" value="%{product.productVirtual}"/>



<!--  Availability (calendar)  -->



			<tr>
				<td class="tdLabel"><label for="date" class="label"><s:text name="label.product.availabledate" />:</label></td>
				<td>
				<s:if test="%{availabledate!=null}">
					<script>DateInput('dateavailable', true, 'YYYY-MM-DD','<s:property value="%{availabledate}"/>')</script>
				</s:if>
				<s:else>
					<script>DateInput('dateavailable', true, 'YYYY-MM-DD')</script>
				</s:else>
				</td>
			</tr>

<!-- Price -->


			<s:textfield key="product.price" label="%{getText('label.product.product.onetime.price')}" name="price" value="%{price}" size="6" required="true"/>

<!-- I18N -->


<s:iterator value="languages" status="lang">


					<!-- Product Name -->
					<s:textfield id="names%{#lang.index}" label="%{getText('label.productedit.productname')} (%{code})" name="names[%{#lang.index}]" value="%{names[#lang.index]}" size="30" required="true"/>
					<s:textfield id="sefurl%{#lang.index}" label="%{getText('label.productedit.productseoname')} (%{code})" name="seo[%{#lang.index}]" value="%{seo[#lang.index]}" size="30" readonly="readonly"/>


					<s:textarea id="metadata.highlight" name="highlights[%{#lang.index}]" label="%{getText('label.productedit.producthl')} (%{code})" rows="4" cols="50" value="%{highlights[#lang.index]}"></s:textarea>
					<s:textarea id="metadata.description" name="descriptions[%{#lang.index}]" label="%{getText('label.productedit.productdesc')} (%{code})" rows="4" cols="50" value="%{descriptions[#lang.index]}" required="true"></s:textarea>
					<s:textarea id="metadata.metadescription" name="metadescriptions[%{#lang.index}]" label="%{getText('label.productedit.productseometadesc')} (%{code})" rows="2" cols="50" value="%{metadescriptions[#lang.index]}"></s:textarea>
					<!--<s:textarea id="metadata.metakeywords" name="metakeywords[%{#lang.index}]" label="%{getText('label.productedit.productseometakeywords')} (%{code})" rows="2" cols="50" value="%{metakeywords[#lang.index]}"></s:textarea>-->


					<!--<s:textfield key="metadata.url" label="%{getText('label.productedit.producturl')} (%{code})" name="urls[%{#lang.index}]" value="%{urls[#lang.index]}" size="30"/>-->


</s:iterator>



<!-- Image -->

     <tr>
		<td class="tdLabel"><label for="image" class="label">&nbsp;</td>
            <td>&nbsp</td>
     </tr>


    <%
		request.setAttribute("fieldname","uploadimage");
		request.setAttribute("filelabel",label.getText("label.product.uploadimage"));
		request.setAttribute("subcontext","catalog");
		request.setAttribute("virtualfilename","uploadimagename");
		request.setAttribute("showimage","true");
		request.setAttribute("paramname","product.productId");
		request.setAttribute("paramvalue",String.valueOf(request.getAttribute("product.productId")));

		DynamicImage di = (DynamicImage)request.getAttribute("DYNIMG1");
		request.setAttribute("imagelookupkey","img1");
		request.getSession().setAttribute("img1",di);
	%>

		<!-- Mask to cover the whole screen -->
		<div id="mask"></div>
		<!--</div>-->

		<s:include value="../common/upload.jsp"/>



<!-- Weight -->


	<s:textfield key="weight" label="%{getText('label.product.weight')}" name="weight" value="%{weight}" size="6" required="true"/>

<!-- Width -->


	<s:textfield key="width" label="%{getText('label.product.width')}" name="width" value="%{width}" size="6" required="true"/>


<!-- Length -->


	<s:textfield key="length" label="%{getText('label.product.lenght')}" name="length" value="%{length}" size="6" required="true"/>

<!-- Height -->


	<s:textfield key="height" label="%{getText('label.product.height')}" name="height" value="%{height}" size="6" required="true"/>

<!-- Inventory -->


	<s:textfield key="product.productQuantity" label="%{getText('label.productedit.qtyavailable')}" name="product.productQuantity" value="%{product.productQuantity}" size="6" required="true"/>

<!-- Order max -->


	<s:textfield key="product.productQuantityOrderMax" label="%{getText('label.product.ordermax')}" name="product.productQuantityOrderMax" value="%{product.productQuantityOrderMax}" size="6" required="true"/>

<!-- Sort order -->


	<s:textfield key="product.productSortOrder" label="%{getText('label.product.order')}" name="product.productSortOrder" value="%{product.productSortOrder}" size="3" required="true"/>

<!-- Tax class -->

	<s:select list="taxclass" id="taxclass" listKey="taxClassId" listValue="taxClassTitle" label="%{getText('label.tax.taxclass')}"
               value="%{product.productTaxClassId}" name="product.productTaxClassId" required="true"/>

	<s:submit value="%{getText('button.label.submit')}"/>

			<s:if test="%{product.productId>0 && productIsClone==false}">

                		<s:submit action="deleteproduct" value="%{getText('label.generic.delete')}"/>

               		 <tr>
                			<td colspan="2"><div align="right">
                				<a href="<s:url action="cloneproduct"><s:param name="product.productId" value="%{product.productId}"/></s:url>"><s:text name="button.label.newproductsimilar"/></a>
		    				</div>
					</td>
		    		</tr>

			</s:if>

				<s:if test="%{productIsClone==true}">
					<s:hidden key="product.productId" name="product.productId" value="0"/>
				</s:if>
				<s:else>
					<s:hidden key="product.productId" name="product.productId" value="%{product.productId}"/>
				</s:else>
				<s:hidden key="product.productImage" name="product.productImage" value="%{productImage}"/>
				<s:hidden key="product.productImageLarge" name="product.productImageLarge" value="%{productImageLarge}"/>
			</s:form>

				</fieldset>


                <hr />
            </div><!-- end main -->

			<s:if test="%{product.productId>0 && productIsClone==false}">
				<s:include value="productleftmenu.jsp"/>
			</s:if>




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>


