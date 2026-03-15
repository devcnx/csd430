package com.example;

import java.io.Serializable;

/**
 * MovieBean - A JavaBean for storing movie information
 * Used in CSD430 Module 5 & 6 assignment
 * 
 * @author Brittaney Perry-Morgan
 */
public class MovieBean implements Serializable {

    private int movieId;
    private String movieTitle;
    private int releaseYear;
    private String director;
    private String genre;
    private double rating;

    // Default constructor
    public MovieBean() {
        this.movieId = 0;
        this.movieTitle = "";
        this.releaseYear = 0;
        this.director = "";
        this.genre = "";
        this.rating = 0.0;
    }

    // Getter and Setter for movieId
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    // Getter and Setter for movieTitle
    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    // Getter and Setter for releaseYear
    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    // Getter and Setter for director
    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    // Getter and Setter for genre
    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    // Getter and Setter for rating
    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
}