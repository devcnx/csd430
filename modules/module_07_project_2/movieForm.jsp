<%-- 
    CSD430 Server-Side Development

    Module 7 Project Part 2: CRUD-CREATE Operations
    Author: Brittaney Perry-Morgan

    Description: Form page for adding new movie records to the database.
    Uses JDBC and JavaBeans for database connectivity.

    movieForm.jsp - Add Movie Form Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Movie - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 7 Project Part 2</h1>
        <h2>Movie Database - <em>CREATE Operation</em></h2>
        <p class="description">Add a new movie record to the database.</p>
    </div>

    <div class="container">
<%
        MovieBean movieBean = new MovieBean();
        String successMessage = null;
        String errorMessage = null;
        
        // Process form submission
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            String releaseYearStr = request.getParameter("release_year");
            String rating = request.getParameter("rating");
            String director = request.getParameter("director");
            
            // Validate all fields are present
            if (title != null && !title.isEmpty() &&
                genre != null && !genre.isEmpty() &&
                releaseYearStr != null && !releaseYearStr.isEmpty() &&
                rating != null && !rating.isEmpty() &&
                director != null && !director.isEmpty()) {
                
                try {
                    int releaseYear = Integer.parseInt(releaseYearStr);
                    boolean connected = movieBean.connect();
                    
                    if (connected) {
                        boolean success = movieBean.insertMovie(title, genre, releaseYear, rating, director);
                        movieBean.disconnect();
                        
                        if (success) {
                            successMessage = "Movie \"" + title + "\" has been added successfully!";
                        } else {
                            errorMessage = "Error adding movie: " + movieBean.getErrorMessage();
                        }
                    } else {
                        errorMessage = "Database connection error: " + movieBean.getErrorMessage();
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid release year. Please enter a valid number.";
                }
            } else {
                errorMessage = "All fields are required. Please fill in all the details.";
            }
        }
        
        // Display success message
        if (successMessage != null) {
%>
        <div class="success-message">
            <p><%= successMessage %></p>
        </div>
<%
        }
        
        // Display error message
        if (errorMessage != null) {
%>
        <div class="error-message">
            <p><%= errorMessage %></p>
        </div>
<%
        }
%>

        <h3>Add New Movie</h3>
        <p class="description">Fill in the details below to add a new movie to the database.</p>

        <form action="movieForm.jsp" method="post">
            <table class="form-table">
                <tr>
                    <td><label for="title">Movie Title:</label></td>
                    <td><input type="text" id="title" name="title" required placeholder="Enter movie title"></td>
                </tr>
                <tr>
                    <td><label for="genre">Genre:</label></td>
                    <td>
                        <select id="genre" name="genre" required>
                            <option value="">-- Select Genre --</option>
                            <option value="Action">Action</option>
                            <option value="Comedy">Comedy</option>
                            <option value="Crime">Crime</option>
                            <option value="Drama">Drama</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Horror">Horror</option>
                            <option value="Romance">Romance</option>
                            <option value="Sci-Fi">Sci-Fi</option>
                            <option value="Thriller">Thriller</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="release_year">Release Year:</label></td>
                    <td><input type="number" id="release_year" name="release_year" min="1888" max="2030" required placeholder="e.g., 2024"></td>
                </tr>
                <tr>
                    <td><label for="rating">MPAA Rating:</label></td>
                    <td>
                        <select id="rating" name="rating" required>
                            <option value="">-- Select Rating --</option>
                            <option value="G">G</option>
                            <option value="PG">PG</option>
                            <option value="PG-13">PG-13</option>
                            <option value="R">R</option>
                            <option value="NC-17">NC-17</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="director">Director:</label></td>
                    <td><input type="text" id="director" name="director" required placeholder="Enter director name"></td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">Add Movie</button>
                <button type="reset" class="btn-reset">Clear Form</button>
            </div>
        </form>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category or type of movie (Action, Comedy, etc.)</li>
            <li><strong>Release Year:</strong> The year the movie was released</li>
            <li><strong>MPAA Rating:</strong> Motion picture rating (G, PG, PG-13, R, NC-17)</li>
            <li><strong>Director:</strong> The director of the movie</li>
        </ul>

        <div class="form-actions">
            <a href="movieList.jsp" class="btn-submit">View All Movies</a>
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