<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.MovieBean" %>
<%@ page import="com.example.JDBCConnection" %>
<%@ page import="java.util.List" %>
<%--
    CSD430 Server-Side Development
    
    Module 5 & 6: JDBC & JavaBeans - CRUD READ Operations
    Author: Brittaney Perry-Morgan
    
    movieList.jsp - Displays all movies from the database
--%>
<%
    // Get all movies from the database
    List<MovieBean> movies = JDBCConnection.getAllMovies();
%>
<!DOCTYPE html>
<html>
<head>
    <title>CSD430 Module 5 & 6: View All Movies</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <header>
        <h1>CSD430 Module 5 & 6</h1>
        <p><strong>Assignment:</strong> JDBC & JavaBeans - CRUD READ Operations | <strong>Author:</strong> Brittaney Perry-Morgan</p>
        <nav>
            <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
        </nav>
    </header>
    <main>
        <div class="container">
            <h2>All Movies in Database</h2>
            <p class="description">
                This page displays all movie records from the <code>brittaney_perry_morgan_data</code> table
                using JDBC and JavaBeans for data access.
            </p>
            
            <div style="margin-top: 2rem;">
                <p>Total Records: <strong><%= movies.size() %></strong></p>
                
                <table class="movie-table">
                    <thead>
                        <tr>
                            <th>Movie ID</th>
                            <th>Movie Title</th>
                            <th>Release Year</th>
                            <th>Director</th>
                            <th>Genre</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (movies.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: #999;">
                                No movies found in the database.
                            </td>
                        </tr>
                        <%
                            } else {
                                for (MovieBean movie : movies) {
                        %>
                        <tr>
                            <td><%= movie.getMovieId() %></td>
                            <td><%= movie.getMovieTitle() %></td>
                            <td><%= movie.getReleaseYear() %></td>
                            <td><%= movie.getDirector() %></td>
                            <td><%= movie.getGenre() %></td>
                            <td><span class="rating"><%= String.format("%.1f", movie.getRating()) %></span></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>