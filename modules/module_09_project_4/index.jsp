<%--
    Module 09 Index Page - CSD430
    Student: Brittaney Perry-Morgan
    Links to all CRUD operations for the movie database
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 09 - DELETE Operation - CSD430</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            text-align: center;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 10px;
        }
        h2 {
            color: #666;
            text-align: center;
            font-weight: normal;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .crud-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        .crud-link {
            display: block;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .crud-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .create-link {
            background-color: #28a745;
            color: white;
        }
        .read-link {
            background-color: #17a2b8;
            color: white;
        }
        .update-link {
            background-color: #ffc107;
            color: #333;
        }
        .delete-link {
            background-color: #dc3545;
            color: white;
        }
        .module-info {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
        }
        .highlight {
            background-color: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 5px;
            padding: 15px;
            margin-top: 20px;
        }
        .highlight h3 {
            margin-top: 0;
            color: #856404;
        }
        .footer {
            text-align: center;
            color: #666;
            margin-top: 30px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>Module 09: DELETE Operation</h1>
    <h2>Brittaney Perry-Morgan | CSD430 Server-Side Development</h2>

    <div class="container">
        <p class="module-info">
            This module implements the <strong>DELETE</strong> operation of the CRUD application.
            Users can select a movie from a dropdown, view its details, and confirm deletion.
        </p>

        <div class="crud-grid">
            <a href="../module_05_and_06_project_1/movie_selection.jsp" class="crud-link read-link">
                READ<br>View Movies
            </a>
            <a href="../module_07_project_2/movie_form.jsp" class="crud-link create-link">
                CREATE<br>Add Movie
            </a>
            <a href="../module_08_project_3/movie_update.jsp" class="crud-link update-link">
                UPDATE<br>Edit Movie
            </a>
            <a href="movie_delete.jsp" class="crud-link delete-link">
                DELETE<br>Remove Movie
            </a>
        </div>

        <div class="highlight">
            <h3>&#9888; Current Module: DELETE</h3>
            <p>The DELETE operation allows you to permanently remove a movie record from the database.</p>
            <p><strong>Features implemented:</strong></p>
            <ul style="text-align: left; margin: 10px 0;">
                <li>Dropdown selection for movie ID</li>
                <li>Confirmation page showing movie details</li>
                <li>Warning message before deletion</li>
                <li>JavaScript confirmation dialog</li>
                <li>Success/Error feedback after deletion</li>
                <li>Database integrity check (movieExists method)</li>
            </ul>
        </div>
    </div>

    <div class="footer">
        <p>Module 09 Assignment - CSD430 Server-Side Development | Brittney Perry-Morgan</p>
    </div>

</body>
</html>