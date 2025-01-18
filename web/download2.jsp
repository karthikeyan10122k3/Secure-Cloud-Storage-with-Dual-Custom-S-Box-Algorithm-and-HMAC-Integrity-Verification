<!--valid-->

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="algo.DualSBox" %>
<%
    String UserEnteredTkey = request.getParameter("tkey");
    String UserEnteredSkey = request.getParameter("skey");

    String id = session.getAttribute("id").toString();
    String name = session.getAttribute("user").toString();

    // Database connection
    Connection con = null;
    PreparedStatement query = null;
    ResultSet rs = null;
    String notificationMessage = "";
    String notificationType = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
        
        query = con.prepareStatement("SELECT * FROM urequest WHERE tkey=? AND skey=? AND status='Accepted'");
        query.setString(1, UserEnteredTkey);
        query.setString(2, UserEnteredSkey);
        rs = query.executeQuery();

        if (rs.next()) {
            String skey = rs.getString("skey");
            String filename = rs.getString("file");
            String originalFilePath = "C:\\Files\\OriginalFiles\\" + filename;

            File originalFile = new File(originalFilePath);
            if (!originalFile.exists()) {
                notificationMessage = "Encrypted file does not exist.";
                notificationType = "error";
                request.getRequestDispatcher("download.jsp").include(request, response);
                return;
            }
            
            // Read encrypted file content into a string
            StringBuilder encryptedContent = new StringBuilder();
            BufferedReader br = null;
            try {
                br = new BufferedReader(new FileReader(originalFile));
                String line;
                while ((line = br.readLine()) != null) {
                    encryptedContent.append(line);
                }
            } finally {
                if (br != null) {
                    br.close();
                }
            }

            // Decrypt the content
            try {
                DualSBox dualSBox = new DualSBox(skey);
                
                String encryptedContent1 = dualSBox.encrypt(skey, encryptedContent.toString());
                String decryptedContent = dualSBox.decrypt(skey, encryptedContent1.toString());
                
                // Save the decrypted content to a new file
                String decryptedFilePath = "C:\\SecuredCloudStorage\\DecryptedFiles\\" + filename;
                File decryptedFile = new File(decryptedFilePath);
                
                // Ensure the decrypted file's parent directory exists
                if (!decryptedFile.getParentFile().exists()) {
                    decryptedFile.getParentFile().mkdirs();
                }

                PrintWriter writer = new PrintWriter(new FileWriter(decryptedFile));
                writer.println(decryptedContent);
                writer.close();

                // Update database status
                PreparedStatement query1 = con.prepareStatement(
                    "UPDATE urequest SET DownloadStatus='Downloaded' WHERE uid=? AND uname=? AND tkey=? AND skey=? AND status='Accepted'"
                );
                query1.setString(1, id);
                query1.setString(2, name);
                query1.setString(3, UserEnteredTkey);
                query1.setString(4, UserEnteredSkey);
                query1.executeUpdate();

                notificationMessage = "File successfully decrypted and saved.";
                notificationType = "success";
            } catch (Exception e) {
                e.printStackTrace();
                notificationMessage = "Decryption error: Invalid encrypted data format or key.";
                notificationType = "error";
            }
        } else {
            notificationMessage = "Incorrect keys or file not found.";
            notificationType = "error";
        }
    } catch (Exception e) {
        e.printStackTrace();
        notificationMessage = "An error occurred while processing your request.";
        notificationType = "error";
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (query != null) try { query.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    // Pass the notification details to the JSP page
    request.setAttribute("notificationMessage", notificationMessage);
    request.setAttribute("notificationType", notificationType);
%>

<!-- Include the download.jsp page with the notification -->
<jsp:include page="download.jsp">
    <jsp:param name="notificationMessage" value="<%= notificationMessage %>" />
    <jsp:param name="notificationType" value="<%= notificationType %>" />
</jsp:include>
