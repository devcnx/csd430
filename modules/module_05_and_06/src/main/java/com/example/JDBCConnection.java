package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBCConnection - Utility class for database operations
 * Used in CSD430 Module 5 & 6 assignment
 * 
 * @author Brittaney Perry-Morgan
 */
public class JDBCConnection {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "newpassword";

    // Method to establish database connection
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    // Method to retrieve all movies (READ operation)
    public static List<MovieBean> getAllMovies() {
        List<MovieBean> movieList = new ArrayList<>();

        String sql = "SELECT * FROM brittaney_perry_morgan_data ORDER BY movie_id";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                MovieBean movie = new MovieBean();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setMovieTitle(rs.getString("movie_title"));
                movie.setReleaseYear(rs.getInt("release_year"));
                movie.setDirector(rs.getString("director"));
                movie.setGenre(rs.getString("genre"));
                movie.setRating(rs.getDouble("rating"));
                movieList.add(movie);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movieList;
    }

    // Method to retrieve a movie by ID (READ operation)
    public static MovieBean getMovieById(int movieId) {
        MovieBean movie = new MovieBean();

        String sql = "SELECT * FROM brittaney_perry_morgan_data WHERE movie_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, movieId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    movie.setMovieId(rs.getInt("movie_id"));
                    movie.setMovieTitle(rs.getString("movie_title"));
                    movie.setReleaseYear(rs.getInt("release_year"));
                    movie.setDirector(rs.getString("director"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setRating(rs.getDouble("rating"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movie;
    }

    // Method to retrieve movies by genre (READ operation)
    public static List<MovieBean> getMoviesByGenre(String genre) {
        List<MovieBean> movieList = new ArrayList<>();

        String sql = "SELECT * FROM brittaney_perry_morgan_data WHERE genre = ? ORDER BY movie_title";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, genre);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MovieBean movie = new MovieBean();
                    movie.setMovieId(rs.getInt("movie_id"));
                    movie.setMovieTitle(rs.getString("movie_title"));
                    movie.setReleaseYear(rs.getInt("release_year"));
                    movie.setDirector(rs.getString("director"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setRating(rs.getDouble("rating"));
                    movieList.add(movie);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movieList;
    }

    // Method to get distinct genres (READ operation)
    public static List<String> getGenres() {
        List<String> genreList = new ArrayList<>();

        String sql = "SELECT DISTINCT genre FROM brittaney_perry_morgan_data ORDER BY genre";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                genreList.add(rs.getString("genre"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return genreList;
    }
}