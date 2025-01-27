<%@taglib prefix="s" uri="/struts-tags" %>



		<div id="local">
                <h2><s:text name="label.customer.options.available" /></h2>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/customer/customerlist.action"><s:text name="label.customer.customerlist.title" /></a></li>
                    <s:if test="customer!=null && customer.customerId>0 && !customer.customerAnonymous">
                    	<li><a href="<%=request.getContextPath()%>/customer/resetcustomerpassword.action?customer.customerId=<s:property value="%{customer.customerId}"/>"><s:text name="label.customer.options.resetpassword" /></a></li>
					</s:if>

                </ul>


         </div><!-- local -->