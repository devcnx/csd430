<%-- 
    CSD430 Server-Side Development

    Module 9 Project Part 4: CRUD-DELETE Operations
    Author: Brittaney Perry-Morgan

    Description: Confirmation page displaying movie details before deletion.
    Shows all field values and requires user confirmation.

    movieConfirmDelete.jsp - Delete Confirmation Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Delete - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 9 Project Part 4</h1>
        <h2>Movie Database - <em>DELETE Operation</em></h2>
        <p class="description">Confirm movie deletion.</p>
    </div>

    <div class="container">
<%
        MovieBean movieBean = new MovieBean();
        String movieIdParam = request.getParameter("movieId");

        if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
        <div class="error-message">
            <p>No movie selected. Please go back and select a movie to delete.</p>
        </div>
        <div class="form-actions">
            <a href="movieDelete.jsp" class="btn-submit">Select Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
        } else {
            try {
                int movieId = Integer.parseInt(movieIdParam);
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
                    boolean success = movieBean.getMovieById(movieId);

                    if (!success) {
%>
        <div class="error-message">
            <p>Error retrieving movie data:</p>
            <p><%= movieBean.getErrorMessage() %></p>
        </div>
        <div class="form-actions">
            <a href="movieDelete.jsp" class="btn-submit">Select Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
                    } else {
                        // Store values before disconnecting
                        String title = movieBean.getTitle();
                        String genre = movieBean.getGenre();
                        int releaseYear = movieBean.getReleaseYear();
                        String rating = movieBean.getRating();
                        String director = movieBean.getDirector();
                        movieBean.disconnect();
%>

        <div class="warning-message">
            <p><strong>&#9888; Warning:</strong> You are about to permanently delete this movie record. This action cannot be undone!</p>
        </div>

        <h3>Movie to Delete</h3>
        <p class="description">
            Please review the movie details below before confirming deletion.
        </p>

        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Movie ID</strong></td>
                    <td><%= movieId %></td>
                </tr>
                <tr>
                    <td><strong>Title</strong></td>
                    <td><%= title %></td>
                </tr>
                <tr>
                    <td><strong>Genre</strong></td>
                    <td><%= genre %></td>
                </tr>
                <tr>
                    <td><strong>Release Year</strong></td>
                    <td><%= releaseYear %></td>
                </tr>
                <tr>
                    <td><strong>Rating</strong></td>
                    <td><%= rating %></td>
                </tr>
                <tr>
                    <td><strong>Director</strong></td>
                    <td><%= director %></td>
                </tr>
            </tbody>
        </table>

        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <li><strong>Movie ID:</strong> Unique identifier (Primary Key, will be permanently removed)</li>
            <li><strong>Title:</strong> The name of the movie</li>
            <li><strong>Genre:</strong> The category of the movie</li>
            <li><strong>Release Year:</strong> Year the movie was released</li>
            <li><strong>Rating:</strong> MPAA rating</li>
            <li><strong>Director:</strong> Director of the movie</li>
        </ul>

        <form action="movieProcessDelete.jsp" method="post" onsubmit="return confirm('Are you absolutely sure you want to delete this movie? This action cannot be undone!');">
            <input type="hidden" name="movieId" value="<%= movieId %>">
            <div class="form-actions">
                <button type="submit" class="btn-submit" style="background-color: #dc3545;">Yes, Delete Movie</button>
                <a href="movieDelete.jsp" class="btn-reset">Cancel</a>
            </div>
        </form>

        <div class="form-actions">
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
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