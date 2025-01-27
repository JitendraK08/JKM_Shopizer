<%@ taglib uri="/WEB-INF/classes/sm-catalog.tld" prefix="sm" %>		
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.salesmanager.common.util.UrlUtil" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.salesmanager.core.entity.merchant.MerchantStore" %>
<%@ page import = "com.salesmanager.core.util.ReferenceUtil" %>


<script type='text/javascript'>
//<![CDATA[ 


<%
MerchantStore store = (MerchantStore)request.getSession().getAttribute("STORE");
%>


/** variables **/
var LOGIN_URL ='<%=ReferenceUtil.buildRemoteLogonUrl(store)%>';
var LOGOUT_URL ='<sm:url scheme="http" namespace="/profile" action="logout" />';
var SUCCESS_CODE=1;
var FAILURE_CODE=-1;
var DELIMITER=",";


/** shopping cart **/



jQuery(document).ready(function(){

	
	/** add to cart init **/
	jQuery("div.addToCart").click(function() {
		jQuery('#ajaxMessage').css('display','none');
		jQuery.blockUI(('<h1><s:text name="catalog.addingtocart" /></h1>'));
		var qty = jQuery('#productQuantity',this).val();
		if(qty==0) {
			return;
		}
		if(isNaN(qty)) {
			return;
		}
		var productId = jQuery('#productId',this).val();

		var theForm = document.attributes;
		if(theForm) {
			var theForm = document.attributes;
			var options = getAttributes(theForm);
			ShoppingCart.addProductWithAttributes(productId,qty,options,handleCart);
		} else {
			ShoppingCart.addProductNoAttributes(productId,qty,handleCart);
		}
		handleCart(null);
	});

	/** reset password box init **/
	jQuery("#resetPassword").fancybox({
		'titlePosition'		: 'inside',
		'transitionIn'		: 'none',
		'transitionOut'		: 'none'
	});




});

function loadReviewsContent(productId,pageStartIndex) {
	jQuery('#reviews-placeholder').load('<%=request.getContextPath()%>/product/reviews.action?product.productId=' + productId + '&pageStartIndex=' + pageStartIndex + '&' + <%=new Date().getTime()%>); 
}

function removeProduct(productId) {
	jQuery('#ajaxMessage').css("display","none");
	jQuery.blockUI(('<h1><s:text name="label.generic.wait" /></h1>'));
	ShoppingCart.removeProduct(productId,handleCart);
}

function handleCart(data) {
	if(data) {
		if(data.errorMessage!=null) {
			document.getElementById('ajaxMessage').innerHTML=data.errorMessage;
			document.getElementById('ajaxMessage').style.display='block';
		} else {
			//get products
			var products = data.products;//cart

			//init default values;
			document.getElementById('cart-lines').innerHTML='';
			document.getElementById('button-right').style.display='none';
			document.getElementById('total-price').style.display='none';
			document.getElementById('checkout-text').innerHTML='<font class=\"checkout-item\"><s:text name="catalog.cart.empty" /></font></div>';


			if(products && products.length>0) {

				var cartElements = '<div class=\"cart1\"></div><div class=\"cart2\">';
				count = 1;
				for (i=0; i<products.length; i++) {
					if(count==1) {
						cartElements = cartElements + '<div class=\"cart-line cart-first\">';
					} else if(count<products.length) {
						cartElements = cartElements + '<div class=\"cart-line\">';
					} else {
						cartElements = cartElements + '<div class=\"cart-line cart-last\">';
					}
					if(products[i].image!=null && products[i].image!='') {
						cartElements = cartElements + '<div class=\"cart-product\"><img src=\"' + products[i].image  + '\" width=\"<s:property value="#session.STORECONFIGURATION['smallimagewidth']" />\" height=\"<s:property value="#session.STORECONFIGURATION['smallimageheight']" />\" border=\"0\"></div>';
					} else {
						cartElements = cartElements + '<div class=\"cart-product\"></div>';
					}
					cartElements = cartElements + '<div class=\"cart-info\"><div class="cart-name">'+ products[i].productName +'</div>';
					cartElements = cartElements + '<div class=\"cart-price\">'+ products[i].priceText +'</div>';
					cartElements = cartElements + '<div class=\"cart-qty\"><s:text name="label.generic.qty" /> '+ products[i].quantity +'</div>';
					cartElements = cartElements + '<div class=\"cart-instock\"><img src=\"<%=request.getContextPath()%>/common/img/icon_delete.gif\"  border=\"0\" onClick=\"removeProduct(' + products[i].productId +')\"></div>';
					cartElements = cartElements + '</div></div>';
					count++;
				}
				cartElements = cartElements + '</div><div class=\"cart3\"></div>';
				document.getElementById('cart-lines').innerHTML=cartElements;

				var item = '';
				if(data.quantity>1) {
					item = '<s:text name="catalog.items" />';
				} else {
					item = '<s:text name="catalog.item" />';
				}

				document.getElementById('checkout-text').innerHTML='<font class=\"checkout-value\">' + data.quantity + '</font> <font class=\"checkout-item\">' + item + '</font><br><s:text name="catalog.incart" />';
				document.getElementById('button-right').style.display='block';
				document.getElementById('total-price').innerHTML='<span class=\"total-price1\"></span><span class=\"total-price2\"><font class=\"total-label\"><s:text name="label.generic.total" /></font>&nbsp;<font class=\"price-label\">'+ data.total +'&nbsp;<s:property value="#request.STORE.currency"/></font></span><span class=\"total-price3\"></span>';
				document.getElementById('total-price').style.display='block';
			}
		}
	}
	jQuery.unblockUI();
}




