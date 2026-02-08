#!/bin/bash
# setup_webapp.sh - Create a Java webapp structure in a specified location
# Usage: ./setup_webapp.sh [webapp_name] [base_path]

set -e

# Default values
DEFAULT_BASE_PATH="modules"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print messages
print_msg() {
    local color=$1
    local msg=$2
    echo -e "${color}${msg}${NC}"
}

# Function to print usage
print_usage() {
    echo "Usage: $0 [webapp_name] [base_path]"
    echo ""
    echo "Arguments:"
    echo "  webapp_name    Name of the web application (e.g., module_01, myapp)"
    echo "  base_path      Base directory path (optional, default: modules)"
    echo ""
    echo "Examples:"
    echo "  $0 module_01                          # Creates: modules/module_01/src/main/webapp"
    echo "  $0 module_01 snippets                 # Creates: snippets/module_01/src/main/webapp"
    echo "  $0 module_01 modules                  # Creates: modules/module_01/src/main/webapp"
    echo "  $0 module_01 .                        # Creates: ./module_01/src/main/webapp"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "The script creates a Maven-style webapp structure:"
    echo "  [base_path]/[webapp_name]/src/main/webapp/"
    echo "  ├── index.jsp"
    echo "  └── WEB-INF/"
    echo "      └── web.xml"
}

# Parse arguments
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    print_usage
    exit 0
fi

WEBAPP_NAME="${1:-}"
BASE_PATH="${2:-$DEFAULT_BASE_PATH}"

# Validate webapp name
if [[ -z "$WEBAPP_NAME" ]]; then
    print_msg "$RED" "Error: Webapp name is required."
    print_usage
    exit 1
fi

# Determine the target directory
APP_DIR="$BASE_PATH/$WEBAPP_NAME/src/main/webapp"

# Check if CATALINA_HOME is set
if [[ -z "$CATALINA_HOME" ]]; then
    print_msg "$RED" "Error: CATALINA_HOME is not set."
    print_msg "$YELLOW" "Please set CATALINA_HOME in your shell profile (e.g., ~/.zshrc):"
    print_msg "$YELLOW" "  export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec"
    print_msg "$YELLOW" "Then run: source ~/.zshrc"
    exit 1
fi

# Check if Tomcat is running
if ! pgrep -f "tomcat" > /dev/null 2>&1; then
    print_msg "$YELLOW" "Warning: Tomcat appears to not be running."
    print_msg "$YELLOW" "Start it with: $CATALINA_HOME/bin/startup.sh"
    echo ""
fi

# Create directory structure
print_msg "$GREEN" "Creating webapp structure at: $APP_DIR"
mkdir -p "$APP_DIR/WEB-INF"

# Create index.jsp
cat > "$APP_DIR/index.jsp" << EOF
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= application.getServletContext().getServletContextName() %></title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 { color: #333; }
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
    <h1>Welcome to <%- application.getServletContext().getServletContextName() %></h1>
    
    <div class="info-box">
        <p>This is a JavaServer Page (JSP) running on Apache Tomcat.</p>
        <p>Edit this file at: <code>$APP_DIR/index.jsp</code></p>
    </div>
    
    <h2>Server Information</h2>
    <div class="info-box">
        <ul>
            <li><strong>Server Info:</strong> <%= application.getServerInfo() %></li>
            <li><strong>Servlet Version:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></li>
            <li><strong>Java Version:</strong> <%= System.getProperty("java.version") %></li>
            <li><strong>Java Home:</strong> <%= System.getProperty("java.home") %></li>
            <li><strong>Current Time:</strong> <%= new java.util.Date() %></li>
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
    
    <h2>Available Parameters</h2>
    <div class="info-box">
        <%
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            if (paramNames.hasMoreElements()) {
                out.println("<ul>");
                while (paramNames.hasMoreElements()) {
                    String paramName = paramNames.nextElement();
                    out.println("<li><strong>" + paramName + ":</strong> " + request.getParameter(paramName) + "</li>");
                }
                out.println("</ul>");
            } else {
                out.println("<p>No parameters provided. Try: <a href=\"?name=John&course=CSD430\">?name=John&course=CSD430</a></p>");
            }
        %>
    </div>
    
    <hr>
    <p><small>Deployed to: <code>$APP_DIR</code></small></p>
</body>
</html>
EOF

# Create web.xml
cat > "$APP_DIR/WEB-INF/web.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
         http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    
    <display-name>${WEBAPP_NAME}</display-name>
    <description>Web application for ${WEBAPP_NAME}</description>
    
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
        <welcome-file>index.html</welcome-file>
        <welcome-file>index.htm</welcome-file>
    </welcome-file-list>
    
    <!-- Example servlet configuration -->
    <!--
    <servlet>
        <servlet-name>ExampleServlet</servlet-name>
        <servlet-class>com.example.ExampleServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>ExampleServlet</servlet-name>
        <url-pattern>/example</url-pattern>
    </servlet-mapping>
    -->
    
</web-app>
EOF

print_msg "$GREEN" "✓ Created webapp structure"
print_msg "$GREEN" "  - index.jsp"
print_msg "$GREEN" "  - WEB-INF/web.xml"
echo ""

# Extract just the webapp name from the path for deployment info
DEPLOY_NAME="$WEBAPP_NAME"

# Display deployment info
echo "To deploy this webapp:"
echo "  1. Run: ./deploy_modules.sh"
echo "  2. Access at: http://localhost:8080/${DEPLOY_NAME}/"
echo ""
echo "Or manually copy:"
echo "  mkdir -p \${CATALINA_HOME}/webapps/${DEPLOY_NAME}"
echo "  cp -r $APP_DIR/* \${CATALINA_HOME}/webapps/${DEPLOY_NAME}/"
echo ""

print_msg "$GREEN" "Setup complete!"