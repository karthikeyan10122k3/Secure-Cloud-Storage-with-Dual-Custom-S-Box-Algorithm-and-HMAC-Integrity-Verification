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
    /* General styling */
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
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
      margin-top: auto; /* This ensures the footer stays at the bottom */
    }

    #main {
      padding: 30px 50px;
      background-color: #fff;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      margin-top: 70px;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      flex-grow: 1; /* Ensures the main content takes up remaining space */
    }

    h2 {
      color: #3498db;
      text-align: center;
      font-size: 28px;
      margin-bottom: 20px;
    }

    .form-container {
      width: 100%;
      max-width: 500px;
    }

    .form-container label,
    .form-container input[type="text"],
    .form-container input[type="submit"] {
      display: block;
      width: 100%;
      max-width: 400px;
      margin-bottom: 15px;
    }

    .form-container input[type="text"] {
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    .form-container input[type="submit"] {
      padding: 10px 20px;
      background-color: #0dcaf0;
      color: white;
      font-size: 16px;
      border: none;
      cursor: pointer;
      border-radius: 5px;
    }

    .form-container input[type="submit"]:hover {
      background-color: #007bff;
    }

    .back-btn {
      background-color: #0dcaf0;
      color: white;
      padding: 10px 20px;
      border-radius: 5px;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin-top: 20px;
    }

    .back-btn:hover {
      background-color: #007bff;
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
          <li><a class="nav-link scrollto" href="profile.jsp">Profile</a></li>
          <li><a class="nav-link scrollto" href="file.jsp">Uploaded Files</a></li>
          <li><a class="nav-link scrollto active" href="download.jsp">Download File</a></li>
          <li><a class="nav-link scrollto" href="index.html">Logout</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <!-- Main Content -->
  <section id="main">
    <h2>Enter Key and Download File</h2>

    <form action="download2.jsp">
      <input type="hidden" name="file" value="<%= request.getParameter("file") %>">
      <input type="hidden" name="ske" value="<%= request.getParameter("skey") %>">
      <input type="hidden" name="dke" value="<%= request.getParameter("tkey") %>">

      <div class="form-container">
        <label for="tkey">Decryption Key:</label>
        <input type="text" name="tkey" id="tkey" placeholder="Enter Decryption Key" required>

        <label for="skey">Secret Key:</label>
        <input type="text" name="skey" id="skey" placeholder="Enter Secret Key" required>

        <input type="submit" value="Download">
      </div>
    </form>

    <a href="download.jsp" class="back-btn bg-danger">Back</a>
  </section>

  <!-- Footer -->
  <footer id="footer">
    <div>&copy; 2024 Filecrypt Manager. All Rights Reserved.</div>
  </footer>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/js/main.js"></script>
</body>

</html>