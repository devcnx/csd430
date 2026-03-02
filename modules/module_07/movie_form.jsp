<%-- 
    Movie Form Page - Module 07 Assignment
    Student: Brittaney Perry-Morgan
    This page displays a form to add a new movie record to the database
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Movie - CSD430</title>
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
            border-bottom: 2px solid #0066cc;
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
        button {
            background-color: #28a745;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        button:hover {
            background-color: #218838;
        }
        .btn-secondary {
            background-color: #6c757d;
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
    </style>
</head>
<body>
    <h1>Add New Movie</h1>
    
    <div class="form-container">
        <p class="info">Fill in the details below to add a new movie to the database.</p>
        
<%
        MovieBean movieBean = new MovieBean();
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
                    boolean connected = movieBean.connect();
                    
                    if (connected) {
                        boolean success = movieBean.insertMovie(title, genre, releaseYear, rating, director);
                        movieBean.disconnect();
                        
                        if (success) {
                            successMessage = "Movie '" + title + "' has been added successfully!";
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
        
        <form action="movie_form.jsp" method="post">
            <div class="form-group">
                <label for="title">Movie Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="genre">Genre:</label>
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
                    <option value="Superhero">Superhero</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="release_year">Release Year:</label>
                <input type="number" id="release_year" name="release_year" min="1888" max="2030" required>
            </div>
            
            <div class="form-group">
                <label for="rating">MPAA Rating:</label>
                <select id="rating" name="rating" required>
                    <option value="">-- Select Rating --</option>
                    <option value="G">G</option>
                    <option value="PG">PG</option>
                    <option value="PG-13">PG-13</option>
                    <option value="R">R</option>
                    <option value="NC-17">NC-17</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="director">Director:</label>
                <input type="text" id="director" name="director" required>
            </div>
            
            <button type="submit">Add Movie</button>
            <button type="button" class="btn-secondary" onclick="window.location.href='movie_list.jsp'">View All Movies</button>
        </form>
        
        <a href="index.jsp" class="back-link">&larr; Back to Course Index</a>
    </div>
    
</body>
</html>
