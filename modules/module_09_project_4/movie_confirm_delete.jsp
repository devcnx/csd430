<%--
    Movie Delete Confirmation Page - Module 09 Assignment
    Student: Brittaney Perry-Morgan
    This page displays movie details and asks for confirmation before deletion
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Delete - CSD430</title>
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
            border-bottom: 2px solid #dc3545;
            padding-bottom: 10px;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .warning-box {
            background-color: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 5px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .warning-icon {
            font-size: 48px;
            color: #ffc107;
        }
        .movie-info {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .movie-info h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .movie-info p {
            margin: 8px 0;
        }
        .movie-info strong {
            display: inline-block;
            width: 120px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }
        .btn-cancel:hover {
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
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #0066cc;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h1>Confirm Deletion</h1>

    <div class="form-container">
<%
        MovieBean movieBean = new MovieBean();
        String movieIdParam = request.getParameter("movieId");

        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
            <div class="error">
                <p>No movie selected. Please go back and select a movie to delete.</p>
            </div>
            <a href="movie_delete.jsp" class="back-link">&larr; Select a Movie</a>
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
                    String title = movieBean.getTitle();
                    String genre = movieBean.getGenre();
                    int releaseYear = movieBean.getReleaseYear();
                    String rating = movieBean.getRating();
                    String director = movieBean.getDirector();

                    movieBean.disconnect();
%>

        <div class="warning-box">
            <div class="warning-icon">&#9888;</div>
            <h2>Are you sure you want to delete this movie?</h2>
            <p>This action cannot be undone!</p>
        </div>

        <div class="movie-info">
            <h3>Movie Details</h3>
            <p><strong>Movie ID:</strong> <%= movieId %></p>
            <p><strong>Title:</strong> <%= title %></p>
            <p><strong>Genre:</strong> <%= genre %></p>
            <p><strong>Release Year:</strong> <%= releaseYear %></p>
            <p><strong>Rating:</strong> <%= rating %></p>
            <p><strong>Director:</strong> <%= director %></p>
        </div>

        <div class="button-group">
            <form action="movie_process_delete.jsp" method="post">
                <input type="hidden" name="movieId" value="<%= movieId %>">
                <button type="submit" class="btn-delete" onclick="return confirm('Are you absolutely sure you want to delete \' <%= title %>\'? This cannot be undone!')">Yes, Delete Movie</button>
            </form>
            <a href="movie_delete.jsp" class="btn-cancel">Cancel</a>
        </div>
<%
                }
            }
        }
%>

        <a href="index.jsp" class="back-link">&larr; Back to Course Index</a>
    </div>

</body>
</html>