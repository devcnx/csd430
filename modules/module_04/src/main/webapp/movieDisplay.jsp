<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.MovieBean" %>
<%--
    CSD430 Server-Side Development

    Module 4: JavaBean
    Author: Brittaney Perry-Morgan

    Description: Displays all movie data from the MovieBean JavaBean.
    All Java code is within Scriptlets. All HTML tags are outside of
    Scriptlets. External CSS is used for styling.

    movieDisplay.jsp - Complete Movie Data Display Page
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
    <title>Module 4 Assignment: JavaBean - Complete Movie Data</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 4 Assignment: JavaBean</h1>
        <h2>Movie: <em><%= movie.getMovieTitle() %></em> (<%= movie.getMovieYear() %>)</h2>
        <p class="description"><%= movie.getOverallDescription() %></p>
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

        <h3>Production Information</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : movie.getProductionInfo()) { %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <h3>Technical Specifications</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : movie.getTechnicalSpecs()) { %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <h3>Plot Elements</h3>
        <table>
            <thead>
                <tr>
                    <th>Character</th>
                    <th>Summary</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : movie.getPlotElements()) { %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <h3>Release Information</h3>
        <table>
            <thead>
                <tr>
                    <th>Event</th>
                    <th>Date</th>
                    <th>Region</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : movie.getReleaseInfo()) { %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
