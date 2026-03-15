/**
 * MovieBean.java
 * 
 * CSD430 Server-Side Development
 * Module 9 Project Part 4: CRUD-DELETE Operations
 * 
 * Author: Brittaney Perry-Morgan
 * 
 * Description: JavaBean for managing movie database operations using JDBC.
 *              Provides methods for database connectivity, movie retrieval,
 *              insertion, updates, and deletion. Used by JSP pages for CRUD operations.
 * 
 * Database: CSD430
 * Table: brittaney_movies_data
 * 
 * Fields:
 *   - movie_id (INT, Primary Key, Auto-increment)
 *   - title (VARCHAR)
 *   - genre (VARCHAR)
 *   - release_year (INT)
 *   - rating (VARCHAR)
 *   - director (VARCHAR)
 */

package csd430;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean class for movie database operations.
 * Handles JDBC connectivity and CRUD operations for the movie database.
 * 
 * <p>This bean follows the JavaBeans convention with a no-argument constructor
 * and getter/setter methods. Database credentials are loaded from environment
 * variables or a .env file.</p>
 * 
 * <p>Supported operations:</p>
 * <ul>
 *   <li>CREATE - insertMovie()</li>
 *   <li>READ - getAllMovies(), getMovieById(), getAllMovieIds()</li>
 *   <li>UPDATE - updateMovie()</li>
 *   <li>DELETE - deleteMovie(), movieExists()</li>
 * </ul>
 * 
 * @author Brittaney Perry-Morgan
 * @version 1.0
 * @since Module 9 Project Part 4
 */
public class MovieBean {
    
    // Database connection configuration
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    
    // Static initialization block - loads database credentials on class load
    static {
        loadEnvironmentVariables();
    }
    
