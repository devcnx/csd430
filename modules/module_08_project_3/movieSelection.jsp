<%-- 
    CSD430 Server-Side Development

    Module 8 Project Part 3: CRUD-UPDATE Operations
    Author: Brittaney Perry-Morgan

    Description: Selection page with dropdown to choose a movie to edit.
    The dropdown displays all movie IDs from the database.

    movieSelection.jsp - Movie Selection Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Movie to Edit - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 8 Project Part 3</h1>
        <h2>Movie Database - <em>UPDATE Operation</em></h2>
        <p class="description">Select a movie record to edit its details.</p>
    </div>

    <div class="container">
<%
        MovieBean movieBean = new MovieBean();
        boolean connected = movieBean.connect();
        
        if (!connected) {
%>
        <div class="error-message">
            <p>Database Connection Error:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
        } else {
            boolean success = movieBean.getAllMovies();
            
            if (!success) {
%>
        <div class="error-message">
            <p>Error retrieving movie data:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
            } else {
%>

        <h3>Select Movie to Edit</h3>
        <p class="description">
            Choose a movie from the dropdown below. The key field (Movie ID) 
            will be displayed but cannot be edited.
        </p>

        <form action="movieEdit.jsp" method="get">
            <table class="form-table">
                <tr>
                    <td><label for="movieId">Select Movie:</label></td>
                    <td>
                        <select id="movieId" name="id" required>
                            <option value="">-- Select a Movie --</option>
<%
                while (movieBean.next()) {
%>
                            <option value="<%= movieBean.getMovieId() %>">
                                <%= movieBean.getMovieId() %> - <%= movieBean.getTitle() %> (<%= movieBean.getReleaseYear() %>)
                            </option>
<%
                }
                movieBean.disconnect();
%>
                        </select>
                    </td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">Edit Selected Movie</button>
                <a href="movieDisplay.jsp" class="btn-reset">View All Movies</a>
            </div>
        </form>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Primary Key - displayed but cannot be modified</li>
            <li><strong>Title:</strong> The name of the movie (editable)</li>
            <li><strong>Genre:</strong> The category of the movie (editable)</li>
            <li><strong>Release Year:</strong> Year the movie was released (editable)</li>
            <li><strong>Rating:</strong> MPAA rating (editable)</li>
            <li><strong>Director:</strong> Director of the movie (editable)</li>
        </ul>

        <div class="form-actions">
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie (Module 7)</a>
            <a href="/module_09_project_4/movieDelete.jsp" class="btn-reset" style="background-color: #dc3545;">Delete Movie (Module 9)</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
            }
        }
%>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>