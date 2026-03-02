# Module 5 & 6 Assignment - Project Part 1

## Assignment Overview

This project implements the **READ** operation of CRUD using a JavaBean to connect to a MySQL database and display data via JSP pages.

## Requirements

- [x] JavaBean for database connection and data retrieval
- [x] HTML Dropdown Menu with all primary keys from database
- [x] User selects a single unique key
- [x] JSP displays selected record in HTML table
- [x] Table has all fields in separate columns with `<thead>` headers
- [x] Minimum 5 fields displayed
- [x] Scriptlets used for Java code
- [x] HTML tags outside of Scriptlets
- [x] Code documented with comments
- [x] Field and record descriptions included
- [ ] Screenshots of running application
- [ ] Word document with screenshots

## Project Structure

```
module_05_and_06_project_1/
├── .env                    # Database credentials (not committed to git)
├── MovieBean.java          # JavaBean for JDBC database operations
├── index.jsp               # Course index page with links
├── movie_selection.jsp     # Dropdown form for selecting movies
├── movie_display.jsp       # Displays selected movie in HTML table
├── WEB-INF/
│   └── classes/
│       └── csd430/         # Compiled .class files go here
└── screenshots/            # Folder for application screenshots
```

## Database Configuration

| Setting | Value |
|---------|-------|
| Database | `CSD430` |
| Table | `brittaney_movies_data` |
| Username | `student1` |
| Password | `pass` |

## Table Fields

| Field | Type | Description |
|-------|------|-------------|
| `movie_id` | INT | Primary Key, Auto-increment |
| `title` | VARCHAR(100) | Movie title |
| `genre` | VARCHAR(50) | Movie genre |
| `release_year` | INT | Year released |
| `rating` | VARCHAR(10) | MPAA rating |
| `director` | VARCHAR(100) | Director name |

## How to Run

### Prerequisites
1. MySQL running with `CSD430` database and `brittaney_movies_data` table
2. Tomcat 10.x running
3. MySQL JDBC driver in Tomcat's `lib/` folder

### Deploy to Tomcat

```bash
# Set Tomcat path
TOMCAT_WEBAPPS=/opt/homebrew/opt/tomcat@10/libexec/webapps

# Create webapp directory
mkdir -p $TOMCAT_WEBAPPS/module_05_and_06_project_1/WEB-INF/classes/csd430

# Copy JSP files
cp *.jsp $TOMCAT_WEBAPPS/module_05_and_06_project_1/

# Copy .env file
cp .env $TOMCAT_WEBAPPS/module_05_and_06_project_1/

# Compile JavaBean
javac -d $TOMCAT_WEBAPPS/module_05_and_06_project_1/WEB-INF/classes MovieBean.java

# Restart Tomcat
brew services restart tomcat@10
```

### Access Application

Open browser to: `http://localhost:8080/module_05_and_06_project_1/`

## Screenshots Required

1. Application home page (`index.jsp`)
2. Movie selection dropdown (`movie_selection.jsp`)
3. Movie details displayed in table (`movie_display.jsp`)
4. Word document with name, date, assignment number

## Technical Notes

- Uses JDBC for MySQL connectivity
- JavaBean handles database connection and queries
- Scriptlets (`<% %>`) used for Java code in JSPs
- HTML table uses `<thead>` and `<tbody>` for structure
- Error handling for database connection failures

## Submission

- All source code files (.java, .jsp)
- Screenshots in Word document
- Push to GitHub repository
- Submit GitHub URL
- File naming: `perrymorgan-mod56-csd430.zip`

---

**Student:** Brittaney Perry-Morgan  
**Course:** CSD430 Server-Side Development  
**Term:** 2265 Spring