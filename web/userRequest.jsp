<!--valid-->

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Filecrypt Manager</title>

  <!-- Favicons -->
  <link href="assets/img/ProjectIcon.png" rel="icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Raleway|Poppins" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">

  <style>
    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      font-family: 'Poppins', sans-serif;
    }

    #header {
      background: linear-gradient(45deg, #007bff, #0056b3);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 15px;
    }

    #footer {
      background: #00263b;
      color: #ddd;
      padding: 20px 0;
      text-align: center;
    }

    #main {
      flex: 1;
      margin-top: 100px;
    }

    .table {
      margin-top: 50px;
      border-radius: 10px;
    }

    .table th, .table td {
      padding: 10px;
      text-align: center;
    }

    .table-bordered {
      border: 1px solid #dee2e6;
    }

    .table-primary {
      background-color: #0dcaf0;
      color: white;
    }

    h2 {
      color: #3498db;
      font-weight: bold;
      font-size: 28px;
      text-align: center;
      margin-top: 30px;
    }

    .btn-link {
      color: #0dcaf0;
    }

    .btn-link:hover {
      color: #007bff;
    }

    .deleteBtn {
      color: red;
      text-decoration: none;
      font-weight: bold;
    }

    .deleteBtn:hover {
      color: darkred;
    }

    /* Custom Popup Styles */
    .popup {
      position: fixed;
      top: 20px;
      right: 20px;
      background-color: #28a745;
      color: white;
      padding: 15px;
      border-radius: 10px;
      display: none;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
      z-index: 9999;
    }

    .popup.error {
      background-color: #dc3545;
    }

    .popup .close-btn {
      color: white;
      font-size: 20px;
      cursor: pointer;
      font-weight: bold;
    }
  </style>
</head>

<body>

  <!-- Header -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="logo">
        <h1><a href="index.html">Filecrypt <span style="color:#0dcaf0;">Manager</span></a></h1>
      </div>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="ohome.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="upload.jsp">Upload File</a></li>
          <li><a class="nav-link scrollto" href="Manage.jsp">Manage File</a></li>
          <li><a class="nav-link scrollto active" href="userRequest.jsp">User Request</a></li>
          <!--<li><a class="nav-link scrollto" href="refile.jsp">Re-encrypt File</a></li>-->
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <!-- Main Content -->
  <section id="main" class="container">
    <h2>View User File Request</h2>
    <table class="table table-bordered table-hover">
      <thead class="table-primary text-dark">
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>File</th>
          <th>User Request</th>
        </tr>
      </thead>
      <tbody>
        <% 
                    try {
                        String user = session.getAttribute("user").toString(); // Get the logged-in user
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
                        PreparedStatement query = con.prepareStatement("SELECT * FROM urequest WHERE user = ?");
                        query.setString(1, user);
                        ResultSet rs = query.executeQuery();
                        
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("uid") %></td>
                    <td><%= rs.getString("uname") %></td>
                    <td><%= rs.getString("file") %></td>
                    <td>
                        <a href="filacpt.jsp?id=<%= rs.getString("id") %>&uid=<%= rs.getString("uid") %>&file=<%= rs.getString("file") %>" class="btn-link">
                            <%= rs.getString("status") %>
                        </a>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error loading data: " + e.getMessage() + "</td></tr>");
                    }
                %>
      </tbody>
    </table>
  </section>

  <!-- Footer -->
  <footer id="footer">
    <div>&copy; 2024 Filecrypt Manager. All Rights Reserved.</div>
  </footer>

  <!-- Custom Popup -->
  <div id="popupMessage" class="popup">
    <span class="close-btn" onclick="closePopup()">×</span>
    <span id="popupContent"></span>
  </div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <script>
    // Function to show the popup with a message
    function showPopup(message, isError) {
      const popup = document.getElementById('popupMessage');
      const popupContent = document.getElementById('popupContent');
      popupContent.textContent = message;
      if (isError) {
        popup.classList.add('error');
      } else {
        popup.classList.remove('error');
      }
      popup.style.display = 'block';
      setTimeout(() => {
        popup.style.display = 'none';
      }, 5000); // Hide the popup after 5 seconds
    }

    // Close the popup
    function closePopup() {
      document.getElementById('popupMessage').style.display = 'none';
    }

    // Check if there's a success or error message in the request
    document.addEventListener('DOMContentLoaded', function () {
      <% if (request.getAttribute("popupMessage") != null) { %>
        const message = "<%= request.getAttribute("popupMessage") %>";
        const isError = "<%= request.getAttribute("isError") != null ? request.getAttribute("isError") : "false" %>" === "true";
        showPopup(message, isError);
      <% } %>
    });
  </script>

</body>

</html>
