# Module 5 & 6 Assignment - Working with CRUD-READ, JDBC, & JavaBeans

## Assignment Overview

This assignment focuses on **database setup** using MySQL. You will create a database, build a table with appropriate fields, and populate it with sample data.

## Requirements

- [x] Create MySQL database named `CSD430`
- [x] Create table with minimum 5 fields (one being a primary key)
- [x] Insert minimum 10 records
- [ ] Screenshots of database and table in MySQL Workbench
- [ ] Screenshots showing all records in the table

## Database Configuration

| Setting | Value |
|---------|-------|
| Database Name | `CSD430` |
| Username | `student1` |
| Password | `pass` |
| Table Name | `brittaney_movies_data` |

## Files

| File | Description |
|------|-------------|
| `brittaney_movies_data.sql` | SQL script to create database, table, and insert records |
| `screenshots/` | Folder for MySQL Workbench screenshots |

## How to Run

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
3. All records in the table (SELECT * FROM brittaney_movies_data)

## Submission

- Screenshots combined in a Word document
- SQL file
- File naming: `perrymorgan-mod56-csd430.zip`

---

**Student:** Brittney Perry-Morgan  
**Course:** CSD430 Server-Side Development  
**Term:** 2265 Spring