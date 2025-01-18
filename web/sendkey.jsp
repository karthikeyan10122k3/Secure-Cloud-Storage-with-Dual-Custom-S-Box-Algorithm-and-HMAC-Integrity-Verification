<!--valid-->

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
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/ProjectIcon.png" rel="icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <style>
    /* General Styling */
    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
      font-family: 'Open Sans', sans-serif;
    }

    #main {
      flex: 1;
    }

    /* Header */
    #header {
      background: linear-gradient(45deg, #007bff, #0056b3);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .navbar ul li a {
      color: #fff;
      transition: color 0.3s, background-color 0.3s;
    }

    .navbar ul li a:hover {
      background: #fff;
      color: #007bff;
      border-radius: 4px;
    }

    /* Hero Section */
    h2 {
      color: #3498db;
      text-align: center;
      font-size: 25px;
      font-weight: bolder;
      margin-top: 20px;
    }

    /* Table Styling */
    table {
      margin: 20px auto;
      border-collapse: collapse;
      width: 80%;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }

    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }

    th {
      background-color: #0dcaf0;
      color: #fff;
      font-weight: bold;
    }

    td a {
      color: red;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s ease;
    }

    td a:hover {
      color: #5a2dc1;
      text-decoration: underline;
    }

    td.status {
      color: #00b0ff;
      font-weight: bold;
    }

    /* Footer */
    #footer {
      background: #00263b;
      color: #ddd;
      padding: 20px 0;
      text-align: center;
      margin-top: auto;
    }

    #footer a {
      color: #fff;
      text-decoration: none;
    }

    #footer a:hover {
      text-decoration: underline;
    }

    /* Back to Top Button */
    .back-to-top {
      background: #007bff;
      color: #fff;
    }

    .back-to-top:hover {
      background: #0056b3;
    }
  </style>
</head>

<body>

  <!-- Header -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="logo">
        <h1><a href="index.html">Filecrypt Manager</a></h1>
      </div>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="ahome.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="authowner.jsp">Authorize Owners</a></li>
          <li><a class="nav-link scrollto" href="authuser.jsp">Authorize Users</a></li>
          <li><a class="nav-link scrollto" href="moauth.jsp">Manage Owners</a></li>
          <li><a class="nav-link scrollto" href="muauth.jsp">Manage Users</a></li>
          <li><a class="nav-link scrollto active" href="sendkey.jsp">Send Key</a></li>
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- Hero Section -->
  <section id="main">
      <br>
      <br>
    <h2>View Status and Send Key!</h2>
    <table>
      <tr>
        <th class="text-dark">ID</th>
        <th class="text-dark">Owner Name</th>
        <th class="text-dark">File Name</th>
        <th class="text-dark">User ID</th>
        <th class="text-dark">User Name</th>
        <th class="text-dark">Email</th>
        <th class="text-dark">Status</th>
        <th class="text-dark">Send Key</th>
        <th class="text-dark">Mail Status</th>
        <th class="text-dark">Download Status</th>
      </tr>
      <% 
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
          PreparedStatement query = con.prepareStatement("SELECT * FROM urequest WHERE status='Accepted'");
          ResultSet rs = query.executeQuery();
          while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getString("id") %></td>
        <td><%= rs.getString("user") %></td>
        <td><%= rs.getString("file") %></td>
        <td><%= rs.getString("uid") %></td>
        <td><%= rs.getString("uname") %></td>
        <td><%= rs.getString("email") %></td>
        <td class="status"><%= rs.getString("status") %></td>
        <td><a href="sndky.jsp?file=<%= rs.getString("file") %>&id=<%= rs.getString("id") %>&user=<%= rs.getString("user") %>&email=<%= rs.getString("email") %>">Send Key</a></td>
        <td style="color: <%= "Pending".equals(rs.getString("MailStatus")) ? "orange" : ("Sent".equals(rs.getString("MailStatus")) ? "green" : "black") %>;">
        <%= rs.getString("MailStatus") %>
        </td>

        <td style="color: 
    <%= 
        "Key Not Sent".equals(rs.getString("DownloadStatus")) ? "red" : 
        ("Pending".equals(rs.getString("DownloadStatus")) ? "orange" : 
        ("Downloaded".equals(rs.getString("DownloadStatus")) ? "green" : "black")) 
    %>;">
    <%= rs.getString("DownloadStatus") %>
</td>


      </tr>
      <% 
          }
          rs.close();
          query.close();
          con.close();
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
    </table>
  </section>

  <!-- Footer -->
  <footer id="footer">
    <div class="container">
      &copy; 2024 Filecrypt Manager. All Rights Reserved.
    </div>
  </footer>

  <a href="#" class="back-to-top"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

</body>
</html>
