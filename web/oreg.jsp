<!--valid-->

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Filecrypt Manager</title>

  <link href="assets/img/ProjectIcon.png" rel="icon">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
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

    /* Form Section Styling */
    .form-section {
      padding: 100px 0;
    }

    .form-label {
      font-weight: bold;
    }

    /* Form Styling */
    input[type="text"], input[type="password"], input[type="file"] {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 5px;
      border: 1px solid #ccc;
    }

    /* Gender Radio Buttons */
    .form-check-inline {
      margin-right: 10px;
    }

    /* Submit Button Styling */
    .form-section .text-center button {
      background-color: #0dcaf0;
      color: white;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
    .form-section .text-center button:hover {
      background-color: #007bff;
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

  <!-- Header -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="logo">
        <h1><a href="index.html">Filecrypt Manager</a></h1>
      </div>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto" href="index.html">Home</a></li>
          <li><a class="nav-link scrollto active" href="owner.jsp">Data Owner</a></li>
          <li><a class="nav-link scrollto" href="user.jsp">Data Users</a></li>
          <li><a class="nav-link scrollto" href="authority.jsp">TA</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- Main Section -->
  <main id="main">
    <section class="form-section">
      <div class="container">
        <h2 style="color: #3498db; text-align: center; font-size: 25px; font-weight: bold;">Owner Registration Page</h2>
        <form action="oregaction" method="post" enctype="multipart/form-data" style="max-width: 600px; margin: 0 auto;">
          <div class="mb-3">
            <label for="profile" class="form-label"><strong>Select Profile</strong></label>
            <input type="file" name="user" id="profile" class="form-control">
          </div>
          <div class="mb-3">
            <label for="id" class="form-label"><strong>ID</strong></label>
            <input type="text" name="id" id="id" class="form-control">
          </div>
          <div class="mb-3">
            <label for="username" class="form-label"><strong>Username</strong></label>
            <input type="text" name="user" id="username" class="form-control">
          </div>
          <div class="mb-3">
            <label for="password" class="form-label"><strong>Password</strong></label>
            <input type="password" name="pass" id="password" class="form-control">
          </div>
          <div class="mb-3">
            <label for="email" class="form-label"><strong>Email</strong></label>
            <input type="text" name="email" id="email" class="form-control">
          </div>
          <div class="mb-3">
            <label for="dob" class="form-label"><strong>Date of Birth</strong></label>
            <input type="text" name="dob" id="dob" class="form-control">
          </div>
          <div class="mb-3">
            <label class="form-label"><strong>Gender</strong></label><br>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" value="male" id="male">
              <label class="form-check-label" for="male">Male</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" value="female" id="female">
              <label class="form-check-label" for="female">Female</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" value="other" id="other">
              <label class="form-check-label" for="other">Other</label>
            </div>
          </div>
          <div class="mb-3">
            <label for="mobile" class="form-label"><strong>Mobile</strong></label>
            <input type="text" name="mobile" id="mobile" class="form-control">
          </div>
          <div class="mb-3">
            <label for="location" class="form-label"><strong>Location</strong></label>
            <input type="text" name="location" id="location" class="form-control">
          </div>
          <div class="text-center">
            <button type="submit" class="btn btn-primary">Register</button>
          </div>
        </form>
      </div>
    </section>
  </main>

  <!-- Footer -->
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
  </footer>

  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
