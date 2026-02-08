<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    CSD430 Server-Side Development

    Module 3: Working with JSP Forms
    Author: Brittaney Perry-Morgan

    Description: Displays job application data submitted from the form.
    All Java code is within Scriptlets. All HTML tags are outside of
    Scriptlets. External CSS is used for styling.

    applicationResults.jsp - Application Results Display Page
--%>

<%-- =========================
     1. DATA RETRIEVAL AND PROCESSING
     ========================= --%>
<%
    // --- Retrieve form data
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zipCode = request.getParameter("zipCode");

    String position = request.getParameter("position");
    String experience = request.getParameter("experience");
    String education = request.getParameter("education");
    String availability = request.getParameter("availability");
    String salary = request.getParameter("salary");

    String references = request.getParameter("references");
    String emergencyContact = request.getParameter("emergencyContact");
    String comments = request.getParameter("comments");
    String newsletter = request.getParameter("newsletter");

    // --- Process Experience into Readable Text
    String experienceText;
    if ("0".equals(experience)) {
        experienceText = "0 (Fresh Graduate)";
    } else if ("10".equals(experience)) {
        experienceText = "10+ Years";
    } else {
        experienceText = experience + " Years";
    }

    // --- Process Education into Readable Text
    String educationText;
    if ("highSchool".equals(education)) {
        educationText = "High School Diploma or GED";
    } else if ("associate".equals(education)) {
        educationText = "Associate Degree";
    } else if ("bachelor".equals(education)) {
        educationText = "Bachelor's Degree";
    } else if ("master".equals(education)) {
        educationText = "Master's Degree";
    } else if ("doctorate".equals(education)) {
        educationText = "Doctorate or Professional Degree";
    } else {
        educationText = "Unknown";
    }

    // --- Process Salary into Readable Text
    String salaryText;
    if ("40000".equals(salary)) {
        salaryText = "$40,000 - $50,000";
    } else if ("50000".equals(salary)) {
        salaryText = "$50,000 - $60,000";
    } else if ("60000".equals(salary)) {
        salaryText = "$60,000 - $75,000";
    } else if ("75000".equals(salary)) {
        salaryText = "$75,000 - $90,000";
    } else if ("90000".equals(salary)) {
        salaryText = "$90,000+";
    } else {
        salaryText = "Unknown";
    }

    // --- Check Newsletter Subscription
    String newsletterText = "No";
    if ("yes".equals(newsletter)) {
        newsletterText = "Yes";
    }

    // --- Field Descriptions
    String[] fieldDescriptions = {
        "Field 1: Category-Specific Label (e.g., Personal Info, Employment, Additional)",
        "Field 2: Field Name (e.g., First Name, Email, Position)",
        "Field 3: User's Input Value"
    };

    // --- Record Descriptions
    String[] recordDescriptions = {
        "Each record represents a unique data field from the job application form.",
        "All data is submitted by the applicant and displayed as entered."
    };

    // --- Overall Data Description
    String overallDescription = "This table presents the job application data submitted by the applicant. The information includes personal details, employment requirements, and additional comments provided during the application process.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Module 3 Assignment: Job Application Results</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 3 Assignment: Working with JSP Forms</h1>
        <h2>Job Application Results</h2>
        <p class="description"><%= overallDescription %></p>
    </div>

    <div class="container">
        <h3>Field Descriptions</h3>
        <ul class="field-descriptions">
            <% for (String desc : fieldDescriptions) { %>
                <li><%= desc %></li>
            <% } %>
        </ul>

        <h3>Personal Information</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>First Name</td>
                    <td><%= firstName != null ? firstName : "N/A" %></td>
                    <td>Applicant's given name</td>
                </tr>
                <tr>
                    <td>Last Name</td>
                    <td><%= lastName != null ? lastName : "N/A" %></td>
                    <td>Applicant's family name</td>
                </tr>
                <tr>
                    <td>Email Address</td>
                    <td><%= email != null ? email : "N/A" %></td>
                    <td>Primary contact email</td>
                </tr>
                <tr>
                    <td>Phone Number</td>
                    <td><%= phone != null ? phone : "N/A" %></td>
                    <td>Primary contact phone</td>
                </tr>
                <tr>
                    <td>Street Address</td>
                    <td><%= address != null ? address : "N/A" %></td>
                    <td>Current residence address</td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><%= city != null ? city : "N/A" %></td>
                    <td>City of residence</td>
                </tr>
                <tr>
                    <td>State</td>
                    <td><%= state != null ? state : "N/A" %></td>
                    <td>State of residence</td>
                </tr>
                <tr>
                    <td>ZIP Code</td>
                    <td><%= zipCode != null ? zipCode : "N/A" %></td>
                    <td>Postal code</td>
                </tr>
            </tbody>
        </table>

        <h3>Employment Details</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Position Applied For</td>
                    <td><%= position != null ? position : "N/A" %></td>
                    <td>Job title sought</td>
                </tr>
                <tr>
                    <td>Years of Experience</td>
                    <td><%= experienceText %></td>
                    <td>Professional experience level</td>
                </tr>
                <tr>
                    <td>Highest Education Level</td>
                    <td><%= educationText %></td>
                    <td>Maximum educational attainment</td>
                </tr>
                <tr>
                    <td>Available Start Date</td>
                    <td><%= availability != null ? availability : "N/A" %></td>
                    <td>When applicant can begin</td>
                </tr>
                <tr>
                    <td>Expected Salary</td>
                    <td><%= salaryText %></td>
                    <td>Desired compensation range</td>
                </tr>
            </tbody>
        </table>

        <h3>Additional Information</h3>
        <table>
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Can Provide References</td>
                    <td><%= references != null ? references : "N/A" %></td>
                    <td>Reference availability</td>
                </tr>
                <tr>
                    <td>Emergency Contact</td>
                    <td><%= emergencyContact != null ? emergencyContact : "N/A" %></td>
                    <td>Emergency contact name</td>
                </tr>
                <tr>
                    <td>Additional Comments</td>
                    <td><%= comments != null && comments.length() > 0 ? comments : "No comments provided" %></td>
                    <td>Applicant's notes</td>
                </tr>
                <tr>
                    <td>Subscribe to Newsletter</td>
                    <td><%= newsletterText %></td>
                    <td>Marketing preference</td>
                </tr>
            </tbody>
        </table>

        <div class="form-actions">
            <a href="index.jsp" class="btn-submit">Submit Another Application</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
