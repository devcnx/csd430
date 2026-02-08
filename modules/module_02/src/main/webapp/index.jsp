<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%-- 
    CSD430 Server-Side Development

    Module 2: Java Scriptlet - Data Display
    Author: Brittaney Perry-Morgan
    
    Description: Landing Page and Navigation Hub for Module 2. 
    Provides access to the movie data display and ensures consistent styling.

    index.jsp - Main entry point for Module 2 assignment
--%>
<!DOCTYPE html>
<html>
<head>
    <title>CSD430 Module 2: Home</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Welcome to CSD430 Module 2</h1>
        <p>
            <strong>Assignment:</strong> Java Scriptlet - Data Display<br>
            <strong>Author:</strong> Brittaney Perry-Morgan<br>
        </p>
    </header>
    <main>
        <p class="description card">
            This web application demonstrates dynamic data display using JSP scriptlets and external CSS styling.
            Use the navigation below to view the movie data table for the <b>Module 2</b> assignment.
        </p>
        <nav>
            <ul>
                <li><a href="movieData.jsp">View Movie Data Table</a></li>
                <!-- Add more links here as you build out future modules -->
            </ul>
        </nav>
    </main>
    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
