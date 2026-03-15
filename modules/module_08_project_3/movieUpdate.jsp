<%-- 
    CSD430 Server-Side Development

    Module 8 Project Part 3: CRUD-UPDATE Operations
    Author: Brittaney Perry-Morgan

    Description: Processes the movie update form submission.
    Validates input and updates the record in the database.

    movieUpdate.jsp - Update Processing Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Movie - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 8 Project Part 3</h1>
        <h2>Movie Database - <em>UPDATE Operation</em></h2>
        <p class="description">Processing movie update...</p>
    </div>

    <div class="container">
<%
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        
        // Retrieve form parameters
        String idParam = request.getParameter("movieId");
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String releaseYearStr = request.getParameter("releaseYear");
        String rating = request.getParameter("rating");
        String director = request.getParameter("director");
        
        // Validate movie ID
        int movieId = 0;
        try {
            movieId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
%>
        <div class="error-message">
            <p>Invalid movie ID: <%= idParam %></p>
        </div>
        <div class="form-actions">
            <a href="movieDisplay.jsp" class="btn-submit">View All Movies</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
            return;
        }
        
        // Validate required fields
        StringBuilder errorMsg = new StringBuilder();
        
        if (title == null || title.trim().isEmpty()) {
            errorMsg.append("Movie Title is required.<br>");
        }
        if (genre == null || genre.isEmpty()) {
            errorMsg.append("Genre is required.<br>");
        }
        if (releaseYearStr == null || releaseYearStr.isEmpty()) {
            errorMsg.append("Release Year is required.<br>");
        }
        if (rating == null || rating.isEmpty()) {
            errorMsg.append("Rating is required.<br>");
        }
        if (director == null || director.trim().isEmpty()) {
            errorMsg.append("Director is required.<br>");
        }
        
        if (errorMsg.length() > 0) {
%>
        <div class="error-message">
            <p><%= errorMsg.toString() %></p>
        </div>
        <div class="form-actions">
            <a href="movieEdit.jsp?id=<%= movieId %>" class="btn-submit">Edit Movie</a>
            <a href="movieDisplay.jsp" class="btn-reset">View All Movies</a>
        </div>
<%
            return;
        }
        
        // Parse release year
        int releaseYear = 0;
        try {
            releaseYear = Integer.parseInt(releaseYearStr);
        } catch (NumberFormatException e) {
%>
        <div class="error-message">
            <p>Invalid release year: <%= releaseYearStr %></p>
        </div>
        <div class="form-actions">
            <a href="movieEdit.jsp?id=<%= movieId %>" class="btn-submit">Edit Movie</a>
            <a href="movieDisplay.jsp" class="btn-reset">View All Movies</a>
        </div>
<%
            return;
        }
        
        // Update movie in database
        MovieBean movieBean = new MovieBean();
        boolean connected = movieBean.connect();
        
        if (!connected) {
%>
        <div class="error-message">
            <p>Database connection error: <%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="movieEdit.jsp?id=<%= movieId %>" class="btn-submit">Edit Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
            return;
        }
        
        boolean success = movieBean.updateMovie(movieId, title.trim(), genre, releaseYear, rating, director.trim());
        movieBean.disconnect();
        
        if (success) {
%>
        <div class="success-message">
            <p>Movie updated successfully!</p>
        </div>

        <h3>Updated Movie Details</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Movie ID</strong></td>
                    <td><%= movieId %></td>
                </tr>
                <tr>
                    <td><strong>Title</strong></td>
                    <td><%= title.trim() %></td>
                </tr>
                <tr>
                    <td><strong>Genre</strong></td>
                    <td><%= genre %></td>
                </tr>
                <tr>
                    <td><strong>Release Year</strong></td>
                    <td><%= releaseYear %></td>
                </tr>
                <tr>
                    <td><strong>Rating</strong></td>
                    <td><%= rating %></td>
                </tr>
                <tr>
                    <td><strong>Director</strong></td>
                    <td><%= director.trim() %></td>
                </tr>
            </tbody>
        </table>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier (Primary Key, cannot be changed)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category of the movie</li>
            <li><strong>Release Year:</strong> Year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating</li>
            <li><strong>Director:</strong> Director of the movie</li>
        </ul>

        <div class="form-actions">
            <a href="movieDisplay.jsp" class="btn-submit">View All Movies</a>
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie</a>
            <a href="movieEdit.jsp?id=<%= movieId %>" class="btn-reset">Edit Again</a>
        </div>
<%
        } else {
%>
        <div class="error-message">
            <p>Failed to update movie: <%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="movieEdit.jsp?id=<%= movieId %>" class="btn-submit">Edit Movie</a>
            <a href="movieDisplay.jsp" class="btn-reset">View All Movies</a>
        </div>
<%
        }
%>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>