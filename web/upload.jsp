<!--valid-->

<!--upload.jsp-->

<%@page import="algo.HMACSHA256"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="algo.KeyDerivation"%> <!-- Import the KeyDerivation class -->

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Upload - FileCrypt Manager</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/ProjectIcon.png" rel="icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

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
    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
    }

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

    section {
      flex: 1;
      padding: 20px;
      margin-top: 150px;
    }

    .container {
      max-width: 960px;
      margin: 0 auto;
    }

    table, tr, th, td {
      border: 1px solid black;
      border-collapse: collapse;
      padding: 8px;
      text-align: left;
    }

    .log input[type="submit"] {
      background-color: #0dcaf0;
      color: white;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s;
    }

    .log input[type="submit"]:hover {
      background-color: #007bff;
    }

    footer {
      background: #00263b;
      color: #ddd;
      padding: 20px 0;
      text-align: center;
    }
    #header{
        display: flex;
        margin-bottom: 50px;
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

 <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">

      <div class="logo">
        <h1><a href="index.html">Filecrypt Manager</a></h1>
      </div>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="ohome.jsp">Home</a></li>
          <li><a class="nav-link scrollto active" href="upload.jsp">Upload File</a></li>
          <li><a class="nav-link scrollto" href="Manage.jsp">Manage File</a></li>
          <li><a class="nav-link scrollto" href="userRequest.jsp">User Request</a></li>
          <!--<li><a class="nav-link scrollto" href="refile.jsp">Re-encrypt file</a></li>-->
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->
  
  <!-- Main Content -->
  <section>
    <div class="container">
      <h2 class="text-center" style="font-size: 25px; font-weight: bolder; color:#3498db;">Upload File</h2>

      <%  
        // Generate unique skey and tkey
        long timestamp = System.currentTimeMillis();
        Random random = new Random();
        String skey = Long.toHexString(timestamp) + Integer.toHexString(random.nextInt(10000));

        HMACSHA256 sha = new HMACSHA256();
        String tkey = sha.hash(skey);

        session.setAttribute("skey", skey);
        session.setAttribute("tkey", tkey);
      %>

      <form action="UploadFile" method="post" enctype="multipart/form-data">
        <table align="center">
          <input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
          <input type="hidden" name="user" value="<%=session.getAttribute("user")%>">
          <input type="hidden" name="email" value="<%=session.getAttribute("email")%>" required>
          <input type="hidden" name="mobile" value="<%=session.getAttribute("mobile")%>" required>

          <tr>
            <td><strong>File Name</strong></td>
            <td><input type="text" name="keyword" style="border-radius: 2px;"></td>
          </tr>
          <tr>
            <td><strong>Hash Key</strong></td>
            <td><input type="text" name="tkey" value="<%=tkey%>" style="border-radius: 2px;"></td>
          </tr>
          <tr>
            <td><strong>Secret Key</strong></td>
            <td><input type="text" name="skey" value="<%=skey%>" style="border-radius: 2px;"></td>
          </tr>
          <tr>
            <td><strong>Upload File</strong></td>
            <td><input type="file" name="file" style="border-radius: 2px;"></td>
          </tr>
          <tr>
            <td colspan="2" align="center">
              <input type="submit" value="Upload" style="border-radius: 2px; width: 100px; height: 30px;">
            </td>
          </tr>
        </table>
      </form>
    </div>
  </section>

  <!-- Notification -->
  <div id="notification"></div>

  <!-- Footer -->
  <footer>
    <div class="container">
      <div class="row d-flex align-items-center justify-content-center">
        <div class="col-lg-6 text-center">
          <div class="copyright">
            &copy; 2024 Filecrypt Manager. All Rights Reserved.
          </div>
        </div>
      </div>
    </div>
  </footer>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

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
