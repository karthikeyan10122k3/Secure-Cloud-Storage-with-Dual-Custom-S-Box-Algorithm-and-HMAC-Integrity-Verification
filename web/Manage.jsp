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
    }

    #main {
      flex: 1;
      margin-top: 100px;
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
          <li><a class="nav-link" href="ohome.jsp">Home</a></li>
          <li><a class="nav-link" href="upload.jsp">Upload File</a></li>
          <li><a class="nav-link active" href="Manage.jsp">Manage File</a></li>
          <li><a class="nav-link" href="userRequest.jsp">User Request</a></li>
          <!--<li><a class="nav-link" href="refile.jsp">Re-encrypt File</a></li>-->
          <li><a class="nav-link" href="index.html">Logout</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
    </div>
  </header>

  <!-- Main Content -->
  <section id="main" class="container">
    <h2 class="text-center text-primary fw-bold">View & Manage Files</h2>
    <table class="table table-bordered table-hover mt-4">
      <thead class="table-primary text-center">
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>Email</th>
          <th>Mobile</th>
          <th>File Name</th>
          <th>File</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <%
          Connection con = null;
          PreparedStatement ps = null;
          ResultSet rs = null;

          try {
            String user = session.getAttribute("user").toString();
            String id = session.getAttribute("id").toString();

            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proxy", "root", "root");

            ps = con.prepareStatement("SELECT * FROM upload WHERE id = ? AND user = ?");
            ps.setString(1, id);
            ps.setString(2, user);
            rs = ps.executeQuery();

            while (rs.next()) {
        %>
        <tr>
          <td class="text-center"><%= rs.getString("id") %></td>
          <td class="text-center"><%= rs.getString("user") %></td>
          <td class="text-center"><%= rs.getString("email") %></td>
          <td class="text-center"><%= rs.getString("mobile") %></td>
          <td class="text-center"><%= rs.getString("keyword") %></td>
          <td class="text-center"><%= rs.getString("file") %></td>
          <td class="text-center">
            <a href="#" class="btn btn-danger btn-sm deleteBtn" 
              data-id="<%= rs.getString("id") %>" 
              data-file="<%= rs.getString("file") %>">Delete</a>
          </td>
        </tr>
        <% 
            }
          } catch (Exception e) {
            out.print("Error: " + e.getMessage());
          } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
          }
        %>
      </tbody>
    </table>
  </section>

  <!-- Footer -->
  <footer id="footer" class="text-center">
    <div>&copy; 2024 Filecrypt Manager. All Rights Reserved.</div>
  </footer>

  <!-- Delete Confirmation Modal -->
  <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Confirm Deletion</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          Are you sure you want to delete this file? This action cannot be undone.
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <a id="confirmDelete" class="btn btn-danger" href="#">Delete</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script>
    document.querySelectorAll('.deleteBtn').forEach(button => {
      button.addEventListener('click', function(event) {
        event.preventDefault();
        const id = this.getAttribute('data-id');
        const file = this.getAttribute('data-file');
        const deleteUrl = "Delete_File.jsp?file=" + file + "&id=" + id; 
        document.getElementById('confirmDelete').setAttribute('href', deleteUrl);
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
      });
    });
  </script>

</body>
</html>
