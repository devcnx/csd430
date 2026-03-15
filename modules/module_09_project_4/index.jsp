<%-- 
    CSD430 Server-Side Development

    Module 9 Project Part 4: CRUD-DELETE Operations
    Author: Brittaney Perry-Morgan

    Description: Course index page with navigation to movie database
    application demonstrating JDBC connectivity and JavaBeans for
    CRUD-DELETE operations.

    index.jsp - Course Index Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 9 Project Part 4 - CRUD-DELETE Operations</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 9 Project Part 4</h1>
        <h2>JDBC & JavaBeans - <em>CRUD-DELETE Operations</em></h2>
        <p class="description">Author: Brittaney Perry-Morgan</p>
    </div>

    <div class="container">
        <h3>Movie Database CRUD Operations</h3>
        <p class="description">
            This web application demonstrates database connectivity using JDBC
            and JavaBeans for Create, Read, Update, and Delete (CRUD) operations.
            Module 9 focuses on <strong>DELETE</strong> operations - removing
            movie records from the database.
        </p>

        <h3>Database Information</h3>
        <ul class="field-descriptions">
            <li><strong>Database Name:</strong> CSD430</li>
            <li><strong>Table Name:</strong> brittaney_movies_data</li>
            <li><strong>Username:</strong> student1</li>
            <li><strong>Topic:</strong> Movies</li>
            <li><strong>Fields:</strong> 6 (movie_id, title, genre, release_year, rating, director)</li>
        </ul>

        <h3>Navigation - DELETE Operations</h3>
        <nav>
            <ul>
                <li>
                    <a href="movieDelete.jsp">Delete Movie</a>
                    <span class="nav-desc">Select a movie to delete from the database</span>
                </li>
                <li>
                    <a href="/module_05_and_06_project_1/movieSelection.jsp">View Movies (Module 5&6)</a>
                    <span class="nav-desc">View all movie records (READ operation)</span>
                </li>
                <li>
                    <a href="/module_07_project_2/movieForm.jsp">Add Movie (Module 7)</a>
                    <span class="nav-desc">Create a new movie record (CREATE operation)</span>
                </li>
                <li>
                    <a href="/module_08_project_3/movieSelection.jsp">Edit Movie (Module 8)</a>
                    <span class="nav-desc">Update existing movie records (UPDATE operation)</span>
                </li>
            </ul>
        </nav>

        <h3>DELETE Operation Flow</h3>
        <ul class="field-descriptions">
            <li><strong>Step 1:</strong> View all movie records in a table format</li>
            <li><strong>Step 2:</strong> Select a movie ID from the dropdown menu</li>
            <li><strong>Step 3:</strong> Review movie details and confirm deletion</li>
            <li><strong>Step 4:</strong> View remaining records after deletion</li>
            <li><strong>Step 5:</strong> Optionally select another movie to delete</li>
        </ul>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>