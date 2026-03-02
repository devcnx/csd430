<%-- 
    Movie Display Page - Module 05 & 06 Assignment
    Student: Brittaney Perry-Morgan
    This page displays the selected movie in an HTML table format
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Details - CSD430</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 900px;
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
        h2 {
            color: #666;
            text-align: center;
            font-weight: normal;
            margin-top: 0;
        }
        .description {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-style: italic;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        thead {
            background-color: #0066cc;
            color: white;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            font-weight: bold;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #e9f5ff;
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
            padding: 10px 20px;
            border: 1px solid #0066cc;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #0066cc;
            color: white;
        }
        .record-info {
            text-align: center;
            color: #666;
            margin-bottom: 10px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <h1>Movie Database Application</h1>
    <h2>CSD430 - Module 05 & 06 Assignment</h2>
    
    <div class="form-container">
        <p class="description">
            This page displays detailed information for the selected movie from the database.
            The data is retrieved using JDBC and displayed in an HTML table format.
        </p>
        
<%
        String movieIdParam = request.getParameter("movieId");
        
        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
            <div class="error">
                <p>No movie selected. Please go back and select a movie from the dropdown menu.</p>
            </div>
<%
        } else {
            int movieId = Integer.parseInt(movieIdParam);
            
            MovieBean movieBean = new MovieBean();
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
%>
        <p class="record-info">Displaying Record ID: <%= movieId %></p>
        
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
        
        <h3>Field Descriptions:</h3>
        <ul>
            <li><strong>Movie ID:</strong> Unique identifier for each movie (Primary Key)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category/type of the movie</li>
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
        
        <a href="movie_selection.jsp" class="back-link">&larr; Select Another Movie</a>
        <a href="index.jsp" class="back-link" style="margin-left: 10px;">&larr; Course Index</a>
    </div>
    
</body>
</html>
