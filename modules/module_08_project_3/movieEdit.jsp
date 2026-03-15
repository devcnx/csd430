<%-- 
    CSD430 Server-Side Development

    Module 8 Project Part 3: CRUD-UPDATE Operations
    Author: Brittaney Perry-Morgan

    Description: Form to edit an existing movie record. Pre-populated
    with current data from the database.

    movieEdit.jsp - Edit Movie Form Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Movie - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 8 Project Part 3</h1>
        <h2>Movie Database - <em>UPDATE Operation</em></h2>
        <p class="description">Edit the movie details below.</p>
    </div>

    <div class="container">
<%
        String idParam = request.getParameter("id");
        MovieBean movieBean = new MovieBean();
        String errorMessage = null;
        
        // Variables to store movie data
        int movieId = 0;
        String title = "";
        String genre = "";
        int releaseYear = 0;
        String rating = "";
        String director = "";
        
        if (idParam == null || idParam.isEmpty()) {
            errorMessage = "No movie ID provided. Please select a movie to edit.";
        } else {
            try {
                movieId = Integer.parseInt(idParam);
                boolean connected = movieBean.connect();
                
                if (!connected) {
                    errorMessage = "Database connection error: " + movieBean.getErrorMessage();
                } else {
                    boolean found = movieBean.getMovieById(movieId);
                    
                    if (!found) {
                        errorMessage = "Movie not found with ID: " + movieId;
                        movieBean.disconnect();
                    } else {
                        // Store values before disconnecting
                        title = movieBean.getTitle();
                        genre = movieBean.getGenre();
                        releaseYear = movieBean.getReleaseYear();
                        rating = movieBean.getRating();
                        director = movieBean.getDirector();
                        movieBean.disconnect();
                    }
                }
            } catch (NumberFormatException e) {
                errorMessage = "Invalid movie ID: " + idParam;
            }
        }
        
        // Display error message if any
        if (errorMessage != null) {
%>
        <div class="error-message">
            <p><%= errorMessage %></p>
        </div>
        <div class="form-actions">
            <a href="movieSelection.jsp" class="btn-submit">Select Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
        } else {
%>

        <h3>Edit Movie</h3>
        <p class="description">Movie ID is the primary key and cannot be modified.</p>

        <form action="movieUpdate.jsp" method="post">
            <input type="hidden" name="movieId" value="<%= movieId %>">
            
            <table class="form-table">
                <tr>
                    <td><label for="movieIdDisplay">Movie ID:</label></td>
                    <td><input type="text" id="movieIdDisplay" value="<%= movieId %>" readonly class="readonly-field"></td>
                </tr>
                <tr>
                    <td><label for="title">Movie Title:</label></td>
                    <td><input type="text" id="title" name="title" required value="<%= title %>"></td>
                </tr>
                <tr>
                    <td><label for="genre">Genre:</label></td>
                    <td>
                        <select id="genre" name="genre" required>
                            <option value="Action" <%= "Action".equals(genre) ? "selected" : "" %>>Action</option>
                            <option value="Comedy" <%= "Comedy".equals(genre) ? "selected" : "" %>>Comedy</option>
                            <option value="Crime" <%= "Crime".equals(genre) ? "selected" : "" %>>Crime</option>
                            <option value="Drama" <%= "Drama".equals(genre) ? "selected" : "" %>>Drama</option>
                            <option value="Fantasy" <%= "Fantasy".equals(genre) ? "selected" : "" %>>Fantasy</option>
                            <option value="Horror" <%= "Horror".equals(genre) ? "selected" : "" %>>Horror</option>
                            <option value="Romance" <%= "Romance".equals(genre) ? "selected" : "" %>>Romance</option>
                            <option value="Sci-Fi" <%= "Sci-Fi".equals(genre) ? "selected" : "" %>>Sci-Fi</option>
                            <option value="Thriller" <%= "Thriller".equals(genre) ? "selected" : "" %>>Thriller</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="releaseYear">Release Year:</label></td>
                    <td><input type="number" id="releaseYear" name="releaseYear" min="1888" max="2030" required value="<%= releaseYear %>"></td>
                </tr>
                <tr>
                    <td><label for="rating">MPAA Rating:</label></td>
                    <td>
                        <select id="rating" name="rating" required>
                            <option value="G" <%= "G".equals(rating) ? "selected" : "" %>>G</option>
                            <option value="PG" <%= "PG".equals(rating) ? "selected" : "" %>>PG</option>
                            <option value="PG-13" <%= "PG-13".equals(rating) ? "selected" : "" %>>PG-13</option>
                            <option value="R" <%= "R".equals(rating) ? "selected" : "" %>>R</option>
                            <option value="NC-17" <%= "NC-17".equals(rating) ? "selected" : "" %>>NC-17</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="director">Director:</label></td>
                    <td><input type="text" id="director" name="director" required value="<%= director %>"></td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">Update Movie</button>
                <a href="movieDisplay.jsp" class="btn-reset">Cancel</a>
            </div>
        </form>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category or type of movie</li>
            <li><strong>Release Year:</strong> The year the movie was released</li>
            <li><strong>MPAA Rating:</strong> Motion picture rating (G, PG, PG-13, R, NC-17)</li>
            <li><strong>Director:</strong> The director of the movie</li>
        </ul>

        <div class="form-actions">
            <a href="movieDisplay.jsp" class="btn-reset">View All Movies</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
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