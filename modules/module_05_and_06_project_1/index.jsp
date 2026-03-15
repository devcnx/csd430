<%-- 
    CSD430 Server-Side Development

    Module 5 & 6 Project Part 1: CRUD-READ Operations
    Author: Brittaney Perry-Morgan

    Description: Course index page with navigation to movie database
    application demonstrating JDBC connectivity and JavaBeans.

    index.jsp - Course Index Page
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 5 & 6 Project Part 1 - CRUD-READ Operations</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 5 & 6 Assignment</h1>
        <h2>JDBC & JavaBeans - <em>CRUD READ Operations</em></h2>
        <p class="description">Author: Brittaney Perry-Morgan</p>
    </div>

    <div class="container">
        <h3>Movie Database CRUD Operations</h3>
        <p class="description">
            This web application demonstrates database connectivity using JDBC
            and JavaBeans for Create, Read, Update, and Delete (CRUD) operations.
        </p>

        <h3>Database Information</h3>
        <ul class="field-descriptions">
            <li><strong>Database Name:</strong> CSD430</li>
            <li><strong>Table Name:</strong> brittaney_movies_data</li>
            <li><strong>Username:</strong> student1</li>
            <li><strong>Topic:</strong> Movies</li>
            <li><strong>Records:</strong> 10 movie records with 6 fields each</li>
        </ul>

        <h3>Navigation - READ Operations</h3>
        <nav>
            <ul>
                <li>
                    <a href="movieSelection.jsp">Movie Selection Form</a>
                    <span class="nav-desc">Select a movie ID from dropdown to view details</span>
                </li>
                <li>
                    <a href="/module_07_project_2/movieForm.jsp">Add New Movie (Module 7)</a>
                    <span class="nav-desc">CREATE operation - add a new movie record</span>
                </li>
                <li>
                    <a href="/module_08_project_3/movieSelection.jsp">Edit Movie (Module 8)</a>
                    <span class="nav-desc">UPDATE operation - modify existing records</span>
                </li>
                <li>
                    <a href="/module_09_project_4/movieDelete.jsp">Delete Movie (Module 9)</a>
                    <span class="nav-desc">DELETE operation - remove records</span>
                </li>
            </ul>
        </nav>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>