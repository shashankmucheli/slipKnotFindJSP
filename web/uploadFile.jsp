<%-- 
    Document   : index
    Created on : Sep 29, 2015, 6:00:47 PM
    Author     : Shashank
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="KnotFind.KnotFind"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>


<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String name = new String();
   String chain="";
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");
   //filePath = "C:\\Users\\Shashank\\Documents\\NetBeansProjects\\Knots\\web\\";

   // Verify the content type
   String contentType = request.getContentType();
   //out.println(contentType);
   if ((contentType!=null)&&(contentType.indexOf("multipart/form-data") >= 0)) {
 
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      //chain = request.getParameter(chain);
      try{
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if (fi.isFormField()) {
                String fname = fi.getFieldName();
                String fvalue = fi.getString();
                out.println(fname+" "+fvalue);
                chain = fvalue;
            }
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + 
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
            file = new File( filePath + 
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
            out.println("Uploaded Filename: " + filePath + 
            fileName + "<br>");
            name = fileName;
            }
         }
         out.println("</body>");
         out.println("</html>");
         KnotFind knot = new KnotFind();
         String dir = knot.initResidual(name,chain);
         out.println("<br />"+dir+"<br />");
         String[] split;
         split = dir.split("-");
         if(split[0].equals("Slipknots/")){
             String N =  split[1];
             String k3 =  split[2];
             String k2 =  split[3];
             String k1 =  split[4];
             String C =  split[5];
             String index = N+"-"+k3+"-"+k2+"-"+k1+"-"+C;
             Cookie knotProt = new Cookie("knotProt",index);
             knotProt.setMaxAge(60*60*24);
             knotProt.setPath("/");
             response.addCookie(knotProt);
         }
         else if(split[0].equals("Knots/")){
             String N =  split[1];
             String k3 =  split[2];
             String k2 =  split[3];
             String C =  split[4];
             String index = N+"-"+k3+"-"+k2+"-"+C;
             Cookie knotProt = new Cookie("knotProt",index);
             knotProt.setMaxAge(60*60*24);
             knotProt.setPath("/");
             response.addCookie(knotProt);
         }
         Cookie PDBDir = new Cookie("PDBDir",split[0]);
         Cookie PDBName = new Cookie("PDBName",name);
         PDBName.setMaxAge(60*60*24);
         PDBDir.setMaxAge(60*60*24);
         PDBName.setPath("/");
         PDBDir.setPath("/");
         response.addCookie(PDBName);
         response.addCookie(PDBDir);
         /*
            <c:redirect url="http://localhost:8080/pdb/">
            </c:redirect>
         */
         %>
        <c:redirect url="http://localhost:8080/pdb/">
        </c:redirect>
        <%
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>

