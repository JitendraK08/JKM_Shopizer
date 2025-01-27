<%@ page import="com.salesmanager.central.util.upload.*" %>
<%@ page import="com.salesmanager.central.catalog.*" %>
<%@ page import="com.salesmanager.core.util.*" %>
<%@ page import="com.salesmanager.core.entity.catalog.Product" %>
<%@ page import="com.salesmanager.central.web.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!--

As per apache note,
this process fails inside Struts [http://commons.apache.org/fileupload/faq.html]

-->
<%

String productId = request.getParameter("productId");
if(productId==null) {
	response.sendRedirect(request.getContextPath() + "/catalog/productlist.action);
}

try
{


	UploadListener listener = new UploadListener(request, 30);

    // Create a factory for disk-based file items
    FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);

    // Create a new file upload handler
    ServletFileUpload fu = new ServletFileUpload(factory);
    //DiskFileUpload fu = new DiskFileUpload();

    List fileItems = fu.parseRequest(request);
    //System.out.println("***** items = " + fileItems );
    Iterator itr = fileItems.iterator();


    while(itr.hasNext()) {
      FileItem fi = (FileItem)itr.next();

      //Check if not form field so as to only handle the file inputs
      //else condition handles the submit button input
      if(!fi.isFormField()) {
	        String fieldName = fi.getFieldName();
	        String fileName = fi.getName();
	        String contentType = fi.getContentType();
	        //System.out.println("\nNAME: "+fi.getName());
	        //System.out.println("SIZE: "+fi.getSize());
	        //System.out.println("FIELD: "+fi.getFieldName());

	        //validate content type
	        String resp = "";
	        if(fieldName!=null && fieldName.equals("uploadfile")) {
	        	//ProductUploadAction pua = new ProductUploadAction();
	        	EditProductUploadAction action = new EditProductUploadAction();
	        	action.setServletRequest(request);
	        	Product product = new Product();
	        	product.setProductId(Long.parseLong(productId));
	        	action.setProduct(product);
				File tempFileRef  = new File(fi.getName());
				File fNew = new File(application.getRealPath("/"),tempFileRef.getName());
	        	fi.write(fNew);
	        	action.setUploadfilename(fNew.getName());
	        	action.setUploadfilecontenttype(contentType);
	        	action.setUploadfile(fNew);
	        	resp = action.uploadProduct();
	        	fi.delete();
	        }

	        if(resp.equals("success")) {
	        	response.sendRedirect(request.getContextPath() + "/catalog/showuploadform.action?product.productId=" + productId);
	        } else {
	        	response.sendRedirect(request.getContextPath() + "/catalog/showuploadform.action?product.productId=" + productId);
	        }
      }
    }

	} catch (Exception e) {
        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        MessageUtil.addErrorMessage(request, LabelUtil.getInstance().getText("errors.technical"));
        response.sendRedirect(request.getContextPath() + "/catalog/showuploadform.action??product.productId=" + productId);
    }
%>
<html>
<head><title></title></head>
<body>
</body>
</html>