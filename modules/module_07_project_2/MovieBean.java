package csd430;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * MovieBean - JDBC JavaBean for CRUD Operations.
 *
 * <p>
 * This JavaBean provides database connectivity using JDBC to perform
 * CRUD (Create, Read, Update, Delete) operations on movie records
 * in a MySQL database. This bean is used across multiple modules:
 * </p>
 * <ul>
 *   <li>Module 5&amp;6 Project Part 1: CRUD-READ operations</li>
 *   <li>Module 7 Project Part 2: CRUD-CREATE operations</li>
 * </ul>
 *
 * <p>
 * The bean follows JavaBean conventions with getter methods for each property
 * and uses PreparedStatement to prevent SQL injection attacks.
 * </p>
 *
 * <p>
 * Database configuration is loaded from environment variables or a .env file
 * with fallback defaults for local development.
 * </p>
 *
 * @author Brittaney Perry-Morgan
 * @version 2.0
 * @since CSD430 Module 5 &amp; 6 Project Part 1
 */
public class MovieBean {

    // =========================
    // Database Configuration
    // =========================

    /** Database connection URL (e.g., jdbc:mysql://localhost:3306/CSD430) */
    private static String DB_URL;

    /** Database username for authentication */
    private static String DB_USER;

    /** Database password for authentication */
    private static String DB_PASSWORD;

    /**
     * Static initializer block that loads database configuration.
     *
     * <p>
     * Configuration is loaded in the following order of precedence:
     * </p>
     * <ol>
     *   <li>Environment variables (DB_URL, DB_USER, DB_PASSWORD)</li>
     *   <li>.env file in the application root directory</li>
     *   <li>Default fallback values</li>
     * </ol>
     */
    static {
        loadEnvironmentVariables();
    }

