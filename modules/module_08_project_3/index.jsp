<%-- 
    CSD380 Course Index - Module 08 Assignment
    Student: Brittaney Perry-Morgan
    This index page provides links to all module's CRUD deliverables
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSD430 - Database Management Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            text-align: center;
            border-bottom: 2px solid #0066cc;
            padding-bottom: 10px;
        }
        .course-info {
            text-align: center;
            margin-bottom: 30px;
            color: #666;
        }
        .module-list {
            list-style: none;
            padding: 0;
        }
        .module-list li {
            margin: 15px 0;
        }
        .module-list a {
            display: block;
            padding: 15px 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
        }
        .module-list a:hover {
            background-color: #ffc107;
            color: #333;
            border-color: #ffc107;
        }
        .module-list a.current {
            background-color: #ffc107;
            color: #333;
            border-color: #ffc107;
        }
        .module-title {
            font-weight: bold;
            font-size: 1.1em;
        }
        .module-desc {
            font-size: 0.9em;
            margin-top: 5px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <h1>CSD430 - Database Management</h1>
    
    <div class="course-info">
        <p>Student: Brittaney Perry-Morgan</p>
        <p>Course: CSD380 - Working with JDBC, JavaBeans, and CRUD Operations</p>
    </div>
    
    <ul class="module-list">
        <li>
            <a href="movie_update.jsp" class="current">
                <div class="module-title">Module 08 - Movies Database (CRUD-UPDATE)</div>
                <div class="module-desc">Update existing movie records in the database</div>
            </a>
        </li>
    </ul>
    
    <h2>Access Module 08 Assignment</h2>
    <p>Click the link below to access the Movie Database application:</p>
    <p><a href="movie_update.jsp" style="color: #0066cc; font-weight: bold;">Update Movie</a></p>
    <p><a href="movie_display.jsp?movieId=1" style="color: #0066cc; font-weight: bold;">View Movie (Example)</a></p>
    
</body>
</html>
