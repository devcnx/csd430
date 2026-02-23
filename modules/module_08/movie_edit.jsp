<%-- 
    Movie Edit Page - Module 08 Assignment
    Student: Brittaney Perry-Morgan
    This page displays a form to edit the selected movie record
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Movie - CSD430</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            text-align: center;
            border-bottom: 2px solid #ffc107;
            padding-bottom: 10px;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }
        button {
            background-color: #ffc107;
            color: #333;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        button:hover {
            background-color: #e0a800;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .error {
            color: red;
            text-align: center;
            padding: 10px;
            background-color: #ffe6e6;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success {
            color: green;
            text-align: center;
            padding: 10px;
            background-color: #d4edda;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .info {
            color: #666;
            text-align: center;
            margin-bottom: 20px;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #0066cc;
            text-decoration: none;
        }
        .readonly-field {
            background-color: #e9ecef;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Edit Movie</h1>
    
    <div class="form-container">
        <p class="info">Update the movie details below. The Movie ID cannot be changed.</p>
        
<%
        MovieBean movieBean = new MovieBean();
        String movieIdParam = request.getParameter("movieId");
        
        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
            <div class="error">
                <p>No movie selected. Please go back and select a movie to update.</p>
            </div>
<%
        } else {
            int movieId = Integer.parseInt(movieIdParam);
            boolean connected = movieBean.connect();
            
            if (!connected) {
%>
            <div class="error">
                <p>Database Connection Error:</p>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
            } else {
                boolean success = movieBean.getMovieById(movieId);
                
                if (!success) {
%>
            <div class="error">
                <p>Error retrieving movie data:</p>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
                } else {
                    String currentTitle = movieBean.getTitle();
                    String currentGenre = movieBean.getGenre();
                    int currentYear = movieBean.getReleaseYear();
                    String currentRating = movieBean.getRating();
                    String currentDirector = movieBean.getDirector();
                    
                    movieBean.disconnect();
                    
                    String successMessage = null;
                    String errorMessage = null;
                    
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String title = request.getParameter("title");
                        String genre = request.getParameter("genre");
                        String releaseYearStr = request.getParameter("release_year");
                        String rating = request.getParameter("rating");
                        String director = request.getParameter("director");
                        
                        if (title != null && !title.isEmpty() &&
                            genre != null && !genre.isEmpty() &&
                            releaseYearStr != null && !releaseYearStr.isEmpty() &&
                            rating != null && !rating.isEmpty() &&
                            director != null && !director.isEmpty()) {
                            
                            try {
                                int releaseYear = Integer.parseInt(releaseYearStr);
                                connected = movieBean.connect();
                                
                                if (connected) {
                                    success = movieBean.updateMovie(movieId, title, genre, releaseYear, rating, director);
                                    movieBean.disconnect();
                                    
                                    if (success) {
                                        successMessage = "Movie '" + title + "' has been updated successfully!";
                                        currentTitle = title;
                                        currentGenre = genre;
                                        currentYear = releaseYear;
                                        currentRating = rating;
                                        currentDirector = director;
                                    } else {
                                        errorMessage = "Error updating movie: " + movieBean.getErrorMessage();
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
                    
                    if (errorMessage != null) {
%>
            <div class="error"><%= errorMessage %></div>
<%
                    }
                    
                    if (successMessage != null) {
%>
            <div class="success"><%= successMessage %></div>
<%
                    }
%>
        
        <form action="movie_edit.jsp?movieId=<%= movieId %>" method="post">
            <div class="form-group">
                <label>Movie ID:</label>
                <div class="readonly-field"><%= movieId %></div>
                <input type="hidden" name="movieId" value="<%= movieId %>">
            </div>
            
            <div class="form-group">
                <label for="title">Movie Title:</label>
                <input type="text" id="title" name="title" value="<%= currentTitle %>" required>
            </div>
            
            <div class="form-group">
                <label for="genre">Genre:</label>
                <select id="genre" name="genre" required>
                    <option value="Action" <%= "Action".equals(currentGenre) ? "selected" : "" %>>Action</option>
                    <option value="Comedy" <%= "Comedy".equals(currentGenre) ? "selected" : "" %>>Comedy</option>
                    <option value="Crime" <%= "Crime".equals(currentGenre) ? "selected" : "" %>>Crime</option>
                    <option value="Drama" <%= "Drama".equals(currentGenre) ? "selected" : "" %>>Drama</option>
                    <option value="Fantasy" <%= "Fantasy".equals(currentGenre) ? "selected" : "" %>>Fantasy</option>
                    <option value="Horror" <%= "Horror".equals(currentGenre) ? "selected" : "" %>>Horror</option>
                    <option value="Romance" <%= "Romance".equals(currentGenre) ? "selected" : "" %>>Romance</option>
                    <option value="Sci-Fi" <%= "Sci-Fi".equals(currentGenre) ? "selected" : "" %>>Sci-Fi</option>
                    <option value="Thriller" <%= "Thriller".equals(currentGenre) ? "selected" : "" %>>Thriller</option>
                    <option value="Superhero" <%= "Superhero".equals(currentGenre) ? "selected" : "" %>>Superhero</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="release_year">Release Year:</label>
                <input type="number" id="release_year" name="release_year" value="<%= currentYear %>" min="1888" max="2030" required>
            </div>
            
            <div class="form-group">
                <label for="rating">MPAA Rating:</label>
                <select id="rating" name="rating" required>
                    <option value="G" <%= "G".equals(currentRating) ? "selected" : "" %>>G</option>
                    <option value="PG" <%= "PG".equals(currentRating) ? "selected" : "" %>>PG</option>
                    <option value="PG-13" <%= "PG-13".equals(currentRating) ? "selected" : "" %>>PG-13</option>
                    <option value="R" <%= "R".equals(currentRating) ? "selected" : "" %>>R</option>
                    <option value="NC-17" <%= "NC-17".equals(currentRating) ? "selected" : "" %>>NC-17</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="director">Director:</label>
                <input type="text" id="director" name="director" value="<%= currentDirector %>" required>
            </div>
            
            <button type="submit">Update Movie</button>
            <button type="button" class="btn-secondary" onclick="window.location.href='movie_display.jsp?movieId=<%= movieId %>'">View Updated Record</button>
        </form>
<%
                }
            }
        }
%>
        
        <a href="movie_update.jsp" class="back-link">&larr; Select Different Movie</a>
    </div>
    
</body>
</html>
