<%-- 
    CSD430 Server-Side Development

    Module 9 Project Part 4: CRUD-DELETE Operations
    Author: Brittaney Perry-Morgan

    Description: Delete selection page that displays all movie records in a table
    format along with a dropdown menu for selecting a movie to delete.

    movieDelete.jsp - Movie Delete Selection Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Movie - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 9 Project Part 4</h1>
        <h2>Movie Database - <em>DELETE Operation</em></h2>
        <p class="description">Select a movie record to delete from the database.</p>
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

        <h3>All Movie Records</h3>
        <p class="description">
            The table below displays all movie records currently stored in the database.
            Use the dropdown menu to select a movie for deletion.
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
            <p><strong>No records found.</strong> The database table is empty. No movies available to delete.</p>
        </div>
        <div class="form-actions">
            <a href="/module_07_project_2/movieForm.jsp" class="btn-submit">Add New Movie</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
<%
                } else {
%>

        <h3>Delete Movie</h3>
        <p class="description">
            Select a movie from the dropdown menu below. You will be asked to confirm
            the deletion before the record is permanently removed.
        </p>

        <form action="movieConfirmDelete.jsp" method="get">
            <table class="form-table">
                <tr>
                    <td><label for="movieId">Select Movie ID:</label></td>
                    <td>
                        <select id="movieId" name="movieId" required>
                            <option value="">-- Select a Movie --</option>
<%
                    // Reconnect and get IDs for dropdown
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
        }
%>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>