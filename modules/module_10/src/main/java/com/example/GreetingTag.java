package com.example;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Custom tag that displays a personalized greeting with the current time.
 * Demonstrates: attribute handling, body content, and JspContext interaction.
 * 
 * Usage in JSP:
 * <csd:greeting name="Brittaney" />
 * <csd:greeting name="Brittaney" timeFormat="short" />
 */
public class GreetingTag extends SimpleTagSupport {
    
    private String name;
    private String timeFormat = "full";
    
    // Setter for 'name' attribute (required by JSP container)
    public void setName(String name) {
        this.name = name;
    }
    
    // Setter for 'timeFormat' attribute
    public void setTimeFormat(String timeFormat) {
        this.timeFormat = timeFormat;
    }
    
    @Override
    public void doTag() throws JspException, IOException {
        LocalDateTime now = LocalDateTime.now();
        String greeting;
        int hour = now.getHour();
        
        // Determine greeting based on time of day
        if (hour < 12) {
            greeting = "Good morning";
        } else if (hour < 17) {
            greeting = "Good afternoon";
        } else {
            greeting = "Good evening";
        }
        
        // Format the time based on user preference
        String formattedTime;
        switch (timeFormat.toLowerCase()) {
            case "short":
                formattedTime = now.format(DateTimeFormatter.ofPattern("h:mm a"));
                break;
            case "medium":
                formattedTime = now.format(DateTimeFormatter.ofPattern("MMM d, h:mm a"));
                break;
            case "full":
            default:
                formattedTime = now.format(DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' h:mm a"));
                break;
        }
        
        // Build the output HTML
        StringBuilder output = new StringBuilder();
        output.append("<div class=\"greeting-box\">");
        output.append("<h3>").append(greeting);
        if (name != null && !name.isEmpty()) {
            output.append(", ").append(escapeHtml(name));
        }
        output.append("!</h3>");
        output.append("<p>Current time: ").append(formattedTime).append("</p>");
        output.append("</div>");
        
        // Write output to the JSP page
        getJspContext().getOut().println(output.toString());
    }
    
    // Helper method to escape HTML characters
    private String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}