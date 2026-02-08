<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.MovieBean" %>
<%--
    CSD430 Server-Side Development

    Module 4: JavaBean
    Author: Brittaney Perry-Morgan

    Description: Displays only the Cast Details from the MovieBean JavaBean.
    All Java code is within Scriptlets. All HTML tags are outside of
    Scriptlets. External CSS is used for styling.

    castDisplay.jsp - Cast Details Display Page
--%>

<%-- =========================
     1. JAVA BEAN INSTANTIATION
     ========================= --%>
<%
    // Create a new MovieBean instance
    MovieBean movie = new MovieBean();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Module 4 Assignment: JavaBean - Cast Details</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 4 Assignment: JavaBean</h1>
        <h2>Movie: <em><%= movie.getMovieTitle() %></em> (<%= movie.getMovieYear() %>)</h2>
        <p class="description">This page displays the cast details for the movie, retrieved from the MovieBean JavaBean.</p>
    </div>

    <div class="container">
        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <% for (String desc : movie.getFieldDescriptions()) { %>
                <li><%= desc %></li>
            <% } %>
        </ul>

        <h3>Cast Details</h3>
        <table>
            <thead>
                <tr>
                    <th>Actor</th>
                    <th>Character</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : movie.getCastDetails()) { %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <div class="form-actions">
            <a href="movieDisplay.jsp" class="btn-submit">View Complete Movie Data</a>
            <a href="index.jsp" class="btn-reset">Back to Home</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
