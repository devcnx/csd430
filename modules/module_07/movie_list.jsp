<%-- 
    Movie List Page - Module 07 Assignment
    Student: Brittaney Perry-Morgan
    This page displays all movies from the database in a table format
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie List - CSD430</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
            max-width: 1200px;
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
        .btn {
            display: inline-block;
            background-color: #0066cc;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #0052a3;
        }
        .btn-secondary {
            background-color: #28a745;
        }
        .btn-secondary:hover {
            background-color: #218838;
        }
        .record-count {
            text-align: center;
            color: #666;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>Movie Database Application</h1>
    <h2>CSD430 - Module 07 Assignment</h2>
    
    <div class="form-container">
        <p class="description">
            This page displays all movies in the database. The data is retrieved using JDBC and displayed in an HTML table format.
        </p>
        
<%
        MovieBean movieBean = new MovieBean();
        boolean connected = movieBean.connect();
        int recordCount = 0;
        
        if (!connected) {
%>
            <div class="error">
                <p>Database Connection Error:</p>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
        } else {
            boolean success = movieBean.getAllMovies();
            
            if (!success) {
%>
            <div class="error">
                <p>Error retrieving movie data:</p>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
            } else {
%>
        <p class="record-count">Total Records: <%
                while (movieBean.next()) {
                    recordCount++;
                }
                movieBean.disconnect();
                out.print(recordCount);
            %></p>
            
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
<%
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
                    </tr>
<%
                }
                movieBean.disconnect();
%>
                </tbody>
            </table>
            
            <h3>Field Descriptions:</h3>
            <ul>
                <li><strong>Movie ID:</strong> Unique identifier for each movie (Primary Key, Auto-increment)</li>
                <li><strong>Title:</strong> The name of the movie</li>
                <li><strong>Genre:</strong> The category/type of the movie</li>
                <li><strong>Release Year:</strong> The year the movie was released</li>
                <li><strong>Rating:</strong> MPAA rating (G, PG, PG-13, R, NC-17)</li>
                <li><strong>Director:</strong> The director of the movie</li>
            </ul>
<%
            }
        }
%>
        
        <a href="movie_form.jsp" class="btn btn-secondary">Add New Movie</a>
        <a href="index.jsp" class="btn">&larr; Course Index</a>
    </div>
    
</body>
</html>
