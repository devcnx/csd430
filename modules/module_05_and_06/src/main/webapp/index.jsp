<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%--
    CSD430 Server-Side Development

    Module 5 & 6: JDBC & JavaBeans - CRUD READ Operations
    Author: Brittaney Perry-Morgan
    
    Description: Main entry point for Module 5 & 6 assignments.
    Provides access to movie database CRUD operations using JDBC.

    index.jsp - Main landing page for Module 5 & 6
--%>
<!DOCTYPE html>
<html>
<head>
    <title>CSD430 Module 5 & 6: Home</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Welcome to CSD430 Module 5 & 6</h1>
        <p>
            <strong>Assignments:</strong> JDBC & JavaBeans - CRUD READ Operations<br>
            <strong>Author:</strong> Brittaney Perry-Morgan<br>
        </p>
    </header>
    <main>
        <div class="container">
            <h2>Movie Database CRUD Operations</h2>
            <p class="description">
                This web application demonstrates database connectivity using JDBC and JavaBeans
                for Create, Read, Update, and Delete (CRUD) operations.
            </p>
            
            <div class="database-info">
                <h3>Database Information</h3>
                <ul>
                    <li><strong>Database Name:</strong> CSD430</li>
                    <li><strong>Table Name:</strong> brittaney_perry_morgan_data</li>
                    <li><strong>Username:</strong> student1</li>
                    <li><strong>Topic:</strong> Movies</li>
                    <li><strong>Records:</strong> 10 movie records with 5 fields each</li>
                </ul>
            </div>
        </div>

        <div class="container">
            <h3>Navigation - READ Operations</h3>
            <nav>
                <ul>
                    <li><a href="movieList.jsp">View All Movies</a> - Display all movie records from the database</li>
                    <li><a href="movieSearch.jsp">Search Movies</a> - Search for movies by title, genre, or year</li>
                    <li><a href="movieByGenre.jsp">Movies by Genre</a> - Filter movies by genre</li>
                </ul>
            </nav>
        </div>

        <div class="container">
            <h3>Other Modules</h3>
            <nav>
                <ul>
                    <li><a href="../../module_01/src/main/webapp/index.jsp">Module 1: Introduction</a></li>
                    <li><a href="../../module_02/src/main/webapp/index.jsp">Module 2: Servlets</a></li>
                    <li><a href="../../module_03/src/main/webapp/index.jsp">Module 3: JSP</a></li>
                    <li><a href="../../module_04/src/main/webapp/index.jsp">Module 4: JavaBeans</a></li>
                    <li><strong>Module 5 & 6: JDBC (Current)</strong></li>
                </ul>
            </nav>
        </div>

        <div class="container">
            <h3>SQL Script</h3>
            <p>Run the following SQL script to create and populate the database:</p>
            <a href="sql/brittaney_perry_morgan_data.sql" download>Download SQL Script</a>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>