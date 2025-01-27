<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

   		
            <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/pagination.css"/>
            <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/common.css"/>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/customer.css"/>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/catalog/layout.css"/>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/jquery.fancybox-1.3.0.css"/>
    		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/templates/catalog/<s:property value="#request.templateId"/>.css"/>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/common/css/jquery.alerts.css"/>


		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.alerts.js"></script>
   		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.pagination.js"></script>
      	<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.blockUI.1.33.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.easing-1.3.pack.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.fancybox-1.3.0.pack.js"></script>
    		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/functions.js"></script>
            <script type="text/javascript" src="<%=request.getContextPath()%>/common/js/templates/<s:property value="#request.templateId"/>/functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/customer.js"></script>


		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/ShoppingCart.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/Catalog.js'></script>
            <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/Customer.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UpdateZones.js'></script>
    		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
