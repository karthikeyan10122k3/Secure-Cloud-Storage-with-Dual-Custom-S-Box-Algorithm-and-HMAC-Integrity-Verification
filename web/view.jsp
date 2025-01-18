<!--valid-->
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.sql.*"%>

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

  <!-- Custom Styles -->
  <style>
    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
    }
    #main {
      flex: 1;
    }

    /* Header Styling */
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

    /* Main Section */
    main {
      margin-top: 100px;
    }

    h3 {
      color: #007bff;
      font-weight: bold;
    }

    textarea {
      border: 2px solid #0dcaf0;
      border-radius: 8px;
      padding: 10px;
      width: 100%;
      max-width: 500px;
      height: 250px;
    }

    .btn {
      background-color: #007bff;
      color: white;
      border-radius: 5px;
      padding: 8px 16px;
      border: none;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .btn:hover {
      background-color: #0056b3;
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
          <li><a class="nav-link scrollto" href="ahome.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="profile.jsp">Profile</a></li>
          <li><a class="nav-link scrollto active" href="file.jsp">Files</a></li>
          <li><a class="nav-link scrollto" href="download.jsp">Download File</a></li>
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>

    </div>
  </header>

  <!-- ======= Main Section ======= -->
  <main id="main" class="d-flex align-items-center justify-content-center">
    <section class="container text-center">
      <% 
        String file = request.getParameter("file");
        String txtFilePath = "C:\\SecuredCloudStorage\\EncryptedFiles\\" + file;
        BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
          sb.append(line).append("\n");
        }
        String book = sb.toString();
      %>
      <h3><%=file%></h3>
      <form action="file.jsp">
        <input type="hidden" name="file" value="<%=file%>" readonly="">
        <textarea readonly><%=book%></textarea><br><br>
        <input class="btn" type="submit" value="Back to Files">
      </form>
    </section>
  </main>

  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="container">
      <span>&copy; 2024 Filecrypt Manager. All Rights Reserved.</span>
    </div>
  </footer>

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
