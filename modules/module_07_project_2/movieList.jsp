<%-- 
    CSD430 Server-Side Development

    Module 7 Project Part 2: CRUD-CREATE Operations
    Author: Brittaney Perry-Morgan

    Description: Displays all movies from the database in an HTML table.
    Demonstrates READ operation after CREATE to verify the new record.

    movieList.jsp - Movie List Display Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie List - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        .success-message {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 15px;
            margin: 20px;
            border-radius: 6px;
            text-align: center;
        }
        .error-message {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 15px;
            margin: 20px;
            border-radius: 6px;
            text-align: center;
        }
        .record-count {
            text-align: center;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container top-title">
        <h1>Module 7 Project Part 2</h1>
        <h2>Movie Database - <em>READ Operation</em></h2>
        <p class="description">Displaying all movie records from the database.</p>
    </div>

    <div class="container">
<%
        MovieBean movieBean = new MovieBean();
        boolean connected = movieBean.connect();
        int recordCount = 0;
        
        if (!connected) {
%>
        <div class="error-message">
            <p>Database Connection Error:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
<%
        } else {
            // Get all movies for display
            boolean success = movieBean.getAllMovies();
            
            if (!success) {
%>
        <div class="error-message">
            <p>Error retrieving movie data:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
<%
            } else {
                // First pass: count records
                while (movieBean.next()) {
                    recordCount++;
                }
                movieBean.disconnect();
%>

        <p class="record-count">Total Records: <%= recordCount %></p>

        <table>
            <thead>
                <tr>
                    <th>Movie ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Release Year</th>
                    <th>Rating</th>
                    <th>Director</th>
                </tr>
            </thead>
            <tbody>
<%
                // Second pass: display records
                movieBean.connect();
                movieBean.getAllMovies();
                while (movieBean.next()) {
%>
                <tr>
                    <td><%= movieBean.getMovieId() %></td>
                    <td><%= movieBean.getTitle() %></td>
                    <td><%= movieBean.getGenre() %></td>
                    <td><%= movieBean.getReleaseYear() %></td>
                    <td><%= movieBean.getRating() %></td>
                    <td><%= movieBean.getDirector() %></td>
                </tr>
<%
                }
                movieBean.disconnect();
%>
            </tbody>
        </table>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier for each movie (Primary Key, Auto-increment)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category or type of the movie</li>
            <li><strong>Release Year:</strong> The year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating (G, PG, PG-13, R, NC-17)</li>
            <li><strong>Director:</strong> The director of the movie</li>
        </ul>
<%
            }
        }
%>

        <div class="form-actions">
            <a href="movieForm.jsp" class="btn-submit">Add New Movie</a>
            <a href="/module_08_project_3/movieSelection.jsp" class="btn-reset">Edit Movie (Module 8)</a>
            <a href="/module_09_project_4/movieDelete.jsp" class="btn-reset" style="background-color: #dc3545;">Delete Movie (Module 9)</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>