    /**
     * Loads database configuration from environment variables or .env file.
     *
     * <p>
     * This method attempts to read configuration from system environment
     * variables first. If not found, it looks for a .env file in the
     * application directory. If neither source provides configuration,
     * default values are used.
     * </p>
     */
    private static void loadEnvironmentVariables() {
        // Try environment variables first
        DB_URL = System.getenv("DB_URL");
        DB_USER = System.getenv("DB_USER");
        DB_PASSWORD = System.getenv("DB_PASSWORD");

        // Fall back to .env file if environment variables not set
        if (DB_URL == null || DB_USER == null || DB_PASSWORD == null) {
            String envFile = System.getProperty("user.dir") + "/.env";
            File file = new File(envFile);

            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        // Skip empty lines and comments
                        if (line.trim().isEmpty() || line.trim().startsWith("#")) {
                            continue;
                        }

                        String[] parts = line.split("=", 2);
                        if (parts.length == 2) {
                            String key = parts[0].trim();
                            String value = parts[1].trim();

                            switch (key) {
                                case "DB_URL":
                                    DB_URL = value;
                                    break;
                                case "DB_USER":
                                    DB_USER = value;
                                    break;
                                case "DB_PASSWORD":
                                    DB_PASSWORD = value;
                                    break;
                                default:
                                    // Ignore unknown keys
                                    break;
                            }
                        }
                    }
                } catch (IOException e) {
                    System.err.println("Error loading .env file: " + e.getMessage());
                }
            }
        }

        // Apply default values if still null
        if (DB_URL == null) {
            DB_URL = "jdbc:mysql://localhost:3306/CSD430";
        }
        if (DB_USER == null) {
            DB_USER = "student1";
        }
        if (DB_PASSWORD == null) {
            DB_PASSWORD = "pass";
        }
    }

    // =========================
    // Instance Fields
    // =========================

    /** Active database connection for this bean instance */
    private Connection connection;

    /** List of movie IDs retrieved from the database */
    private List<Integer> movieIds;

    /** ResultSet containing the current movie records */
    private ResultSet resultSet;

    /** Error message from the last failed operation */
    private String errorMessage;

    // =========================
    // Constructors
    // =========================

    /**
     * Constructs a new MovieBean instance.
     *
     * <p>
     * Initializes the movie IDs list and sets the error message to null.
     * Database connection is established lazily when needed.
     * </p>
     */
    public MovieBean() {
        movieIds = new ArrayList<>();
        errorMessage = null;
    }

    // =========================
    // Database Connection Methods
    // =========================

    /**
     * Establishes a connection to the MySQL database.
     *
     * <p>
     * This method loads the MySQL JDBC driver and creates a connection
     * using the configured URL, username, and password. It supports
     * both the newer com.mysql.cj.jdbc.Driver and legacy com.mysql.jdbc.Driver.
     * </p>
     *
     * @return {@code true} if connection was successful, {@code false} otherwise
     */
    public boolean connect() {
        try {
            // Try newer driver first, fall back to legacy driver
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                Class.forName("com.mysql.jdbc.Driver");
            }

            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            return true;

        } catch (ClassNotFoundException e) {
            errorMessage = "MySQL Driver not found: " + e.getMessage();
            return false;
        } catch (SQLException e) {
            errorMessage = "Database connection error: " + e.getMessage();
            return false;
        }
    }

    /**
     * Closes the database connection and releases resources.
     *
     * <p>
     * This method should be called when the bean is no longer needed
     * to prevent resource leaks. It safely handles null connections
     * and result sets.
     * </p>
     */
    public void disconnect() {
        try {
            if (resultSet != null) {
                resultSet.close();
                resultSet = null;
            }
            if (connection != null) {
                connection.close();
                connection = null;
            }
        } catch (SQLException e) {
            errorMessage = "Error closing connection: " + e.getMessage();
        }
    }

    // =========================
    // CRUD-READ Methods
    // =========================

    /**
     * Retrieves all movie IDs from the database.
     *
     * <p>
     * This method queries the database for all movie_id values and
     * populates the internal movieIds list. The IDs are ordered
     * ascending for consistent dropdown display.
     * </p>
     *
     * <p>
     * If no connection exists, this method will attempt to connect
     * automatically.
     * </p>
     *
     * @return {@code true} if IDs were retrieved successfully,
     *         {@code false} if an error occurred
     */
    public boolean getAllMovieIds() {
        // Ensure connection exists
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }

        try {
            String query = "SELECT movie_id FROM brittaney_movies_data ORDER BY movie_id";
            PreparedStatement stmt = connection.prepareStatement(query);
            resultSet = stmt.executeQuery();

            // Clear existing list and populate with new IDs
            movieIds.clear();
            while (resultSet.next()) {
                movieIds.add(resultSet.getInt("movie_id"));
            }

            // Clean up resources
            resultSet.close();
            stmt.close();
            return true;

        } catch (SQLException e) {
            errorMessage = "Error fetching movie IDs: " + e.getMessage();
            return false;
        }
    }

    /**
     * Retrieves a single movie record by its primary key.
     *
     * <p>
     * This method queries the database for a specific movie using
     * the movie_id parameter. If found, the ResultSet is stored
     * internally and can be accessed via the getter methods.
     * </p>
     *
     * <p>
     * Uses PreparedStatement to prevent SQL injection attacks.
     * </p>
     *
     * @param movieId the primary key of the movie to retrieve
     * @return {@code true} if the movie was found, {@code false} otherwise
     */
    public boolean getMovieById(int movieId) {
        // Ensure connection exists
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }

        try {
            String query = "SELECT * FROM brittaney_movies_data WHERE movie_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, movieId);
            resultSet = stmt.executeQuery();

            if (!resultSet.next()) {
                errorMessage = "Movie not found with ID: " + movieId;
                resultSet.close();
                stmt.close();
                return false;
            }

            return true;

        } catch (SQLException e) {
            errorMessage = "Error fetching movie: " + e.getMessage();
            return false;
        }
    }

    /**
     * Retrieves all movie records from the database.
     *
     * <p>
     * This method queries the database for all movies and stores
     * the ResultSet internally. Use {@link #next()} to iterate
     * through records and getter methods to access field values.
     * </p>
     *
     * @return {@code true} if records were retrieved successfully,
     *         {@code false} if an error occurred
     */
    public boolean getAllMovies() {
        // Ensure connection exists
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }

        try {
            String query = "SELECT * FROM brittaney_movies_data ORDER BY movie_id";
            PreparedStatement stmt = connection.prepareStatement(query);
            resultSet = stmt.executeQuery();
            return true;

        } catch (SQLException e) {
            errorMessage = "Error fetching movies: " + e.getMessage();
            return false;
        }
    }

    // =========================
    // CRUD-CREATE Methods
    // =========================

    /**
     * Inserts a new movie record into the database.
     *
     * <p>
     * This method creates a new movie record with the provided field values.
     * The movie_id is auto-generated by the database (AUTO_INCREMENT).
     * Uses PreparedStatement to prevent SQL injection attacks.
     * </p>
     *
     * @param title the title of the movie
     * @param genre the genre of the movie
     * @param releaseYear the year the movie was released
     * @param rating the MPAA rating (G, PG, PG-13, R, NC-17)
     * @param director the director of the movie
     * @return {@code true} if the record was inserted successfully,
     *         {@code false} if an error occurred
     */
    public boolean insertMovie(String title, String genre, int releaseYear, String rating, String director) {
        // Ensure connection exists
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }

        try {
            String query = "INSERT INTO brittaney_movies_data (title, genre, release_year, rating, director) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, title);
            stmt.setString(2, genre);
            stmt.setInt(3, releaseYear);
            stmt.setString(4, rating);
            stmt.setString(5, director);

            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            return rowsAffected > 0;

        } catch (SQLException e) {
            errorMessage = "Error inserting movie: " + e.getMessage();
            return false;
        }
    }

    // =========================
    // Getter Methods (JavaBean Properties)
    // =========================

    /**
     * Returns the list of all movie IDs.
     *
     * <p>
     * This list is populated by the {@link #getAllMovieIds()} method.
     * </p>
     *
     * @return a List of Integer movie IDs, or an empty list if not yet populated
     */
    public List<Integer> getMovieIds() {
        return movieIds;
    }

    /**
     * Returns the movie_id of the current record.
     *
     * <p>
     * This method should only be called after a successful call to
     * {@link #getMovieById(int)} or during iteration with {@link #next()}.
     * </p>
     *
     * @return the movie ID, or 0 if an error occurs
     */
    public int getMovieId() {
        try {
            return resultSet.getInt("movie_id");
        } catch (SQLException e) {
            return 0;
        }
    }

    /**
     * Returns the title of the current movie record.
     *
     * @return the movie title, or an empty string if an error occurs
     */
    public String getTitle() {
        try {
            return resultSet.getString("title");
        } catch (SQLException e) {
            return "";
        }
    }

    /**
     * Returns the genre of the current movie record.
     *
     * @return the movie genre, or an empty string if an error occurs
     */
    public String getGenre() {
        try {
            return resultSet.getString("genre");
        } catch (SQLException e) {
            return "";
        }
    }

    /**
     * Returns the release year of the current movie record.
     *
     * @return the release year, or 0 if an error occurs
     */
    public int getReleaseYear() {
        try {
            return resultSet.getInt("release_year");
        } catch (SQLException e) {
            return 0;
        }
    }

    /**
     * Returns the MPAA rating of the current movie record.
     *
     * @return the rating (e.g., "PG-13", "R"), or an empty string if an error occurs
     */
    public String getRating() {
        try {
            return resultSet.getString("rating");
        } catch (SQLException e) {
            return "";
        }
    }

    /**
     * Returns the director of the current movie record.
     *
     * @return the director name, or an empty string if an error occurs
     */
    public String getDirector() {
        try {
            return resultSet.getString("director");
        } catch (SQLException e) {
            return "";
        }
    }

    // =========================
    // Navigation Methods
    // =========================

    /**
     * Advances to the next record in the ResultSet.
     *
     * <p>
     * This method is used to iterate through multiple records returned
     * by {@link #getAllMovies()}. Returns false when there are no more
     * records.
     * </p>
     *
     * @return {@code true} if there is a next record, {@code false} otherwise
     */
    public boolean next() {
        try {
            return resultSet.next();
        } catch (SQLException e) {
            errorMessage = "Error navigating result set: " + e.getMessage();
            return false;
        }
    }

    // =========================
    // Error Handling
    // =========================

    /**
     * Returns the error message from the last failed operation.
     *
     * <p>
     * This method should be called after a method returns {@code false}
     * to determine the cause of the failure.
     * </p>
     *
     * @return the error message, or {@code null} if no error occurred
     */
    public String getErrorMessage() {
        return errorMessage;
    }
}