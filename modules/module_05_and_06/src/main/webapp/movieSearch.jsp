<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.MovieBean" %>
<%@ page import="com.example.JDBCConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--
    CSD430 Server-Side Development
    
    Module 5 & 6: JDBC & JavaBeans - CRUD READ Operations
    Author: Brittaney Perry-Morgan
    
    movieSearch.jsp - Search for movies by title, genre, or year
--%>
<%
    // Get search parameters
    String searchTitle = request.getParameter("searchTitle");
    String searchGenre = request.getParameter("searchGenre");
    String searchYear = request.getParameter("searchYear");
    
    // Get all genres for the dropdown
    List<String> genres = JDBCConnection.getGenres();
    
    // Initialize results list
    List<MovieBean> results = new ArrayList<>();
    
    // Perform search if form was submitted
    if (searchTitle != null || searchGenre != null || searchYear != null) {
        // Build dynamic search query
        String query = "%";
        if (searchTitle != null && !searchTitle.trim().isEmpty()) {
            query = searchTitle.trim();
        }
        
        // Search by title pattern
        if (searchTitle != null && !searchTitle.trim().isEmpty()) {
            // Simple approach: get all movies and filter
            results = JDBCConnection.getAllMovies();
            List<MovieBean> filtered = new ArrayList<>();
            for (MovieBean movie : results) {
                if (movie.getMovieTitle().toLowerCase().contains(query.toLowerCase())) {
                    filtered.add(movie);
                }
            }
            results = filtered;
        }
        
        // Search by genre
        if (searchGenre != null && !searchGenre.isEmpty()) {
            if (results.isEmpty()) {
                results = JDBCConnection.getMoviesByGenre(searchGenre);
            } else {
                List<MovieBean> filtered = new ArrayList<>();
                for (MovieBean movie : results) {
                    if (movie.getGenre().equals(searchGenre)) {
                        filtered.add(movie);
                    }
                }
                results = filtered;
            }
        }
        
        // Search by year
        if (searchYear != null && !searchYear.isEmpty()) {
            if (results.isEmpty()) {
                results = JDBCConnection.getAllMovies();
            }
            List<MovieBean> filtered = new ArrayList<>();
            for (MovieBean movie : results) {
                if (String.valueOf(movie.getReleaseYear()).contains(searchYear)) {
                    filtered.add(movie);
                }
            }
            results = filtered;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>CSD430 Module 5 & 6: Search Movies</title>
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
            <h2>Search Movies</h2>
            <p class="description">
                Search for movies by title, genre, or release year using JDBC queries.
            </p>
            
            <div class="search-form">
                <form method="get" action="movieSearch.jsp">
                    <div class="form-group">
                        <label for="searchTitle">Search by Title:</label>
                        <input type="text" id="searchTitle" name="searchTitle" 
                               value="<%= searchTitle != null ? searchTitle : "" %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="searchGenre">Filter by Genre:</label>
                        <select id="searchGenre" name="searchGenre">
                            <option value="">All Genres</option>
                            <%
                                for (String genre : genres) {
                            %>
                            <option value="<%= genre %>" 
                                <%= (searchGenre != null && searchGenre.equals(genre)) ? "selected" : "" %>><%= genre %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="searchYear">Search by Year:</label>
                        <input type="text" id="searchYear" name="searchYear" 
                               placeholder="e.g., 2008" 
                               value="<%= searchYear != null ? searchYear : "" %>">
                    </div>
                    
                    <div class="form-group" style="display: flex; align-items: flex-end;">
                        <button type="submit" class="btn btn-primary">Search</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href='movieSearch.jsp'">Reset</button>
                    </div>
                </form>
            </div>
            
            <% if (searchTitle != null || searchGenre != null || searchYear != null) { %>
            <div style="margin-top: 2rem;">
                <p>Found <strong><%= results.size() %></strong> movie(s) matching your search criteria.</p>
                
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
                            if (results.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: #999;">
                                No movies found matching your search criteria.
                            </td>
                        </tr>
                        <%
                            } else {
                                for (MovieBean movie : results) {
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
            <% } %>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>