<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.MovieBean" %>
<%@ page import="com.example.JDBCConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--
    CSD430 Server-Side Development
    
    Module 5 & 6: JDBC & JavaBeans - CRUD READ Operations
    Author: Brittaney Perry-Morgan
    
    movieByGenre.jsp - Filter movies by genre
--%>
<%
    // Get selected genre
    String selectedGenre = request.getParameter("genre");
    
    // Get all genres
    List<String> genres = JDBCConnection.getGenres();
    
    // Initialize results
    List<MovieBean> movies = new ArrayList<>();
    
    // Get movies by genre if selected
    if (selectedGenre != null && !selectedGenre.isEmpty()) {
        movies = JDBCConnection.getMoviesByGenre(selectedGenre);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>CSD430 Module 5 & 6: Movies by Genre</title>
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
            <h2>Movies by Genre</h2>
            <p class="description">
                Filter movies by genre using JDBC queries. Select a genre from the dropdown
                to view all movies in that category.
            </p>
            
            <div class="search-form">
                <form method="get" action="movieByGenre.jsp">
                    <div class="form-group" style="max-width: 300px;">
                        <label for="genre">Select Genre:</label>
                        <select id="genre" name="genre" onchange="this.form.submit()">
                            <option value="">-- Select Genre --</option>
                            <%
                                for (String genre : genres) {
                            %>
                            <option value="<%= genre %>" 
                                <%= (selectedGenre != null && selectedGenre.equals(genre)) ? "selected" : "" %>><%= genre %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </form>
            </div>
            
            <%
                if (selectedGenre != null && !selectedGenre.isEmpty()) {
            %>
            <div style="margin-top: 2rem;">
                <p>Displaying <strong><%= movies.size() %></strong> movie(s) in the <strong><%= selectedGenre %></strong> genre.</p>
                
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
                                No movies found in this genre.
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
            <%
                } else {
            %>
            <div style="margin-top: 2rem; padding: 2rem; background: #f8f9fa; border-radius: 8px; text-align: center; color: #666;">
                <p>Select a genre from the dropdown above to view movies.</p>
            </div>
            <%
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>