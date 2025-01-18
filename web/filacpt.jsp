<!--valid-->

<%@page import="java.sql.*"%>
<%
    String id = request.getParameter("id");
    String uid = request.getParameter("uid");
    String file = request.getParameter("file");

    String popupMessage = "";
    boolean isError = false;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");

        // Validate that the request belongs to the logged-in user
        String user = session.getAttribute("user").toString(); // Get the logged-in user
        PreparedStatement validateQuery = con.prepareStatement("SELECT * FROM urequest WHERE id=? AND uid=? AND file=? AND user=?");
        validateQuery.setString(1, id);
        validateQuery.setString(2, uid);
        validateQuery.setString(3, file);
        validateQuery.setString(4, user);
        ResultSet rs = validateQuery.executeQuery();

        // Only update if the request is valid and matches the logged-in user
        if (rs.next()) {
            PreparedStatement ps = con.prepareStatement("UPDATE urequest SET status='Accepted' WHERE id=? AND uid=? AND file=?");
            ps.setString(1, id);
            ps.setString(2, uid);
            ps.setString(3, file);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                popupMessage = "File request accepted successfully!";
            } else {
                popupMessage = "Request could not be processed.";
                isError = true;
            }
        } else {
            popupMessage = "Invalid request or you are not authorized to accept this request.";
            isError = true;
        }
    } catch (Exception e) {
        popupMessage = "Error processing request: " + e.getMessage();
        isError = true;
    }

    // Set the popup message and error flag to be forwarded to the JSP
    request.setAttribute("popupMessage", popupMessage);
    request.setAttribute("isError", isError);

    // Forward to the user request page
    RequestDispatcher rd = request.getRequestDispatcher("/rereq.jsp");
    rd.forward(request, response);
%>
