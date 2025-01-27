<%@taglib prefix="s" uri="/struts-tags" %>




		<div id="local">
                <h2><s:text name="label.product.options.available" /></h2>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/catalog/showcreateproduct.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.productdetails" /></a></li>
                    <li><a href="<%=request.getContextPath()%>/catalog/showproductprice.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.product.prices" /></a></li>
                    <li><a href="<%=request.getContextPath()%>/catalog/showuploadform.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.options.configure.imaganddown" /></a></li>
                    <li><a href="<%=request.getContextPath()%>/catalog/editdiscount.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.options.configure.discounts" /></a></li>
                    <li><a href="<%=request.getContextPath()%>/catalog/productattributes.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.productproperties.edit" /></a></li>
			  <li><a href="<%=request.getContextPath()%>/catalog/productpreview.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.preview"/></a></li>
			  <li><a href="<%=request.getContextPath()%>/catalog/productreview.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.review"/></a></li>
			  <li><a href="<%=request.getContextPath()%>/catalog/crosssellItems_display.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.storefront.crosssellitems"/></a></li>
			  <s:if test="product.productImage != null && product.productImage != ''">
			  <li><a href="<%=request.getContextPath()%>/catalog/showCropProductImage.action?product.productId=<s:property value="%{product.productId}"/>"><s:text name="label.product.image.crop"/></a></li>
			  </s:if>
                </ul>


         </div><!-- local -->


