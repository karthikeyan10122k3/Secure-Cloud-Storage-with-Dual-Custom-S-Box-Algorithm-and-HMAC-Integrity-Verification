<!--valid-->

<%@page import="mail.mail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Retrieve parameters from the request
    String id = request.getParameter("id");
    String username = request.getParameter("user");
    String file = request.getParameter("file");
    String userEmail = request.getParameter("email");

    // Initialize variables for keys
    String tkey = "";
    String skey = "";

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");

        // Fetch keys from the 'upload' table based on provided details
        PreparedStatement pas = con.prepareStatement("SELECT * FROM upload WHERE id=? AND user=? AND file=?");
        pas.setString(1, id);
        pas.setString(2, username);
        pas.setString(3, file);

        ResultSet rs1 = pas.executeQuery();

        if (rs1.next()) {
            // Retrieve the keys from the result set
            tkey = rs1.getString("tkey");
            skey = rs1.getString("skey");

            // Update the 'urequest' table with the retrieved keys
            PreparedStatement ps = con.prepareStatement("UPDATE urequest SET tkey=?, skey=? WHERE id=? AND user=? AND file=?");
            ps.setString(1, tkey);
            ps.setString(2, skey);
            ps.setString(3, id);
            ps.setString(4, username);
            ps.setString(5, file);
            ps.executeUpdate();
            ps.close();

            // Prepare and send the email
            mail m = new mail();
            String subject = "Decryption Key and Secret Key";

            // HTML formatted mail content
            String mailContent = "<html><body>" +
                                  "<h3>Decryption Key and Secret Key</h3>" +
                                  "<p><strong>Decryption Key:</strong> " + tkey + "</p>" +
                                  "<p><strong>Secret Key:</strong> " + skey + "</p>" +
                                  "<p><strong>File Name:</strong> " + file + "</p>" +
                                  "</body></html>";

            // Send email using the 'mail' class method
            m.sendFromGMail("kerthsk@gmail.com", "***************", userEmail, subject, mailContent);
//            PreparedStatement ps = con.prepareStatement("UPDATE urequest SET tkey=?, skey=? WHERE id=? AND user=? AND file=?");
            ps = con.prepareStatement("UPDATE urequest SET MailStatus = 'Sent', DownloadStatus = 'Pending' WHERE id=? AND user=? AND file=?");
            ps.setString(1, id);
            ps.setString(2, username);
            ps.setString(3, file);
            ps.executeUpdate();
            ps.close();
// Alert the user that the key was sent successfully
            out.println("<script>"
                      + "alert('Key sent to User Successfully!');"
                      + "</script>");
        } else {
            out.println("<script>"
                      + "alert('No matching record found!');"
                      + "</script>");
        }
        
        // Redirect to sendkey.jsp
        RequestDispatcher rd = request.getRequestDispatcher("sendkey.jsp");
        rd.include(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>"
                  + "alert('Error occurred while processing the request!');"
                  + "</script>");
    }
%>
