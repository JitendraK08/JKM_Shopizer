	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>
<%@ page import = "com.salesmanager.core.util.*"  %>
<%@ taglib uri="/WEB-INF/classes/sm-catalog.tld" prefix="sm" %>		
<%@ taglib uri="/WEB-INF/classes/sm.tld" prefix="sm-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>	
<%@taglib prefix="s" uri="/struts-tags" %>

<s:include value="../components/catalog/pagination.jsp"/>



<style type="text/css"> 

.formcontent fieldset {
	border:0;
	position: relative;
	left: 0px;
	top:  0px;
}


</style> 

			

<s:if test="principal.remoteUser!=null">


<script type="text/javascript">


function remove(reviewId) {
	jConfirm('<s:text name="message.confirm.removereview" />', '<s:text name="label.generic.confirm" />', '<s:text name="button.label.submit2" />', '<s:text name="button.label.cancel" />', function(r) { 
		if(r==true) {
			submitReviewRemoval(reviewId);
		} 
	}); 

}

function submitReviewRemoval(reviewId) {
	document.getElementById('reviewId').value=reviewId;
	document.removeReview.submit();

	
}


</script> 





<div id="reviews" style="left: 60px" class="formcontent">




<fieldset>
<legend><s:text name="label.customer.productreviews.comments"/></legend><h3><s:text name="label.customer.productreviews.comments"/></h3>


<br>
<br>
							<s:form name="removeReview" action="removeReview" method="post">
								<input type="hidden" id="reviewId" name="reviewId" value="">
							</s:form>

							<s:form name="page" action="reviews" method="post">
								<input type="hidden" id="pageStartIndex" name="pageStartIndex" value="<s:property value="pageStartIndex"/>">
							</s:form> 


                                          <div>
								<table border="0" width="100%">
									<tr>
										<td><div class="paginationCustomer-left"><s:text name="label.generic.Entries" /> <s:property value="firstItem" /> - <s:property value="lastItem" /> of <s:property value="listingCount" /></td>
										<td><div id="Pagination" class="paginationCustomer"></td>
									</tr>
								</table>
							</div>
							<div>
							<table id="list-table" border="0" width="100%" summary="Product reviews">
    								<thead>
            							<tr>
            								<th scope="col"><s:text name="label.prodlist.prodname" /></th>
										<th scope="col"><s:text name="label.product.review" /></th>
										<th scope="col"><s:text name="label.product.rating" /></th>
            								<th scope="col"><s:text name="label.generic.date" /></th>
            								<th scope="col">&nbsp;</th>

        								</tr>
    								</thead>
    								<tbody>

      							<s:iterator value="reviews">
      								<tr>
         									<td align="left"><s:property value="productName"/></td>
										<td align="left"><s:property value="description"/></td>
										<td align="left">

											<s:set name="reviewRating" value="reviewRating" scope="request"/> 

											<c:forEach var="i" begin="0" end="4" step="1">
												<c:choose>
													<c:when  test="${i<request.reviewRating}">
																<img   src="<%=request.getContextPath()%>/common/img/redStar.gif"  border="0">
													</c:when>
													<c:otherwise>
																<img   src="<%=request.getContextPath()%>/common/img/whiteStar.gif"  border="0">
													</c:otherwise>
												</c:choose>
											</c:forEach> 


										</td>
         									<td align="left"> <s:date name="dateAdded" format="yyyy-MM-dd" /></td>
		 								<td align="left"> <img src="<%=request.getContextPath()%>/common/img/icon_delete.gif"  border="0" onClick="javascript:remove(<s:property value="reviewId"/>)"></td>
        								</tr>
      							</s:iterator>

    								</tbody>
							</table>
							</div>



<jsp:include page="profileMenu.jsp" />

    </fieldset>




</div>

</s:if>





		









