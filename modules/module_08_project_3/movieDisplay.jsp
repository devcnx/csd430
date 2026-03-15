<%-- 
    CSD430 Server-Side Development

    Module 8 Project Part 3: CRUD-UPDATE Operations
    Author: Brittaney Perry-Morgan

    Description: Displays all movies with edit links for UPDATE operations.
    Users can select a movie to edit its details.

    movieDisplay.jsp - Movie List Display Page
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
</head>
<body>
    <div class="container top-title">
        <h1>Module 8 Project Part 3</h1>
        <h2>Movie Database - <em>UPDATE Operation</em></h2>
        <p class="description">Select a movie to edit its details.</p>
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
            boolean success = movieBean.getAllMovies();
            
            if (!success) {
%>
        <div class="error-message">
            <p>Error retrieving movie data:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
<%
            } else {
                // Count records
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
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
<%
                // Re-query for display
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
                    <td>
                        <a href="movieEdit.jsp?id=<%= movieBean.getMovieId() %>" class="btn-submit">Edit</a>
                    </td>
                </tr>
<%
                }
                movieBean.disconnect();
%>
            </tbody>
        </table>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier (Primary Key)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category of the movie</li>
            <li><strong>Release Year:</strong> Year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating</li>
            <li><strong>Director:</strong> Director of the movie</li>
        </ul>
<%
            }
        }
%>

        <div class="form-actions">
            <a href="movieDisplay.jsp" class="btn-submit">View All Movies</a>
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie</a>
            <a href="/module_09_project_4/movieDelete.jsp" class="btn-reset" style="background-color: #dc3545;">Delete Movie (Module 9)</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>