/** Login **/

function login() {

	var username = jQuery('#username').val();
	var password = jQuery('#password').val();

	if(username!='' && password!='') {

	
	jQuery.blockUI(('<h1><s:text name="message.processing.login" /></h1>'));


	var completed = 0;

	jQuery('#logonMessage').html('');
	document.getElementById('ajaxMessage').style.display = 'none';

	var dataStr="username="+username+"&password="+password;


	jQuery.ajax({ type: "POST", url: LOGIN_URL, data: dataStr, dataType: "xml",

				

				beforeSend: function() {
					ajax_timeout = setTimeout(function() {
						if(completed==0) {
							document.getElementById('ajaxMessage').style.display = 'block';
							var htmlText = "<ul class='errorMessage'><b>";
							var timeOutText = '<s:text name="message.login.timeout" />';
							htmlText= htmlText + "</b></ul>";
							jQuery.unblockUI();
							jQuery('#logonMessage').html(timeOutText);
							alert(timeOutText);
						}
					}, 12000);
				},


				success: function(xml){

				completed = 1;


				jQuery(xml).find('authentication-reply').each(function(){
				var returnCode = jQuery(this).find('returnCode').text();
				if(returnCode == SUCCESS_CODE){
                             	jQuery('#profileLink').css('visibility','visible');
					var name = getLoginInfo(xml);
					var htmlText = '<s:text name="label.generic.welcome" /> <b>' + name + '</b><br>';
					htmlText= htmlText + '<a href=\"<sm:url scheme="https" namespace="profile" action="profile" />\"><s:text name="label.profile.information" /></a><br>';
					htmlText= htmlText + '<a href=\"javascript:logout()\"><s:text name="button.label.logout" /></a>';
					jQuery('#loginCustomer').html(htmlText);
					jQuery('#loginCustomer').css('display','block');
					jQuery('#logonForm').css('display','none');
					jQuery.unblockUI();
					

				}else{
					var messages = jQuery(this).find('messages').text();
					var message = messages.split(DELIMITER);
					var htmlText = "<ul><b><font color='red'>";
					for(var i=0;i<message.length;i++){
						htmlText= htmlText + "<li>"+ message[i]+"</li>";
					}
					htmlText= htmlText + "</font></b></ul>";
					jQuery('#logonMessage').html(htmlText);
					jQuery('#logonMessage').css('display','block');
					jQuery.unblockUI();
				}
				
			});

	}});

	}


}





//]]> 
</script>























