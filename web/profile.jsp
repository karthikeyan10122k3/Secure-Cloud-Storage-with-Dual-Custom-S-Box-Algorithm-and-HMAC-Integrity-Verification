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
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Poppins:300,400,600,700" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/fontawesome/css/all.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <style>
    /* General Layout Enhancements */
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column;
    }

    #main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    /* Profile Section */
    .profile-section {
      width: 100%;
      max-width: 600px;
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      margin-top: 50px;
    }

    h2.profile-title {
      text-align: center;
      color: #3498db;
      font-size: 24px;
      font-weight: bolder;
    }

    .profile-table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }

    .profile-table th {
      background-color: #0dcaf0;
      color: white;
      padding: 12px;
      text-align: left;
    }

    .profile-table td {
      padding: 8px 12px;
      background-color: #f1f1f1;
      font-size: 14px;
    }

    .profile-table td img {
      border-radius: 50%;
      width: 80px;
      height: 80px;
    }

    /* Header Styling */
    #header {
      background-color: #007bff;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .navbar ul li a {
      color: #fff;
      transition: color 0.3s, background-color 0.3s;
    }

    .navbar ul li a:hover {
      background-color: #fff;
      color: #007bff;
      border-radius: 4px;
    }

    /* Footer Styling */
    #footer {
      background: #00263b;
      color: #ddd;
      padding: 20px 0;
      text-align: center;
    }
  </style>

</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="logo">
        <h1><a href="index.html">Filecrypt Manager</a></h1>
      </div>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="uhome.jsp">Home</a></li>
          <li><a class="nav-link scrollto active" href="profile.jsp">Profile</a></li>
          <li><a class="nav-link scrollto" href="file.jsp">Uploaded Files</a></li>
          <li><a class="nav-link scrollto" href="download.jsp">Download file</a></li>
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- ======= Profile Section ======= -->
  <div id="main">
    <section class="profile-section">
        <br>
      <h2 class="profile-title">User Profile</h2>

      <%
        String user = session.getAttribute("user").toString();
        String id = session.getAttribute("id").toString();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
        PreparedStatement query = con.prepareStatement("select * from ureg Where id='" + id + "' and user='" + user + "'");
        ResultSet rs = query.executeQuery();
        
        while (rs.next()) {
      %>

      <table class="profile-table">
        <tr align="center">
          <td colspan="2"><img src="profile/<%= rs.getString("profile") %>" alt="profile image"></td>
        </tr>
        <tr><th>ID</th><td><%= rs.getString("id") %></td></tr>
        <tr><th>Username</th><td><%= rs.getString("user") %></td></tr>
        <tr><th>Password</th><td><%= rs.getString("pass") %></td></tr>
        <tr><th>Email</th><td><%= rs.getString("email") %></td></tr>
        <tr><th>Mobile</th><td><%= rs.getString("mobile") %></td></tr>
        <tr><th>Location</th><td><%= rs.getString("location") %></td></tr>
      </table>

      <% } %>
    </section>
  </div><!-- End Profile Section -->

  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="container">
      <div class="row d-flex align-items-center justify-content-center">
        <div class="col-lg-6 text-center">
          <div class="copyright">
            &copy; 2024 Filecrypt Manager. All Rights Reserved.
          </div>
        </div>
      </div>
    </div>
  </footer><!-- End Footer -->

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
