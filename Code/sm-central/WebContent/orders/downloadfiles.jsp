	<%@page contentType="text/html"%>
	<%@page pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import = "com.salesmanager.central.web.*"  %>

<%@ page import = "com.salesmanager.core.util.*"  %>
<%@ page import = "com.salesmanager.core.entity.orders.OrderProductDownload"  %>
<%@ page import = "com.salesmanager.core.module.model.application.ProductFileModule"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
List files = (List)request.getAttribute("files");
String email = (String)request.getAttribute("emailaddress");
String orderid = (String)request.getAttribute("orderid");

%>




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="s" uri="/struts-tags" %>
    <title><%=LabelUtil.getInstance().getText(request,"label.order.download.title")%></title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/main.css"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/styles/layout-navtop-1col-large.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/struts/xhtml/styles.css" type="text/css"/>


       <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DownloadMonitor.js'></script>
       <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
       <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>

<script language="javascript">

    var serviceurl;

    function openUrl(url, count, merchantid, orderid, productid, attrid)
    {


        DownloadMonitor.updateCounter(count, merchantid, orderid, productid, updateDownloadInfo);

    }

    function updateDownloadInfo(downloadInfo)
    {

			 <%
			 String url = request.getContextPath() + "/getfile?fileid="+request.getParameter("fileid") + "&merchid=" + request.getParameter("merchid") + "&lang=" + request.getParameter("lang");

			 %>

			 var url = '<%=url%>';
             var elemid = 'maxcount_' +  downloadInfo.idcount;
             document.getElementById(elemid).innerText=downloadInfo.maxcount;

             if(downloadInfo.maxcount==0) {
             	var fileid = 'file_' +  downloadInfo.idcount;
             	document.getElementById(fileid).innerText=downloadInfo.file;
             }

    }


</script>

</head>

<body id="profile">

<div id="page">

		<%@ include file="../common/simpleheader.jsp" %>

        <div id="content" class="clearfix">

            <div id="main">

				<h2><%=LabelUtil.getInstance().getText(request,"label.order.download.title")%></h2>



				<%=MessageUtil.displayMessages(request)%><p>



				<%
				if(files!=null && files.size()>0) {

				%>
				<table width="70%">
				<tr>
				<td><%=LabelUtil.getInstance().getText(request,"label.order.orderid")%></td>
				<td><%=LabelUtil.getInstance().getText(request,"label.order.downloadfile.filename")%></td>
				<td><%=LabelUtil.getInstance().getText(request,"label.order.downloadfile.maxdownload")%></td>
				<td>&nbsp;</td>
				<tr>

				<%
					Iterator filesiterator = files.iterator();
					boolean afileisexpired = false;
					int count = 0;
					while(filesiterator.hasNext()) {
						OrderProductDownload opd = (OrderProductDownload)filesiterator.next();
						opd.getDownloadCount();

						Date datepurchased = (Date)request.getAttribute("datepurchased");
						int merchantid = (Integer)request.getAttribute("merchantid");

						boolean expired = false;
						/**
						Date today = new Date();
						// *** Add number of days ***
						GregorianCalendar gc = new GregorianCalendar();
						gc.setTime(datepurchased);
						gc.roll(Calendar.DAY_OF_YEAR, opd.getDownloadMaxdays());
						Date end = gc.getTime();



						if(end.before(today)) {//check if download delay has expired
							expired = true;
							afileisexpired = true;
						}
						if(opd.getDownloadCount()==0) {//check if max download has expired
							expired = true;
							afileisexpired = true;
						}
						**/

						String fileurl = "";
						String expiredfileurl = "";
						if(!expired) {

							ProductFileModule remote = (ProductFileModule)SpringUtil.getBean("productfile");
							remote.setProductId(opd.getOrderProductId());
							StringBuffer params = new StringBuffer();
							//url to download file
							String remotefileurl = remote.getFileUrl(opd.orderProductId,merchantid,opd.getOrderProductFilename());
							params.append("'").append(remotefileurl).append("'").append(",");
							params.append(count).append(",");
                            params.append(merchantid).append(",");
							params.append(opd.getOrderId()).append(",");
							params.append(opd.getOrderProductId());
							expiredfileurl = "<span id=\"file_" + count + "\">" + opd.getOrderProductFilename() + "</span>";
							fileurl = "<span id=\"file_" + count + "\"><a href='" + remotefileurl + "' onClick=\"javascript:openUrl(" + params.toString() + ")\">" + opd.getOrderProductFilename() + "</a></span>";


						}


						%>
<tr>
<td><%=opd.getOrderId()%></td>
<td><%=expired?expiredfileurl:fileurl%></td>
<td><span id="maxcount_<%=count%>"><%=opd.getDownloadCount()%></span></td>
<td><%=expired?"<font color='red'>*</font>":"&nbsp;"%></td>

</tr>
						<%


						count++;

					}
					if(afileisexpired) {
					%>
					<tr><td colspan="4"><b><font color="red">*</font><%=LabelUtil.getInstance().getText(request,"message.error.download.delayexpired1")%>&nbsp;<%=email %>&nbsp;<%=LabelUtil.getInstance().getText(request,"message.error.download.delayexpired2")%>&nbsp;<%=orderid %></b></td></tr>

					<%

					}
					%>
					</table>
					<%
				}


				%>

			</div>
			<p>
			<p>
			<%@ include file="../common/footer.jsp" %>
		</div>
</div>
</body>
</html>