<%--
    Movie Delete Processing Page - Module 09 Assignment
    Student: Brittaney Perry-Morgan
    This page processes the movie deletion after confirmation
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Processing - CSD430</title>
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
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success {
            color: green;
            padding: 20px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .success-icon {
            font-size: 48px;
            color: #28a745;
        }
        .error {
            color: red;
            padding: 20px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .error-icon {
            font-size: 48px;
            color: #dc3545;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-primary {
            background-color: #0066cc;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-primary:hover {
            background-color: #0052a3;
        }
        .button-group {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Delete Movie Result</h1>

    <div class="form-container">
<%
        String movieIdParam = request.getParameter("movieId");

        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
            <div class="error">
                <div class="error-icon">&#10060;</div>
                <h2>Error</h2>
                <p>No movie ID provided. Please select a movie to delete.</p>
            </div>
<%
        } else {
            try {
                int movieId = Integer.parseInt(movieIdParam);

                MovieBean movieBean = new MovieBean();
                boolean connected = movieBean.connect();

                if (!connected) {
%>
            <div class="error">
                <div class="error-icon">&#10060;</div>
                <h2>Database Connection Error</h2>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
                } else {
                    // Check if movie exists first
                    if (!movieBean.movieExists(movieId)) {
%>
            <div class="error">
                <div class="error-icon">&#10060;</div>
                <h2>Movie Not Found</h2>
                <p>No movie found with ID: <%= movieId %></p>
            </div>
<%
                    } else {
                        // Attempt to delete the movie
                        boolean success = movieBean.deleteMovie(movieId);
                        movieBean.disconnect();

                        if (success) {
%>
            <div class="success">
                <div class="success-icon">&#10004;</div>
                <h2>Movie Deleted Successfully!</h2>
                <p>Movie with ID <%= movieId %> has been permanently removed from the database.</p>
            </div>
<%
                        } else {
%>
            <div class="error">
                <div class="error-icon">&#10060;</div>
                <h2>Deletion Failed</h2>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
                        }
                    }
                }
            } catch (NumberFormatException e) {
%>
            <div class="error">
                <div class="error-icon">&#10060;</div>
                <h2>Invalid Movie ID</h2>
                <p>The movie ID provided is not valid.</p>
            </div>
<%
            }
        }
%>

        <div class="button-group">
            <a href="movie_delete.jsp" class="btn-primary">Delete Another Movie</a>
            <a href="index.jsp" class="btn-secondary">Back to Course Index</a>
        </div>
    </div>

</body>
</html>