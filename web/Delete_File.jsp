<!--valid-->

<%@page import="java.sql.*"%>
<%
  String id = request.getParameter("id");
     String  file =request.getParameter("file");

    Class.forName("com.mysql.jdbc.Driver");
   Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy","root","root");
   PreparedStatement ps=con.prepareStatement(" DELETE FROM upload WHERE id='"+id+"' AND file='"+file+"' ");
   
   ps.executeUpdate();
        RequestDispatcher rd=request.getRequestDispatcher("/Manage.jsp");  
        rd.include(request, response);  
  

%>
