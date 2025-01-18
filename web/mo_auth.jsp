<!--valid-->

<%@page import="java.sql.*"%>
<%
  String id = request.getParameter("id");
          
    Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy","root","root");
   PreparedStatement ps = con.prepareStatement("DELETE FROM oreg WHERE id='"+id+"'");
   ps.executeUpdate();

   out.println("<script>"); 			
   out.println("alert(\"Delete Owner Successfully\")");
   out.println("</script>");
        RequestDispatcher rd=request.getRequestDispatcher("/moauth.jsp");  
        rd.include(request, response);  
%>
