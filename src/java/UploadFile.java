//Upload.jsp

import algo.DualSBox;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(urlPatterns = {"/Upload1", "/Download"})
public class UploadFile extends HttpServlet {

    protected void processRequest( HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        List<String> m = new ArrayList<>();
        List<String> ms = new ArrayList<>();
        String finalImage = "";

        if (!isMultipart(request)) {
            throw new ServletException("Request is not multipart.");
        }

        List<FileItem> items = handleFileUpload(request);
        finalImage = processFileItems(items, m, ms);

        try {
            String skey = m.get(2);  // Assuming skey is at index 2
            String tkey = m.get(3);  // Assuming tkey is at index 3

            saveAndEncryptFile(finalImage, m, ms, skey, tkey);
            saveToDatabase(m, ms);

            request.setAttribute("notificationMessage", "File uploaded and encrypted successfully.");
            request.setAttribute("notificationType", "success");

            RequestDispatcher rd = request.getRequestDispatcher("upload.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notificationMessage", "Error uploading file.");
            request.setAttribute("notificationType", "error");

            RequestDispatcher rd = request.getRequestDispatcher("upload.jsp");
            rd.forward(request, response);
        }
    }

    private boolean isMultipart(HttpServletRequest request) {
        return ServletFileUpload.isMultipartContent(request);
    }

    private List<FileItem> handleFileUpload(HttpServletRequest request) throws ServletException {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = new ArrayList<>();
        try {
            items = upload.parseRequest(request);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error in file upload");
        }
        return items;
    }

    private String processFileItems(List<FileItem> items, List<String> m, List<String> ms) {
        String finalImage = "";
        for (FileItem item : items) {
            if (item.isFormField()) {
                String value = item.getString();
                m.add(value);
            } else {
                String fileName = item.getName();
                finalImage = processFileName(fileName);
                ms.add(finalImage);

                try {
                    saveFile(item, finalImage);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return finalImage;
    }

    private String processFileName(String fileName) {
        String reg = "[.*]";
        String replacingText = "";
        Pattern pattern = Pattern.compile(reg);
        Matcher matcher = pattern.matcher(fileName);
        StringBuffer buffer = new StringBuffer();

        while (matcher.find()) {
            matcher.appendReplacement(buffer, replacingText);
        }

        int indexOf = fileName.indexOf(".");
        String domainName = fileName.substring(indexOf);

        return buffer.toString() + domainName;
    }

    private void saveFile(FileItem item, String finalImage) throws Exception {
        File savedFile = new File("C:\\Files\\OriginalFiles\\" + finalImage);
        item.write(savedFile);
    }

    private void saveAndEncryptFile(String finalImage, List<String> m, List<String> ms, String skey, String tkey) throws Exception {
        String content = readFileContent("C:\\Files\\OriginalFiles\\" + finalImage);
        DualSBox dsb = new DualSBox(skey);

        String encryptedContent = dsb.encrypt(skey, content);

        writeToFile("C:\\SecuredCloudStorage\\EncryptedFiles\\" + finalImage, encryptedContent);
    }

    private String readFileContent(String filePath) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(filePath));
        StringBuilder content = new StringBuilder();
        String sCurrentLine;
        while ((sCurrentLine = br.readLine()) != null) {
            content.append(sCurrentLine);
        }
        return content.toString().replaceAll("( )+", " ");
    }

    private void writeToFile(String filePath, String content) throws IOException {
        PrintWriter writer = new PrintWriter(filePath, "UTF-8");
        writer.println(content);
        writer.close();
    }

    private void saveToDatabase(List<String> m, List<String> ms) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
        PreparedStatement ps = con.prepareStatement("INSERT INTO upload (id, user, email, mobile, keyword, tkey, skey, file) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        for (int i = 0; i < m.size(); i++) {
            ps.setString(i + 1, m.get(i));
        }
        ps.setString(8, ms.get(0));
        ps.executeUpdate();
    }

    protected void downloadFile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getParameter("fileName");
        String skey = request.getParameter("skey");

        try {
            DualSBox dsb = new DualSBox(skey);
            String encryptedContent = readFileContent("C:\\SecuredCloudStorage\\EncryptedFiles\\" + fileName);
            String decryptedContent = dsb.decrypt(skey, encryptedContent);

            response.setContentType("text/plain");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.getWriter().write(decryptedContent);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error in file download or decryption.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/Download")) {
            downloadFile(request, response);
        } else {
            processRequest(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "File Upload, Encryption, and Decryption Servlet";
    }
}
