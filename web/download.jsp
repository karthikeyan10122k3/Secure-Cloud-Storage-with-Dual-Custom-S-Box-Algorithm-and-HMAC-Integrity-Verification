<!--valid-->
<!--download.jsp-->

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Filecrypt Manager</title>

  <!-- Favicons -->
  <link href="assets/img/ProjectIcon.png" rel="icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">

  <style>
    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      font-family: 'Open Sans', sans-serif;
    }

    #header {
      background: linear-gradient(45deg, #007bff, #0056b3);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    #footer {
      background: #00263b;
      color: #ddd;
      padding: 20px 0;
    }

    #main {
      flex: 1;
      margin-top: 100px;
    }

    table {
      margin: auto;
      width: 80%;
      margin-top: 40px;
    }

    table, th, td {
      border: 1px solid #ddd;
      border-collapse: collapse;
      padding: 10px;
      text-align: center;
    }

    th {
      background-color: #0dcaf0;
      color: #fff;
    }

    .btn {
      padding: 6px 12px;
      font-size: 14px;
    }

    .btn-green {
      background-color: #28a745;
      color: #fff;
    }

    .btn-green:hover {
      background-color: #218838;
    }

    .btn-orange {
      background-color: #fd7e14;
      color: #fff;
    }

    .btn-orange:hover {
      background-color: #e9600c;
    }

    /* Notification Styles */
    #notification {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background-color: #28a745;
      color: white;
      padding: 15px;
      border-radius: 5px;
      display: none;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    #notification.error {
      background-color: #dc3545;
    }
  </style>
</head>

<body>

  <!-- Header -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="logo">
        <h1><a href="index.html">Filecrypt Manager</a></h1>
      </div>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link" href="uhome.jsp">Home</a></li>
          <li><a class="nav-link" href="profile.jsp">Profile</a></li>
          <li><a class="nav-link" href="file.jsp">Uploaded Files</a></li>
          <li><a class="nav-link active" href="download.jsp">Download File</a></li>
          <li><a class="nav-link" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- Main Content -->
  <section id="main" class="container">
    <h2 class="text-center text-primary fw-bold">View Status and Download Files</h2>
    <table class="table table-bordered table-hover mt-4">
      <thead class="table-primary text-center ">
        <tr>
          <th class="text-dark" >Owner ID</th>
          <th class="text-dark" >Data Owner</th>
          <th class="text-dark" >File Name</th>
          <th class="text-dark" >Status</th>
          <th class="text-dark" >Action</th>
        </tr>
      </thead>
      <tbody>
        <%
            String id = session.getAttribute("id").toString();                            	
            String uname = session.getAttribute("user").toString();
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
            PreparedStatement query = con.prepareStatement("SELECT * FROM urequest WHERE uid = ? AND uname = ?");
            query.setString(1, id);
            query.setString(2, uname);

            ResultSet rs = query.executeQuery();

            while (rs.next()) {
                String status = rs.getString("status");
                String buttonClass = status.equalsIgnoreCase("Accepted") ? "btn-green" : "btn-orange";
                String statusColor = status.equalsIgnoreCase("Accepted") ? "green" : "orange";
        %>
        <tr>
          <td><%= rs.getString("id") %></td>
          <td><%= rs.getString("user") %></td>
          <td><%= rs.getString("file") %></td>
          <td style="color: <%= statusColor %>;"><%= status %></td>
          <td>
            <a href="download1.jsp?id=<%= rs.getString("id") %>&user=<%= rs.getString("user") %>&file=<%= rs.getString("file") %>&tkey=<%= rs.getString("tkey") %>&skey=<%= rs.getString("skey") %>" class="btn <%= buttonClass %>">Download</a>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </section>

  <!-- Footer -->
  <footer id="footer" class="text-center">
    <div>&copy; 2024 Filecrypt Manager. All Rights Reserved.</div>
  </footer>

  <!-- Notification -->
  <div id="notification"></div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Notification Display Script -->
  <script>
    function showNotification(message, type) {
      var notification = document.getElementById('notification');
      notification.textContent = message;
      notification.className = type === 'error' ? 'error' : '';
      notification.style.display = 'block';
      
      setTimeout(function() {
        notification.style.display = 'none';
      }, 3000);
    }

    // Example of showing a notification
    <% if (request.getAttribute("notificationMessage") != null) { %>
      showNotification('<%=request.getAttribute("notificationMessage")%>', '<%=request.getAttribute("notificationType")%>');
    <% } %>
  </script>

</body>

</html>
