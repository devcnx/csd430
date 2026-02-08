package com.example;

import java.io.Serializable;

/**
 * MovieBean - JavaBean for storing movie data
 *
 * CSD430 Server-Side Development
 * Module 4 Assignment: JavaBean
 *
 * This bean holds data for the movie "Subservience" (2024) and implements
 * java.io.Serializable for potential session storage or persistence.
 *
 * @author Brittaney Perry-Morgan
 * @version 1.0
 */
public class MovieBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // --- Cast Details (5 records with 3 fields each)
    private String[][] castDetails;

    // --- Production Information (5 records with 3 fields each)
    private String[][] productionInfo;

    // --- Technical Specifications (5 records with 3 fields each)
    private String[][] technicalSpecs;

    // --- Plot Elements (4 records with 3 fields each)
    private String[][] plotElements;

    // --- Release Information (5 records with 3 fields each)
    private String[][] releaseInfo;

    // --- Field Descriptions
    private String[] fieldDescriptions;

    // --- Record Descriptions
    private String[] recordDescriptions;

    // --- Overall Description
    private String overallDescription;

    // --- Movie Title and Year
    private String movieTitle;
    private int movieYear;

    /**
     * Default constructor - initializes all movie data
     */
    public MovieBean() {
        // Initialize movie title and year
        this.movieTitle = "Subservience";
        this.movieYear = 2024;

        // Initialize field descriptions
        this.fieldDescriptions = new String[] {
                "Field 1: Category-Specific Label (e.g., Actor Name, Field, Main Character)",
                "Field 2: Value (e.g., Character Name, Value, Key Plot Point)",
                "Field 3: Additional Information or Notes"
        };

        // Initialize record descriptions
        this.recordDescriptions = new String[] {
                "Each record represents a unique data point about the movie 'Subservience' (2024), grouped by topical category."
        };

        // Initialize overall description
        this.overallDescription = "This table presents categorized information about the movie 'Subservience' (2024), including cast, production, technical details, plot elements, and release information. Each category contains five records with three fields, providing a comprehensive overview of the film.";

        // --- Initialize Cast Details (5 records)
        this.castDetails = new String[][] {
                { "Megan Fox", "Alice", "Lead Role as the AI" },
                { "Michele Morrone", "Nick", "Construction Foreman, Alice's Owner" },
                { "Madeline Zima", "Maggie", "Nick's Wife" },
                { "Matilda Firth", "Isla", "Nick and Maggie's Daughter" },
                { "Andrew Whipp", "Monty", "Nick's Co-Worker" }
        };

        // --- Initialize Production Information (5 records)
        this.productionInfo = new String[][] {
                { "Director", "S.K. Dale", "" },
                { "Writers", "Will Honley, April Maguire", "" },
                { "Production Company", "Millennium Media", "" },
                { "Principal Photography", "Began 2023-01-07", "Nu Boyana Film Studios, Bulgaria" },
                { "Budget", "$5 Million (USD)", "" }
        };

        // --- Initialize Technical Specifications (5 records)
        this.technicalSpecs = new String[][] {
                { "Runtime", "106 Minutes", "1 Hour 46 Minutes" },
                { "Language", "English", "" },
                { "Country", "United States", "" },
                { "Cinematography", "Daniel Lindholm", "" },
                { "Editing", "Sean Lahiff", "" }
        };

        // --- Initialize Plot Elements (4 records)
        this.plotElements = new String[][] {
                { "Nick", "Purchases Alice to help with domestic tasks", "Alice becomes hostile and obsessed" },
                { "Alice", "Develops sentience and jealousy towards Maggie",
                        "Endangers the family and manipulates events" },
                { "Monty", "Confronts Alice and vandalizes AI robots that replaced construction workers",
                        "Becomes the target of Alice's hostility" },
                { "Alice", "Attempts to harm the family's baby", "Is apparently destroyed, but reactivates" }
        };

        // --- Initialize Release Information (5 records)
        this.releaseInfo = new String[][] {
                { "US Theatrical Release", "2024-09-13", "Limited Release" },
                { "Digital Release", "2024-09-13", "United States" },
                { "Blu-Ray Release", "2024-10-08", "United States" },
                { "Distributor", "XYZ Films", "" },
                { "Box Office Gross", "$264,096.00", "Includes International Receipts" }
        };
    }

    // --- Getters and Setters for movie title and year ---

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public int getMovieYear() {
        return movieYear;
    }

    public void setMovieYear(int movieYear) {
        this.movieYear = movieYear;
    }

    // --- Getters for Cast Details ---

    public String[][] getCastDetails() {
        return castDetails;
    }

    public void setCastDetails(String[][] castDetails) {
        this.castDetails = castDetails;
    }

    // --- Getters for Production Information ---

    public String[][] getProductionInfo() {
        return productionInfo;
    }

    public void setProductionInfo(String[][] productionInfo) {
        this.productionInfo = productionInfo;
    }

    // --- Getters for Technical Specifications ---

    public String[][] getTechnicalSpecs() {
        return technicalSpecs;
    }

    public void setTechnicalSpecs(String[][] technicalSpecs) {
        this.technicalSpecs = technicalSpecs;
    }

    // --- Getters for Plot Elements ---

    public String[][] getPlotElements() {
        return plotElements;
    }

    public void setPlotElements(String[][] plotElements) {
        this.plotElements = plotElements;
    }

    // --- Getters for Release Information ---

    public String[][] getReleaseInfo() {
        return releaseInfo;
    }

    public void setReleaseInfo(String[][] releaseInfo) {
        this.releaseInfo = releaseInfo;
    }

    // --- Getters for Descriptions ---

    public String[] getFieldDescriptions() {
        return fieldDescriptions;
    }

    public void setFieldDescriptions(String[] fieldDescriptions) {
        this.fieldDescriptions = fieldDescriptions;
    }

    public String[] getRecordDescriptions() {
        return recordDescriptions;
    }

    public void setRecordDescriptions(String[] recordDescriptions) {
        this.recordDescriptions = recordDescriptions;
    }

    public String getOverallDescription() {
        return overallDescription;
    }

    public void setOverallDescription(String overallDescription) {
        this.overallDescription = overallDescription;
    }
}
