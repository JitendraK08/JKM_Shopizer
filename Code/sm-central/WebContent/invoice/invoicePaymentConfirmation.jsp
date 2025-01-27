


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.salesmanager.central.entity.reference.*" %>
<%@ page import="com.salesmanager.central.entity.payment.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">





<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><s:text name="label.system.name" /> - <s:text name="label.invoice.button.payment" /></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col.css"/>

</head>


<s:include value="../common/headerinc.jsp"/>



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
                		<s:text name="label.invoice.button.payment" />
                        </legend>



                        <!-- Invoice details -->
                        <table>
                        <tr>
                        	<td><b><s:text name="label.invoice.invoiceid" />:</b></td>
                        	<td><b><s:property value="order.orderId" /></b></td>
                        </tr>
                        <tr>
                        	<td><s:text name="label.customer.name" />:</td>
                        	<td><s:property value="order.customerName" /></td>
                        </tr>
                        <tr>
                        	<td><s:text name="label.invoice.invoicetotal" />:</td>
                        	<td><s:property value="order.orderTotalText" /></td>
                        </tr>

                        </table>


			
<s:if test="#request.ANALYTICS!=null && #request.ANALYTICS!=''">


<script type="text/javascript">
//<![CDATA[ 
  	var _gaq = _gaq || [];
  	_gaq.push(['_setAccount', '<s:property value="#request.ANALYTICS" escape="false"/>']);
  	_gaq.push(['_trackPageview']);

  	(function() {
    		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  	})();




	if(_gaq) {

	_gaq.push(['_trackPageview']);
	_gaq.push(['_addTrans', 
		'<s:property value="order.orderId" />', // order ID - required 
		'<s:property value="store.storename" />', //Store Name
	      '<s:property value="order.orderTotalTextNoCurrency" />',  // total - required
		'<s:property value="order.orderTotalTaxTextNoCurrency" />',  // tax 
		<s:if test="shippingTotal!=null">
		'<s:property value="shippingTotal" />', // shipping 
		</s:if>
		<s:else>
		'',
		</s:else>
		'<s:property value="order.customerCity" />', // city 
		'<s:property value="order.customerState" />', // state or province 
		'<s:property value="order.customerCountry" />' // country
		 ]);


	<s:iterator value="order.orderProducts"> 

	_gaq.push(['_addItem', 
		'<s:property value="orderId" />', // order ID - required 
		'<s:property value="productId" />', // SKU/code - required 
		'<s:property value="productName" />', // product name 
		<s:if test="attributesLine!=null">
		'Green Medium', // category or variation
		</s:if>
		<s:else>
		'',
		</s:else> 
		'<s:property value="unitPriceNoCurrency" />', // unit price - required 
		'<s:property value="productQuantity" />' // quantity - required 
		]); 

	</s:iterator>

	_gaq.push(['_trackTrans']); //submits transaction to the Analytics servers 

	}


	//]]> 
</script>

</s:if>





		   </fieldset>


            </div><!-- end main -->




        </div><!-- end content -->


        <s:include value="../common/footer.jsp"/>

    </div><!-- end page -->




</body>
</html>