<%-- 
    CSD430 Server-Side Development

    Module 5 & 6 Project Part 1: CRUD-READ Operations
    Author: Brittaney Perry-Morgan

    Description: Displays the selected movie's details in an HTML table
    format with field descriptions.

    movieDisplay.jsp - Movie Details Display Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Details - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 5 & 6 Project Part 1</h1>
        <h2>Movie Database - <em>READ Operation</em></h2>
        <p class="description">Displaying selected movie details from the database.</p>
    </div>

    <div class="container">
<%
        String movieIdParam = request.getParameter("movieId");
        
        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
        <h3>Error</h3>
        <p class="description error">No movie selected. Please go back and select a movie.</p>
<%
        } else {
            int movieId = Integer.parseInt(movieIdParam);
            
            MovieBean movieBean = new MovieBean();
            boolean connected = movieBean.connect();
            
            if (!connected) {
%>
        <h3>Database Connection Error</h3>
        <p class="description error"><%= movieBean.getErrorMessage() %></p>
<%
            } else {
                boolean success = movieBean.getMovieById(movieId);
                
                if (!success) {
%>
        <h3>Error Retrieving Movie</h3>
        <p class="description error"><%= movieBean.getErrorMessage() %></p>
<%
                } else {
%>
        <h3>Movie Details</h3>
        <p class="description">Record ID: <%= movieId %></p>

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
                <tr>
                    <td><%= movieBean.getMovieId() %></td>
                    <td><%= movieBean.getTitle() %></td>
                    <td><%= movieBean.getGenre() %></td>
                    <td><%= movieBean.getReleaseYear() %></td>
                    <td><%= movieBean.getRating() %></td>
                    <td><%= movieBean.getDirector() %></td>
                </tr>
            </tbody>
        </table>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier for each movie (Primary Key)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category or type of the movie</li>
            <li><strong>Release Year:</strong> The year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating (G, PG, PG-13, R, etc.)</li>
            <li><strong>Director:</strong> The director of the movie</li>
        </ul>
<%
                }
                
                movieBean.disconnect();
            }
        }
%>

        <div class="form-actions">
            <a href="movieSelection.jsp" class="btn-submit">Select Another Movie</a>
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie (Module 7)</a>
            <a href="/module_08_project_3/movieSelection.jsp" class="btn-reset">Edit Movie (Module 8)</a>
            <a href="/module_09_project_4/movieDelete.jsp" class="btn-reset" style="background-color: #dc3545;">Delete Movie (Module 9)</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>