    /**
     * Loads database connection credentials from environment variables or .env file.
     * Falls back to default values if not found.
     * 
     * <p>Environment variables take precedence:
     * <ul>
     *   <li>DB_URL - JDBC connection URL</li>
     *   <li>DB_USER - Database username</li>
     *   <li>DB_PASSWORD - Database password</li>
     * </ul></p>
     * 
     * <p>Default fallbacks:
     * <ul>
     *   <li>DB_URL: jdbc:mysql://localhost:3306/CSD430</li>
     *   <li>DB_USER: student1</li>
     *   <li>DB_PASSWORD: pass</li>
     * </ul></p>
     */
    private static void loadEnvironmentVariables() {
        DB_URL = System.getenv("DB_URL");
        DB_USER = System.getenv("DB_USER");
        DB_PASSWORD = System.getenv("DB_PASSWORD");
        
        if (DB_URL == null || DB_USER == null || DB_PASSWORD == null) {
            String envFile = System.getProperty("user.dir") + "/.env";
            if (new File(envFile).exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(envFile))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        if (!line.trim().isEmpty() && !line.startsWith("#")) {
                            String[] parts = line.split("=", 2);
                            if (parts.length == 2) {
                                String key = parts[0].trim();
                                String value = parts[1].trim();
                                switch (key) {
                                    case "DB_URL": DB_URL = value; break;
                                    case "DB_USER": DB_USER = value; break;
                                    case "DB_PASSWORD": DB_PASSWORD = value; break;
                                }
                            }
                        }
                    }
                } catch (IOException e) {
                    System.err.println("Error loading .env file: " + e.getMessage());
                }
            }
        }
        
        // Default fallback values
        if (DB_URL == null) DB_URL = "jdbc:mysql://localhost:3306/CSD430";
        if (DB_USER == null) DB_USER = "student1";
        if (DB_PASSWORD == null) DB_PASSWORD = "pass";
    }
    
    // Instance variables
    private Connection connection;
    private List<Integer> movieIds;
    private ResultSet resultSet;
    private String errorMessage;
    
    /**
     * Default constructor - initializes the movie ID list and error message.
     * Required for JavaBeans compatibility.
     */
    public MovieBean() {
        movieIds = new ArrayList<Integer>();
        errorMessage = null;
    }
    
    /**
     * Establishes a connection to the MySQL database using loaded credentials.
     * Loads the MySQL JDBC driver and creates a connection.
     * 
     * @return true if connection successful, false otherwise
     */
    public boolean connect() {
        try {
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
     * Closes the database connection and any open result sets.
     * Should be called when database operations are complete.
     */
    public void disconnect() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            errorMessage = "Error closing connection: " + e.getMessage();
        }
    }
    
    /**
     * Retrieves all movie IDs from the database and stores them in the movieIds list.
     * Results are ordered by movie_id.
     * 
     * @return true if successful, false if an error occurred
     */
    public boolean getAllMovieIds() {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "SELECT movie_id FROM brittaney_movies_data ORDER BY movie_id";
            PreparedStatement stmt = connection.prepareStatement(query);
            resultSet = stmt.executeQuery();
            
            movieIds.clear();
            while (resultSet.next()) {
                movieIds.add(resultSet.getInt("movie_id"));
            }
            resultSet.close();
            stmt.close();
            return true;
        } catch (SQLException e) {
            errorMessage = "Error fetching movie IDs: " + e.getMessage();
            return false;
        }
    }
    
    /**
     * Retrieves a single movie by its ID and populates the result set.
     * Used for fetching movie details for editing or deletion confirmation.
     * 
     * @param movieId the primary key of the movie to retrieve
     * @return true if movie found, false if not found or error occurred
     */
    public boolean getMovieById(int movieId) {
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
                errorMessage = "Movie not found";
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
     * Retrieves all movies from the database in a result set.
     * Results are ordered by movie_id.
     * 
     * @return true if successful, false if an error occurred
     */
    public boolean getAllMovies() {
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
    
    /**
     * Inserts a new movie record into the database.
     * The movie_id is auto-generated by the database.
     * 
     * @param title the movie title
     * @param genre the movie genre
     * @param releaseYear the year of release
     * @param rating the MPAA rating
     * @param director the director's name
     * @return true if insert successful, false otherwise
     */
    public boolean insertMovie(String title, String genre, int releaseYear, String rating, String director) {
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
    
    /**
     * Updates an existing movie record in the database.
     * All fields except movie_id can be modified.
     * 
     * @param movieId the primary key of the movie to update
     * @param title the new movie title
     * @param genre the new movie genre
     * @param releaseYear the new release year
     * @param rating the new MPAA rating
     * @param director the new director's name
     * @return true if update successful, false otherwise
     */
    public boolean updateMovie(int movieId, String title, String genre, int releaseYear, String rating, String director) {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "UPDATE brittaney_movies_data SET title = ?, genre = ?, release_year = ?, rating = ?, director = ? WHERE movie_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, title);
            stmt.setString(2, genre);
            stmt.setInt(3, releaseYear);
            stmt.setString(4, rating);
            stmt.setString(5, director);
            stmt.setInt(6, movieId);
            
            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            return rowsAffected > 0;
        } catch (SQLException e) {
            errorMessage = "Error updating movie: " + e.getMessage();
            return false;
        }
    }
    
    /**
     * Deletes a movie record from the database.
     * Module 9 - DELETE Operation
     * 
     * @param movieId the primary key of the movie to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteMovie(int movieId) {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "DELETE FROM brittaney_movies_data WHERE movie_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, movieId);
            
            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            
            if (rowsAffected > 0) {
                System.out.println("Movie deleted successfully: ID " + movieId);
                return true;
            } else {
                errorMessage = "No movie found with ID: " + movieId;
                return false;
            }
        } catch (SQLException e) {
            errorMessage = "Error deleting movie: " + e.getMessage();
            return false;
        }
    }
    
    /**
     * Checks if a movie exists in the database.
     * Module 9 - DELETE Operation
     * Used to verify existence before deletion.
     * 
     * @param movieId the movie ID to check
     * @return true if movie exists, false otherwise
     */
    public boolean movieExists(int movieId) {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "SELECT COUNT(*) FROM brittaney_movies_data WHERE movie_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, movieId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                rs.close();
                stmt.close();
                return exists;
            }
            rs.close();
            stmt.close();
            return false;
        } catch (SQLException e) {
            errorMessage = "Error checking movie existence: " + e.getMessage();
            return false;
        }
    }
    
    /**
     * Returns the list of movie IDs from the last getAllMovieIds() call.
     * 
     * @return List of movie IDs
     */
    public List<Integer> getMovieIds() {
        return movieIds;
    }
    
    /**
     * Returns the movie_id from the current result set position.
     * 
     * @return the movie ID, or 0 if error
     */
    public int getMovieId() {
        try {
            return resultSet.getInt("movie_id");
        } catch (SQLException e) {
            return 0;
        }
    }
    
    /**
     * Returns the title from the current result set position.
     * 
     * @return the movie title, or empty string if error
     */
    public String getTitle() {
        try {
            return resultSet.getString("title");
        } catch (SQLException e) {
            return "";
        }
    }
    
    /**
     * Returns the genre from the current result set position.
     * 
     * @return the movie genre, or empty string if error
     */
    public String getGenre() {
        try {
            return resultSet.getString("genre");
        } catch (SQLException e) {
            return "";
        }
    }
    
    /**
     * Returns the release year from the current result set position.
     * 
     * @return the release year, or 0 if error
     */
    public int getReleaseYear() {
        try {
            return resultSet.getInt("release_year");
        } catch (SQLException e) {
            return 0;
        }
    }
    
    /**
     * Returns the rating from the current result set position.
     * 
     * @return the MPAA rating, or empty string if error
     */
    public String getRating() {
        try {
            return resultSet.getString("rating");
        } catch (SQLException e) {
            return "";
        }
    }
    
    /**
     * Returns the director from the current result set position.
     * 
     * @return the director name, or empty string if error
     */
    public String getDirector() {
        try {
            return resultSet.getString("director");
        } catch (SQLException e) {
            return "";
        }
    }
    
    /**
     * Returns the last error message from database operations.
     * 
     * @return error message string, or null if no error
     */
    public String getErrorMessage() {
        return errorMessage;
    }
    
    /**
     * Advances the result set to the next row.
     * Used for iterating through query results.
     * 
     * @return true if there is a next row, false if end of results
     */
    public boolean next() {
        try {
            return resultSet.next();
        } catch (SQLException e) {
            errorMessage = "Error navigating result set: " + e.getMessage();
            return false;
        }
    }
}