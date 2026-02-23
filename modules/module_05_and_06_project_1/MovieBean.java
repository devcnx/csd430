package csd430;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieBean {
    
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    
    static {
        loadEnvironmentVariables();
    }
    
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
        
        if (DB_URL == null) DB_URL = "jdbc:mysql://localhost:3306/CSD430";
        if (DB_USER == null) DB_USER = "student1";
        if (DB_PASSWORD == null) DB_PASSWORD = "pass";
    }
    }
    
    private Connection connection;
    private List<Integer> movieIds;
    private ResultSet resultSet;
    private String errorMessage;
    
    public MovieBean() {
        movieIds = new ArrayList<Integer>();
        errorMessage = null;
    }
    
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
    
    public boolean getAllMovieIds() {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "SELECT movie_id FROM brittany_movies_data ORDER BY movie_id";
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
    
    public boolean getMovieById(int movieId) {
        if (connection == null) {
            if (!connect()) {
                return false;
            }
        }
        
        try {
            String query = "SELECT * FROM brittany_movies_data WHERE movie_id = ?";
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
    
    public List<Integer> getMovieIds() {
        return movieIds;
    }
    
    public int getMovieId() {
        try {
            return resultSet.getInt("movie_id");
        } catch (SQLException e) {
            return 0;
        }
    }
    
    public String getTitle() {
        try {
            return resultSet.getString("title");
        } catch (SQLException e) {
            return "";
        }
    }
    
    public String getGenre() {
        try {
            return resultSet.getString("genre");
        } catch (SQLException e) {
            return "";
        }
    }
    
    public int getReleaseYear() {
        try {
            return resultSet.getInt("release_year");
        } catch (SQLException e) {
            return 0;
        }
    }
    
    public String getRating() {
        try {
            return resultSet.getString("rating");
        } catch (SQLException e) {
            return "";
        }
    }
    
    public String getDirector() {
        try {
            return resultSet.getString("director");
        } catch (SQLException e) {
            return "";
        }
    }
    
    public String getErrorMessage() {
        return errorMessage;
    }
}
