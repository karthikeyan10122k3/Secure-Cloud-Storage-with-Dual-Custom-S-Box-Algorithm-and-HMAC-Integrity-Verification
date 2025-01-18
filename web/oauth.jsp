<!--valid-->

<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%
    String id = request.getParameter("id");

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");

        // Check the current status of the user
        PreparedStatement checkStatus = con.prepareStatement("SELECT status FROM oreg WHERE id = ?");
        checkStatus.setString(1, id);
        ResultSet rs = checkStatus.executeQuery();

        if (rs.next()) {
            String currentStatus = rs.getString("status");

            // Determine the new status based on the current status
            String newStatus = currentStatus.equalsIgnoreCase("Activated") ? "Deactivated" : "Activated";

            // Update the user's status
            PreparedStatement updateStatus = con.prepareStatement("UPDATE oreg SET status = ? WHERE id = ?");
            updateStatus.setString(1, newStatus);
            updateStatus.setString(2, id);
            int rowsUpdated = updateStatus.executeUpdate();

            if (rowsUpdated > 0) {
                // Inform the user of the action performed
                out.println("<script>");
                out.println("alert('Owner status updated to " + newStatus + " successfully');");
                out.println("window.location.href = 'authowner.jsp';"); // Redirect to authowner.jsp after update
                out.println("</script>");
            } else {
                // Handle case where the status update failed
                out.println("<script>");
                out.println("alert('Failed to update the owner status. Please try again.');");
                out.println("window.location.href = 'authowner.jsp';");
                out.println("</script>");
            }
        } else {
            // Handle the case where the user ID does not exist
            out.println("<script>");
            out.println("alert('Owner not found');");
            out.println("window.location.href = 'authowner.jsp';"); // Redirect back to the owner page
            out.println("</script>");
        }

        // Close resources
        rs.close();
        checkStatus.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('An error occurred while updating the owner status. Please try again later.');");
        out.println("window.location.href = 'authowner.jsp';"); // Redirect back to the owner page
        out.println("</script>");
    }
%>
