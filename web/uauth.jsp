<!--valid-->

<%@page import="java.sql.*"%>
<%
    String id = request.getParameter("id");

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");

        // Check the current status of the user
        PreparedStatement checkStatus = con.prepareStatement("SELECT status FROM ureg WHERE id = ?");
        checkStatus.setString(1, id);
        ResultSet rs = checkStatus.executeQuery();

        if (rs.next()) {
            String currentStatus = rs.getString("status");

            // Determine the new status based on the current status
            String newStatus = currentStatus.equalsIgnoreCase("Activated") ? "Deactivated" : "Activated";

            // Update the user's status
            PreparedStatement updateStatus = con.prepareStatement("UPDATE ureg SET status = ? WHERE id = ?");
            updateStatus.setString(1, newStatus);
            updateStatus.setString(2, id);
            int rowsUpdated = updateStatus.executeUpdate();

            if (rowsUpdated > 0) {
                // Inform the user of the action performed
                out.println("<script>");
                out.println("alert('User status updated to " + newStatus + " successfully');");
                out.println("window.location.href = 'authuser.jsp';"); // Redirect to authuser.jsp after update
                out.println("</script>");
            } else {
                // Handle case where the status update failed
                out.println("<script>");
                out.println("alert('Failed to update the user status. Please try again.');");
                out.println("window.location.href = 'authuser.jsp';");
                out.println("</script>");
            }
        } else {
            // Handle the case where the user ID does not exist
            out.println("<script>");
            out.println("alert('User not found');");
            out.println("window.location.href = 'authuser.jsp';"); // Redirect back to the user page
            out.println("</script>");
        }

        // Close resources
        rs.close();
        checkStatus.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('An error occurred while updating the user status. Please try again later.');");
        out.println("window.location.href = 'authuser.jsp';"); // Redirect back to the user page
        out.println("</script>");
    }
%>
