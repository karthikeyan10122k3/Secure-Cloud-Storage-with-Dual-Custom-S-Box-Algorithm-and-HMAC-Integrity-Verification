<!--valid-->
<%@page import="java.sql.*"%>
<%
    try {
        String id = request.getParameter("id");
        String user = request.getParameter("user");
        String keyword = request.getParameter("keyword");
        String file = request.getParameter("file");
        String skey = request.getParameter("skey");
        String tkey = request.getParameter("tkey");
        String uid = session.getAttribute("id").toString();
        String uname = session.getAttribute("user").toString();
        String email = session.getAttribute("email").toString();

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/proxy", "root", "root");
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO urequest(id, user, keyword, file, uid, uname, skey, tkey, email) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, id);
        ps.setString(2, user);
        ps.setString(3, keyword);
        ps.setString(4, file);
        ps.setString(5, uid);
        ps.setString(6, uname);
        ps.setString(7, skey);
        ps.setString(8, tkey);
        ps.setString(9, email);
        ps.executeUpdate();

        // Redirect with success toast parameters
        response.sendRedirect("file.jsp?toast=success&message=Request sent successfully");
    } catch (Exception e) {
        System.out.println(e);
        // Redirect with error toast parameters
        response.sendRedirect("file.jsp?toast=error&message=Please try again");
    }
%>
