	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>

<%@ page import = "java.util.*" %>
<%@ page import = "com.salesmanager.core.util.*" %>


<%@taglib prefix="s" uri="/struts-tags" %>

<script type="text/javascript">
function moveToPage(page) {
      document.nav.startindex.value=page;
	  document.nav.submit();
}
</script>

               <%
               PageByPageIterator ppiterator = (PageByPageIterator)request.getAttribute("NAVIGABLEITEMLIST");

			   if(ppiterator!=null) {

               int start = ppiterator.getStartIndex();//current index
			   int count = ppiterator.objectCount();//number of items in the page
			   int total = ppiterator.getTotalCount();//total number of items
			   int maxsize = ppiterator.getSize();//number maximum of item displayed

			    //System.out.println("Start " + start);
			    //System.out.println("Items in page " + count);
			    //System.out.println("Total products " + total);


			    %>

			    <b><%=start%>-<%=start+count %> <s:text name="label.generic.of"/> <%=total%> <%if(total>1){%><s:text name="label.generic.entries"/><%}else{ %><s:text name="label.generic.entry"/><%}%></b>
			    <%
			    if(start>0) {
			    	int position = start-count;
			    	if(count<maxsize) {
			    		position = start-maxsize;

			    	}
			    %>

			    <a href="javascript:moveToPage('<%=position %>')"><s:text name="label.iterator.previous"/></a>
			    <%if(count==maxsize) {%>
                      &nbsp;|&nbsp;
			    <%
			    }
			    }
			    if(count==maxsize && count<total) {%>
			    <a href="javascript:moveToPage('<%=start+count %>')"><s:text name="label.iterator.next"/></a>


			    <%
			    }


			   }
               %>
