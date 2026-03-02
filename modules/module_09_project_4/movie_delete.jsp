<%--
    Movie Delete Selection Page - Module 09 Assignment
    Student: Brittaney Perry-Morgan
    This page displays a dropdown menu to select a movie to delete
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Movie - CSD430</title>
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            background-color: #dc3545;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #c82333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #0066cc;
            text-decoration: none;
        }
        .error {
            color: red;
            text-align: center;
            padding: 10px;
            background-color: #ffe6e6;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .info {
            color: #666;
            text-align: center;
            margin-bottom: 20px;
        }
        .warning {
            color: #856404;
            text-align: center;
            padding: 10px;
            background-color: #fff3cd;
            border: 1px solid #ffc107;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>Delete Movie</h1>

    <div class="form-container">
        <p class="info">Select a movie ID from the dropdown menu to delete it from the database.</p>

        <div class="warning">
            <strong>Warning:</strong> Deleting a movie is permanent and cannot be undone!
        </div>

<%
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
            boolean success = movieBean.getAllMovieIds();

            if (!success) {
%>
            <div class="error">
                <p>Error retrieving movie data:</p>
                <p><%= movieBean.getErrorMessage() %></p>
            </div>
<%
            } else {
                List<Integer> movieIds = movieBean.getMovieIds();

                if (movieIds.isEmpty()) {
%>
            <div class="error">
                <p>No movies found in the database.</p>
            </div>
<%
                } else {
%>
        <form action="movie_confirm_delete.jsp" method="get">
            <div class="form-group">
                <label for="movieId">Select Movie ID to Delete:</label>
                <select id="movieId" name="movieId" required>
                    <option value="">-- Select a Movie --</option>
<%
                    for (Integer id : movieIds) {
%>
                    <option value="<%= id %>"><%= id %></option>
<%
                    }
%>
                </select>
            </div>

            <button type="submit">Select Movie to Delete</button>
        </form>
<%
                }
            }

            movieBean.disconnect();
        }
%>

        <a href="index.jsp" class="back-link">&larr; Back to Course Index</a>
    </div>

</body>
</html>