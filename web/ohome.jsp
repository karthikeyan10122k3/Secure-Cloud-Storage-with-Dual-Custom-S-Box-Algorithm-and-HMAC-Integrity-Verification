<!--valid-->
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
    /* General Layout Enhancements */
    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
    }
    #main {
      flex: 1; /* Ensures the main content takes up available space */
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

    /* Hero Section Enhancements */
    #hero {
      background: url('assets/img/hero-bg.jpg') center center / cover no-repeat;
      color: #fff;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);
      padding: 100px 0;
    }
    #hero h2 {
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 20px;
    }
    #hero .hero-img img {
      border-radius: 10px;
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    }

    /* Table Style for Forms */
    table, tr, td {
      color: black;
      font-size: 15px;
      font-weight: bold;
      padding: 5px;
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
          <li><a class="nav-link scrollto active" href="ohome.jsp">Home</a></li>
          <li><a class="nav-link scrollto" href="upload.jsp">Upload File</a></li>
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
  <div id="main">
    <!-- ======= Hero Section ======= -->
    <section id="hero" class="d-flex align-items-center">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 pt-5 pt-lg-0 order-2 order-lg-1 d-flex flex-column justify-content-center">
               <%String user=session.getAttribute("user").toString();%>
            <h2>Welcome <%= user %> !!!!</h2>
          </div>
          <div class="col-lg-6 order-1 order-lg-2 hero-img" data-aos="fade-left" data-aos-delay="200">
            <img src="assets/img/hero-img.png" class="img-fluid animated" alt="">
          </div>
        </div>
      </div>
    </section><!-- End Hero -->
  </div><!-- End Main Content -->

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

