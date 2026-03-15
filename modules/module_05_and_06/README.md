# CSD430 SERVER-SIDE DEVELOPMENT

<!-- markdownlint-disable -->
<small style="font-size: 0.9em; font-family: 'Proxima Nova Alt', sans-serif; text-align: justify;">
<!-- markdownlint-enable -->

**Term**: 2265 Spring  
**Duration**: January 2026 - March 2026

**Author**: Brittaney Perry-Morgan  

**Instructor**: Jack Lusby  
**Institution**: Bellevue University

## Module 5 & 6 Assignment - Working with CRUD-READ, JDBC, & JavaBeans

## Assignment Overview

This assignment focuses on **database setup** using MySQL. You will create a
database, build a table with appropriate fields, and populate it with sample data.

## Requirements

- [x] Create MySQL database named `CSD430`
- [x] Create table with minimum 5 fields (one being a primary key)
- [x] Insert minimum 10 records
- [ ] Screenshots of database and table in MySQL Workbench
- [ ] Screenshots showing all records in the table

## Database Configuration

| Setting     | Value                   |
|-------------|-------------------------|
| Database    | `CSD430`                |
| Table       | `brittaney_movies_data` |
| Username    | `student1`              |
| Password    | `pass`                  |

## Table Fields

| Field         | Type         | Description            |
|---------------|--------------|------------------------|
| `movie_id`    | INT          | Primary Key, Auto-inc  |
| `title`       | VARCHAR(100) | Movie title            |
| `genre`       | VARCHAR(50)  | Movie genre            |
| `release_year`| INT          | Year released          |
| `rating`      | VARCHAR(10)  | MPAA rating            |
| `director`    | VARCHAR(100) | Director name          |

## Files

| File                              | Description            |
|-----------------------------------|------------------------|
| `brittaney_movies_data.sql`       | SQL script for setup   |
| `deliverables/screenshot_*.html`  | Screenshot templates   |

## Setup Instructions

1. Start MySQL:

   ```bash
   brew services start mysql
   ```

2. Run the SQL script:

   ```bash
   mysql -u root -p < brittaney_movies_data.sql
   ```

3. Create the user (if not exists):

   ```sql
   CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
   GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
   FLUSH PRIVILEGES;
   ```

## Screenshots Required

1. MySQL Workbench showing the `CSD430` database
2. Table structure (DESCRIBE or Schema view)
3. All records in the table (`SELECT * FROM brittaney_movies_data`)

## Submission

- Screenshots combined in a Word document
- SQL file
- Submit to GitHub repository

---
s
</small>
s
