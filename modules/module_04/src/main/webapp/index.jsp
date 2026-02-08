<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    CSD430 Server-Side Development

    Module 4: JavaBean
    Author: Brittaney Perry-Morgan

    Description: Main entry point for Module 4. This page demonstrates
    the JavaBean by accessing movie data and displaying it using JSP
    scriptlets with external CSS styling.

    index.jsp - Module 4 Home Page
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Module 4 Assignment: JavaBean</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 4 Assignment: JavaBean</h1>
        <h2>Movie: <em>Subservience</em> (2024)</h2>
        <p class="description">This web application demonstrates JavaBean usage for storing and displaying movie data. The MovieBean class holds all movie information and is accessed via JSP scriptlets.</p>
    </div>

    <div class="container">
        <h3>Module Overview</h3>
        <ul class="field-descriptions">
            <li><strong>JavaBean:</strong> MovieBean - A Serializable Java class that encapsulates all movie data</li>
            <li><strong>Data Categories:</strong> Cast Details, Production Information, Technical Specifications, Plot Elements, Release Information</li>
            <li><strong>Data Points:</strong> 24 total records across 5 categories with 3 fields each</li>
            <li><strong>Display Method:</strong> JSP scriptlets access JavaBean properties and render HTML tables</li>
        </ul>

        <h3>Navigation</h3>
        <nav>
            <ul>
                <li><a href="movieDisplay.jsp">View Movie Data</a> - Display all movie information from the JavaBean</li>
                <li><a href="castDisplay.jsp">View Cast Details</a> - Display only the cast information</li>
                <li><a href="productionDisplay.jsp">View Production Info</a> - Display production details</li>
            </ul>
        </nav>

        <h3>JavaBean Features</h3>
        <table>
            <thead>
                <tr>
                    <th>Feature</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Serializable</td>
                    <td>Implements java.io.Serializable for session storage</td>
                </tr>
                <tr>
                    <td>Default Constructor</td>
                    <td>Initializes all movie data upon instantiation</td>
                </tr>
                <tr>
                    <td>Getters/Setters</td>
                    <td>Public accessor methods for all private fields</td>
                </tr>
                <tr>
                    <td>Data Encapsulation</td>
                    <td>All movie data stored as private String arrays</td>
                </tr>
                <tr>
                    <td>Fields</td>
                    <td>5 data categories with 24 total records</td>
                </tr>
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
