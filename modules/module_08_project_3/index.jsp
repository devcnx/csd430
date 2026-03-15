<%-- 
    CSD430 Server-Side Development

    Module 8 Project Part 3: CRUD-UPDATE Operations
    Author: Brittaney Perry-Morgan

    Description: Course index page with navigation to movie database
    application demonstrating JDBC connectivity and JavaBeans for
    CRUD-UPDATE operations.

    index.jsp - Course Index Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 8 Project Part 3 - CRUD-UPDATE Operations</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 8 Project Part 3</h1>
        <h2>JDBC & JavaBeans - <em>CRUD-UPDATE Operations</em></h2>
        <p class="description">Author: Brittaney Perry-Morgan</p>
    </div>

    <div class="container">
        <h3>Movie Database CRUD Operations</h3>
        <p class="description">
            This web application demonstrates database connectivity using JDBC
            and JavaBeans for Create, Read, Update, and Delete (CRUD) operations.
            Module 8 focuses on <strong>UPDATE</strong> operations - modifying
            existing movie records.
        </p>

        <h3>Database Information</h3>
        <ul class="field-descriptions">
            <li><strong>Database Name:</strong> CSD430</li>
            <li><strong>Table Name:</strong> brittaney_movies_data</li>
            <li><strong>Username:</strong> student1</li>
            <li><strong>Topic:</strong> Movies</li>
            <li><strong>Fields:</strong> 6 (movie_id, title, genre, release_year, rating, director)</li>
        </ul>

        <h3>Navigation - UPDATE Operations</h3>
        <nav>
            <ul>
                <li>
                    <a href="movieSelection.jsp">Edit Movie</a>
                    <span class="nav-desc">Select a movie from dropdown to edit</span>
                </li>
                <li>
                    <a href="movieDisplay.jsp">View All Movies</a>
                    <span class="nav-desc">Display all movie records with edit links</span>
                </li>
                <li>
                    <a href="/module_05_and_06_project_1/movieSelection.jsp">View Movie Details (Module 5&6)</a>
                    <span class="nav-desc">READ operation - view individual movie details</span>
                </li>
                <li>
                    <a href="/module_07_project_2/movieForm.jsp">Add New Movie (Module 7)</a>
                    <span class="nav-desc">CREATE operation - add a new movie record</span>
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
