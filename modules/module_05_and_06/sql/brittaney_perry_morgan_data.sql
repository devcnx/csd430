-- CSD430 Server-Side Development 

-- Module 5 & 6 - Movie Database SQL Script
-- Author: Brittaney Perry-Morgan

-- Table: brittaney_perry_morgan_data

-- Topic: Movies

-- Create the database
CREATE DATABASE IF NOT EXISTS CSD430;
USE CSD430;

-- Create the table with 5 fields (including primary key)
CREATE TABLE IF NOT EXISTS brittaney_perry_morgan_data (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    director VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

-- Insert 10 movie records
INSERT INTO brittaney_perry_morgan_data (movie_title, release_year, director, genre, rating) VALUES
('The Shawshank Redemption', 1994, 'Frank Darabont', 'Drama', 9.3),
('The Godfather', 1972, 'Francis Ford Coppola', 'Crime', 9.2),
('The Dark Knight', 2008, 'Christopher Nolan', 'Action', 9.0),
('Pulp Fiction', 1994, 'Quentin Tarantino', 'Crime', 8.9),
('Forrest Gump', 1994, 'Robert Zemeckis', 'Drama', 8.8),
('Inception', 2010, 'Christopher Nolan', 'Sci-Fi', 8.8),
('The Matrix', 1999, 'The Wachowskis', 'Sci-Fi', 8.7),
('Interstellar', 2014, 'Christopher Nolan', 'Sci-Fi', 8.6),
('Gladiator', 2000, 'Ridley Scott', 'Action', 8.5),
('The Departed', 2006, 'Martin Scorsese', 'Crime', 8.5);

-- Display the records
SELECT * FROM brittaney_perry_morgan_data;