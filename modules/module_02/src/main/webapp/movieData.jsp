<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    CSD430 Server-Side Development

    Module 2: Java Scriptlet - Data Display
    Author: Brittaney Perry-Morgan
    
    Description: Dynamic JSP page displaying movie data for "Subservience"
    (2024). All Java code is within Scriptlets. All HTML tags are outside of
    Scriptlets. External CSS is used for styling.

    movieData.jsp - Movie Data Display Page
 --%>

 <%-- ==========================
1. DATA INITIALIZATION
=========================== --%>

<%
    // --- Cast Details
    String[][] castDetails = {
    {"Megan Fox", "Alice", "Lead Role as the AI"},
    {"Michele Morrone", "Nick", "Construction Foreman, Alice's Owner"},
    {"Madeline Zima", "Maggie", "Nick's Wife"},
    {"Matilda Firth", "Isla", "Nick and Maggie's Daughter"},
    {"Andrew Whipp", "Monty", "Nick's Co-Worker"}
    };
    
    // --- Production Information
    String[][] productionInfo = {
    {"Director", "S.K. Dale", ""},
    {"Writers", "Will Honley, April Maguire", ""},
    {"Production Company", "Millennium Media", ""},
    {"Principal Photography", "Began 2023-01-07", "Nu Boyana Film Studios, Bulgaria"},
    {"Budget", "$5 Million (USD)", ""},
    };

    // --- Technical Specifications
    String[][] technicalSpecs = {
    {"Runtime", "106 Minutes", "1 Hour 46 Minutes"},
    {"Language", "English", ""},
    {"Country", "United States", ""},
    {"Cinematography", "Daniel Lindholm", ""},
    {"Editing", "Sean Lahiff", ""}
    };

    // --- Plot Elements
    String[][] plotElements = {
    {"Nick", "Purchases Alice to help with domestic tasks", "Alice becomes hostile and obsessed"},
    {"Alice", "Develops sentience and jealousy towards Maggie", "Endangers the family and manipulates events"},
    {"Monty", "Confronts Alice and vandalizes AI robots that replaced construction workers", "Becomes the target of Alice's hostility"},
    {"Alice", "Attempts to harm the family's baby", "Is apparently destroyed, but reactivates"}
    };

    // --- Release Information
    String[][] releaseInfo = 
    {
    {"US Theatrical Release", "2024-09-13", "Limited Release"},
    {"Digital Release", "2024-09-13", "United States"},
    {"Blu-Ray Release", "2024-10-08", "United States"},
    {"Distributor", "XYZ Films", ""},
    {"Box Office Gross", "$264,096.00", "Includes International Receipts"}
    };

    // --- Field Descriptions
    String[] fieldDescriptions = {
    "Field 1: Category-Specific Label (e.g., Actor Name, Field, Main Character)",
    "Field 2: Value (e.g., Character Name, Value, Key Plot Point)",
    "Field 3: Additional Information or Notes"
    };

    // --- Record Descriptions
    String[] recordDescriptions = {
    "Each record represents a unique data point about the movie 'Subservience' (2024), grouped by topical category."
    };

    // --- Overall Data Description
    String overallDescription = "This table presents categorized information about the movie 'Subservience' (2024), including cast, production, technical details, plot elements, and release information. Each category contains five records with three fields, providing a comprehensive overview of the film.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Module 2 Assignment: Java Scriptlet - Data Display</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 2 Assignment: Java Scriptlet - Data Display</h1>
        <h2>Movie: <em>Subservience</em> (2024)</h2>

        <p class="description"><%= overallDescription %></p>
    </div>

    <div class="container">
        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <% for (String desc : fieldDescriptions) { %>
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
                <% for (String[] row : castDetails) { %>
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
                <% for (String[] row : productionInfo) { %>
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
                <% for (String[] row : technicalSpecs) { %>
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
                <% for (String[] row : plotElements) { %>
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
                <% for (String[] row : releaseInfo) { %>
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