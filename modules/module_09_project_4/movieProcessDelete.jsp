<%-- 
    CSD430 Server-Side Development

    Module 9 Project Part 4: CRUD-DELETE Operations
    Author: Brittaney Perry-Morgan

    Description: Processes the movie deletion and displays the remaining records
    in a table format with a dropdown for selecting another movie to delete.

    movieProcessDelete.jsp - Delete Processing & Results Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Result - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 9 Project Part 4</h1>
        <h2>Movie Database - <em>DELETE Operation</em></h2>
        <p class="description">Delete operation result and remaining records.</p>
    </div>

    <div class="container">
<%
        String movieIdParam = request.getParameter("movieId");
        
        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
        <div class="error-message">
            <p>No movie ID provided. Please select a movie to delete.</p>
        </div>
        <div class="form-actions">
            <a href="movieDelete.jsp" class="btn-submit">Select Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
        } else {
            try {
                int movieId = Integer.parseInt(movieIdParam);
                
                MovieBean movieBean = new MovieBean();
                boolean connected = movieBean.connect();
                
                if (!connected) {
%>
        <div class="error-message">
            <p>Database Connection Error:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="movieDelete.jsp" class="btn-submit">Select Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
                } else {
                    // Check if movie exists
                    if (!movieBean.movieExists(movieId)) {
%>
        <div class="error-message">
            <p>Movie not found with ID: <%= movieId %></p>
            <p>The movie may have already been deleted.</p>
        </div>
<%
                    } else {
                        // Delete the movie
                        boolean success = movieBean.deleteMovie(movieId);
                        
                        if (success) {
%>
        <div class="success-message">
            <p>Movie with ID <%= movieId %> deleted successfully!</p>
        </div>
<%
                        } else {
%>
        <div class="error-message">
            <p>Failed to delete movie: <%= movieBean.getErrorMessage() %></p>
        </div>
<%
                        }
                    }
                    
                    // Display remaining records
                    movieBean.disconnect();
                    movieBean.connect();
                    boolean gotMovies = movieBean.getAllMovies();
%>

        <h3>Remaining Movie Records</h3>
        <p class="description">
            The table below displays all movie records currently stored in the database
            after the deletion operation.
        </p>

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
                    int recordCount = 0;
                    while (movieBean.next()) {
                        recordCount++;
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

        <p class="record-count">Total Records: <%= recordCount %></p>

<%
                    if (recordCount == 0) {
%>
        <div class="warning-message">
            <p><strong>Empty Table:</strong> All movie records have been deleted from the database.</p>
            <p>The table structure (thead row) remains, but there are no data rows to display.</p>
        </div>
        <div class="form-actions">
            <a href="/module_07_project_2/movieForm.jsp" class="btn-submit">Add New Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
                    } else {
%>

        <h3>Delete Another Movie</h3>
        <p class="description">
            Select another movie from the dropdown menu to delete additional records.
        </p>

        <form action="movieConfirmDelete.jsp" method="get">
            <table class="form-table">
                <tr>
                    <td><label for="movieId">Select Movie ID:</label></td>
                    <td>
                        <select id="movieId" name="movieId" required>
                            <option value="">-- Select a Movie --</option>
<%
                        // Reconnect and get remaining IDs
                        movieBean.connect();
                        movieBean.getAllMovies();
                        while (movieBean.next()) {
%>
                            <option value="<%= movieBean.getMovieId() %>">
                                <%= movieBean.getMovieId() %> - <%= movieBean.getTitle() %>
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
                <button type="submit" class="btn-submit" style="background-color: #dc3545;">Delete Selected Movie</button>
                <a href="index.jsp" class="btn-reset">Back to Course Index</a>
            </div>
        </form>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier (Primary Key)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category of the movie</li>
            <li><strong>Release Year:</strong> Year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating</li>
            <li><strong>Director:</strong> Director of the movie</li>
        </ul>

        <div class="form-actions">
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie (Module 7)</a>
            <a href="/module_08_project_3/movieSelection.jsp" class="btn-reset">Edit Movie (Module 8)</a>
        </div>
<%
                    }
                }
            } catch (NumberFormatException e) {
%>
        <div class="error-message">
            <p>Invalid movie ID: <%= movieIdParam %></p>
        </div>
        <div class="form-actions">
            <a href="movieDelete.jsp" class="btn-submit">Select Movie</a>
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