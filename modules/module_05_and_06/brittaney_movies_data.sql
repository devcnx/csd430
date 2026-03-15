-- CSD430 Database Setup Script
-- Student: Brittaney Perry-Morgan
-- Course: CSD430
-- Module 05 & 06 Assignment

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS CSD430;
USE CSD430;

-- Drop table if exists for clean setup
DROP TABLE IF EXISTS brittaney_movies_data;

-- Create movies_data table with 5+ fields
-- movie_id is primary key
CREATE TABLE brittaney_movies_data (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL,
    rating VARCHAR(10) NOT NULL,
    director VARCHAR(100) NOT NULL
);

-- Insert minimum 10 records
INSERT INTO brittaney_movies_data (title, genre, release_year, rating, director) VALUES
('The Shawshank Redemption', 'Drama', 1994, 'R', 'Frank Darabont'),
('The Godfather', 'Crime', 1972, 'R', 'Francis Ford Coppola'),
('The Dark Knight', 'Action', 2008, 'PG-13', 'Christopher Nolan'),
('Pulp Fiction', 'Crime', 1994, 'R', 'Quentin Tarantino'),
('The Lord of the Rings: The Return of the King', 'Fantasy', 2003, 'PG-13', 'Peter Jackson'),
('Forrest Gump', 'Drama', 1994, 'PG-13', 'Robert Zemeckis'),
('Inception', 'Sci-Fi', 2010, 'PG-13', 'Christopher Nolan'),
('The Matrix', 'Sci-Fi', 1999, 'R', 'The Wachowskis'),
('Titanic', 'Romance', 1997, 'PG-13', 'James Cameron'),
('The Silence of the Lambs', 'Thriller', 1991, 'R', 'Jonathan Demme'),
('Gladiator', 'Action', 2000, 'R', 'Ridley Scott'),
('The Avengers', 'Superhero', 2012, 'PG-13', 'Joss Whedon');

-- Verify data
SELECT * FROM brittaney_movies_data;

-- Grant permissions for student1 user
-- Note: This should be run by database admin
-- GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost' IDENTIFIED BY '****';
-- FLUSH PRIVILEGES;
