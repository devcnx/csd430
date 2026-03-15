<%-- 
    CSD430 Server-Side Development

    Module 5 & 6 Project Part 1: CRUD-READ Operations
    Author: Brittaney Perry-Morgan

    Description: Displays a dropdown menu with all movie IDs from the
    database. User selects a movie ID and submits to view details.

    movieSelection.jsp - Movie Selection Form Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="csd430.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Selection - CSD430</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 5 & 6 Project Part 1</h1>
        <h2>Movie Database - <em>READ Operation</em></h2>
        <p class="description">Select a movie ID from the dropdown menu to view its details.</p>
    </div>

    <div class="container">
<%
        MovieBean movieBean = new MovieBean();
        boolean connected = movieBean.connect();
        
        if (!connected) {
%>
        <h3>Database Connection Error</h3>
        <p class="description error"><%= movieBean.getErrorMessage() %></p>
<%
        } else {
            boolean success = movieBean.getAllMovieIds();
            
            if (!success) {
%>
        <h3>Error Retrieving Data</h3>
        <p class="description error"><%= movieBean.getErrorMessage() %></p>
<%
            } else {
                List<Integer> movieIds = movieBean.getMovieIds();
                
                if (movieIds.isEmpty()) {
%>
        <h3>No Records Found</h3>
        <p class="description">No movies found in the database.</p>
<%
                } else {
%>
        <h3>Select Movie</h3>
        <form action="movieDisplay.jsp" method="get">
            <table class="form-table">
                <tr>
                    <td><label for="movieId">Movie ID:</label></td>
                    <td>
                        <select id="movieId" name="movieId" required>
                            <option value="">-- Select a Movie --</option>
<%
                    for (Integer id : movieIds) {
%>
                            <option value="<%= id %>">Movie #<%= id %></option>
<%
                    }
%>
                        </select>
                    </td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">View Movie Details</button>
                <button type="reset" class="btn-reset">Reset</button>
            </div>
        </form>
<%
                }
            }
            
            movieBean.disconnect();
        }
%>

        <div class="form-actions">
            <a href="/module_07_project_2/movieForm.jsp" class="btn-reset">Add New Movie (Module 7)</a>
            <a href="/module_08_project_3/movieSelection.jsp" class="btn-reset">Edit Movie (Module 8)</a>
            <a href="/module_09_project_4/movieDelete.jsp" class="btn-reset" style="background-color: #dc3545;">Delete Movie (Module 9)</a>
            <a href="index.jsp" class="btn-reset">Back to Course Index</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>