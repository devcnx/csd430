<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= application.getServletContextName() %></title>
    <style>
        *,
        html,
        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: DM Sans, Iosevka, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1, h2 {
            font-family: Times New Roman, serif;
            font-weight: 100;
            text-transform: uppercase;
            color: #333; 
        }
        h1 { 
            font-size: 2rem;
        }
        h2 {
            font-size: 1.5rem;
        }
        .info-box {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin: 20px 0;
        }
        ul { line-height: 1.6; }
        pre {
            background-color: #2d2d2d;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <h1>Welcome to <%= application.getServletContextName() %></h1>
    
    <div class="info-box">
        <p>This is a JavaServer Page (JSP) running on Apache Tomcat.</p>
        <p>Edit this file at: <code>modules/module_02/src/main/webapp/index.jsp</code></p>
    </div>
    
    <h2>Server Information</h2>
    <div class="info-box">
        <ul>
            <li><strong>Server Info:</strong> <%= application.getServerInfo() %></li>
            <li><strong>Servlet Version:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></li>
            <li><strong>Java Version:</strong> <%= System.getProperty("java.version") %></li>
            <li><strong>Java Home:</strong> <%= System.getProperty("java.home") %></li>
            <li><strong>Current Time:</strong> <%= new java.util.Date().toString().substring(11, 24) %></li>
            <li><strong>Session ID:</strong> <%= session.getId() %></li>
            <li><strong>Context Path:</strong> <%= request.getContextPath() %></li>
        </ul>
    </div>
    
    <h2>Request Information</h2>
    <div class="info-box">
        <ul>
            <li><strong>Method:</strong> <%= request.getMethod() %></li>
            <li><strong>Protocol:</strong> <%= request.getProtocol() %></li>
            <li><strong>Remote Address:</strong> <%= request.getRemoteAddr() %></li>
            <li><strong>Remote Host:</strong> <%= request.getRemoteHost() %></li>
            <li><strong>Request URI:</strong> <%= request.getRequestURI() %></li>
            <li><strong>Request URL:</strong> <%= request.getRequestURL() %></li>
        </ul>
    </div>
    
    <hr>
    <p><small>Deployed to: <code>modules/module_02/src/main/webapp</code></small></p>
</body>
</html>
