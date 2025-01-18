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

  <!-- Favicons -->
  <link href="assets/img/ProjectIcon.png" rel="icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

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
      width: 100%;
      margin-top: 40px;
    }

    table, th, td {
      border: 1px solid #ddd;
      border-collapse: collapse;
      padding: 8px;
    }

    th {
      background-color: #0dcaf0;
      color: #fff;
      text-align: center;
    }

    td {
      text-align: center;
    }

    a {
      text-decoration: none;
    }

    .deleteBtn {
      color: #dc3545;
      font-weight: bold;
    }

    .btn {
      padding: 6px 12px;
      font-size: 14px;
    }

    .btn-danger {
      color: #fff;
      background-color: #dc3545;
      border-color: #dc3545;
    }

    .btn-danger:hover {
      background-color: #c82333;
      border-color: #c82333;
    }

    .table-hover tbody tr:hover {
      background-color: #f1f1f1;
    }

    /* Toast styles */
    #toast-container {
      max-width: 350px;
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
          <li><a class="nav-link active" href="file.jsp">Uploaded Files</a></li>
          <li><a class="nav-link" href="download.jsp">Download File</a></li>
          <li><a class="nav-link" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- Toast Notification -->
  <div id="toast-container" class="position-fixed top-0 end-0 p-3" style="z-index: 1055;">
    <div id="customToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header">
        <strong id="toastTitle" class="me-auto"></strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div id="toastMessage" class="toast-body"></div>
    </div>
  </div>

  <!-- Main Content -->
  <section id="main" class="container">
    <h2 class="text-center text-primary fw-bold">View All Uploaded Files</h2>
    <table class="table table-bordered table-hover mt-4">
      <thead class="table-primary text-center">
          <tr>
          <th class="text-dark">Owner ID</th>
          <th class="text-dark">Owner Name</th>
          <th class="text-dark">Keyword</th>
          <th class="text-dark">File</th>
          <th class="text-dark">Action</th>
        </tr>
      </thead>
      <tbody>
        <%
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");
          PreparedStatement query = con.prepareStatement("SELECT * FROM upload");
          ResultSet rs = query.executeQuery();

          while (rs.next()) {
        %>
        <tr>
          <td><%= rs.getString("id") %></td>
          <td><%= rs.getString("user") %></td>
          <td><%= rs.getString("keyword") %></td>
          <td><a href="view.jsp?file=<%= rs.getString("file") %>"><%= rs.getString("file") %></a></td>
          <td>
            <a href="Rqstfile.jsp?id=<%= rs.getString("id") %>&user=<%= rs.getString("user") %>&skey=<%= rs.getString("skey") %>&tkey=<%= rs.getString("tkey") %>&keyword=<%= rs.getString("keyword") %>&file=<%= rs.getString("file") %>" class="btn btn-danger btn-sm">Send Request</a>
          </td>
        </tr>
        <% 
          }
        %>
      </tbody>
    </table>
  </section>

  <!-- Footer -->
  <footer id="footer" class="text-center">
    <div>&copy; 2024 Filecrypt Manager. All Rights Reserved.</div>
  </footer>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <script>
    // Function to show a toast notification
    function showToast(type, message) {
      const toastElement = document.getElementById('customToast');
      const toastTitle = document.getElementById('toastTitle');
      const toastMessage = document.getElementById('toastMessage');

      // Customize based on the type of notification
      if (type === 'success') {
        toastTitle.textContent = 'Success';
        toastElement.classList.add('bg-success', 'text-white');
      } else if (type === 'error') {
        toastTitle.textContent = 'Error';
        toastElement.classList.add('bg-danger', 'text-white');
      }

      toastMessage.textContent = message;

      // Show the toast
      const toast = new bootstrap.Toast(toastElement);
      toast.show();
    }

    // Check for query parameters
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('toast')) {
      const toastType = urlParams.get('toast');
      const toastMessage = urlParams.get('message') || '';
      showToast(toastType, toastMessage);
    }
  </script>

</body>

</html>
