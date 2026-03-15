<%-- 
    CSD430 Server-Side Development

    Module 7 Project Part 2: CRUD-CREATE Operations
    Author: Brittaney Perry-Morgan

    Description: Course index page with navigation to movie database
    application demonstrating JDBC connectivity and JavaBeans for
    CRUD-CREATE operations.

    index.jsp - Course Index Page
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 7 Project Part 2 - CRUD-CREATE Operations</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 7 Project Part 2</h1>
        <h2>JDBC & JavaBeans - <em>CRUD-CREATE Operations</em></h2>
        <p class="description">Author: Brittaney Perry-Morgan</p>
    </div>

    <div class="container">
        <h3>Movie Database CRUD Operations</h3>
        <p class="description">
            This web application demonstrates database connectivity using JDBC
            and JavaBeans for Create, Read, Update, and Delete (CRUD) operations.
            Module 7 focuses on <strong>CREATE</strong> operations - adding new
            records to the database.
        </p>

        <h3>Database Information</h3>
        <ul class="field-descriptions">
            <li><strong>Database Name:</strong> CSD430</li>
            <li><strong>Table Name:</strong> brittaney_movies_data</li>
            <li><strong>Username:</strong> student1</li>
            <li><strong>Topic:</strong> Movies</li>
            <li><strong>Fields:</strong> 6 (movie_id, title, genre, release_year, rating, director)</li>
        </ul>

        <h3>Navigation - CREATE Operations</h3>
        <nav>
            <ul>
                <li>
                    <a href="movieForm.jsp">Add New Movie</a>
                    <span class="nav-desc">Form to add a new movie record to the database</span>
                </li>
                <li>
                    <a href="movieList.jsp">View All Movies</a>
                    <span class="nav-desc">Display all movie records in table format</span>
                </li>
                <li>
                    <a href="/module_05_and_06_project_1/movieSelection.jsp">View Movie Details (Module 5&6)</a>
                    <span class="nav-desc">READ operation - view individual movie details</span>
                </li>
                <li>
                    <a href="/module_08_project_3/movieSelection.jsp">Edit Movie (Module 8)</a>
                    <span class="nav-desc">UPDATE operation - modify existing records</span>
                </li>
                <li>
                    <a href="/module_09_project_4/movieDelete.jsp">Delete Movie (Module 9)</a>
                    <span class="nav-desc">DELETE operation - remove records from database</span>
                </li>
            </ul>
        </nav>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>