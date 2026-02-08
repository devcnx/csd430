<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    CSD430 Server-Side Development

    Module 3: Working with JSP Forms
    Author: Brittaney Perry-Morgan

    Description: Job Application Form - Collects user information
    and displays submitted data in a table format using JSP scriptlets.

    index.jsp - Job Application Form Page
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Module 3 Assignment: Job Application Form</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container top-title">
        <h1>Module 3 Assignment: Working with JSP Forms</h1>
        <h2>Job Application Form</h2>
        <p class="description">Please complete the form below to apply for employment with us.</p>
    </div>

    <div class="container">
        <form action="applicationResults.jsp" method="post">
            <h3>Personal Information</h3>
            <table class="form-table">
                <tr>
                    <td><label for="firstName">First Name:</label></td>
                    <td><input type="text" id="firstName" name="firstName" required></td>
                </tr>
                <tr>
                    <td><label for="lastName">Last Name:</label></td>
                    <td><input type="text" id="lastName" name="lastName" required></td>
                </tr>
                <tr>
                    <td><label for="email">Email Address:</label></td>
                    <td><input type="email" id="email" name="email" required></td>
                </tr>
                <tr>
                    <td><label for="phone">Phone Number:</label></td>
                    <td><input type="tel" id="phone" name="phone" required></td>
                </tr>
                <tr>
                    <td><label for="address">Street Address:</label></td>
                    <td><input type="text" id="address" name="address" required></td>
                </tr>
                <tr>
                    <td><label for="city">City:</label></td>
                    <td><input type="text" id="city" name="city" required></td>
                </tr>
                <tr>
                    <td><label for="state">State:</label></td>
                    <td>
                        <select id="state" name="state" required>
                            <option value="">Select State</option>
                            <option value="AL">Alabama</option>
                            <option value="AK">Alaska</option>
                            <option value="AZ">Arizona</option>
                            <option value="AR">Arkansas</option>
                            <option value="CA">California</option>
                            <option value="CO">Colorado</option>
                            <option value="CT">Connecticut</option>
                            <option value="DE">Delaware</option>
                            <option value="FL">Florida</option>
                            <option value="GA">Georgia</option>
                            <option value="HI">Hawaii</option>
                            <option value="ID">Idaho</option>
                            <option value="IL">Illinois</option>
                            <option value="IN">Indiana</option>
                            <option value="IA">Iowa</option>
                            <option value="KS">Kansas</option>
                            <option value="KY">Kentucky</option>
                            <option value="LA">Louisiana</option>
                            <option value="ME">Maine</option>
                            <option value="MD">Maryland</option>
                            <option value="MA">Massachusetts</option>
                            <option value="MI">Michigan</option>
                            <option value="MN">Minnesota</option>
                            <option value="MS">Mississippi</option>
                            <option value="MO">Missouri</option>
                            <option value="MT">Montana</option>
                            <option value="NE">Nebraska</option>
                            <option value="NV">Nevada</option>
                            <option value="NH">New Hampshire</option>
                            <option value="NJ">New Jersey</option>
                            <option value="NM">New Mexico</option>
                            <option value="NY">New York</option>
                            <option value="NC">North Carolina</option>
                            <option value="ND">North Dakota</option>
                            <option value="OH">Ohio</option>
                            <option value="OK">Oklahoma</option>
                            <option value="OR">Oregon</option>
                            <option value="PA">Pennsylvania</option>
                            <option value="RI">Rhode Island</option>
                            <option value="SC">South Carolina</option>
                            <option value="SD">South Dakota</option>
                            <option value="TN">Tennessee</option>
                            <option value="TX">Texas</option>
                            <option value="UT">Utah</option>
                            <option value="VT">Vermont</option>
                            <option value="VA">Virginia</option>
                            <option value="WA">Washington</option>
                            <option value="WV">West Virginia</option>
                            <option value="WI">Wisconsin</option>
                            <option value="WY">Wyoming</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="zipCode">ZIP Code:</label></td>
                    <td><input type="text" id="zipCode" name="zipCode" required></td>
                </tr>
            </table>

            <h3>Employment Details</h3>
            <table class="form-table">
                <tr>
                    <td><label for="position">Position Applied For:</label></td>
                    <td><input type="text" id="position" name="position" required></td>
                </tr>
                <tr>
                    <td><label for="experience">Years of Experience:</label></td>
                    <td>
                        <select id="experience" name="experience" required>
                            <option value="">Select Years</option>
                            <option value="0">0 (Fresh Graduate)</option>
                            <option value="1">1 Year</option>
                            <option value="2">2 Years</option>
                            <option value="3">3 Years</option>
                            <option value="4">4 Years</option>
                            <option value="5">5 Years</option>
                            <option value="6">6 Years</option>
                            <option value="7">7 Years</option>
                            <option value="8">8 Years</option>
                            <option value="9">9 Years</option>
                            <option value="10">10+ Years</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="education">Highest Education Level:</label></td>
                    <td>
                        <select id="education" name="education" required>
                            <option value="">Select Education Level</option>
                            <option value="highSchool">High School Diploma or GED</option>
                            <option value="associate">Associate Degree</option>
                            <option value="bachelor">Bachelor's Degree</option>
                            <option value="master">Master's Degree</option>
                            <option value="doctorate">Doctorate or Professional Degree</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="availability">Available Start Date:</label></td>
                    <td><input type="date" id="availability" name="availability" required></td>
                </tr>
                <tr>
                    <td><label for="salary">Expected Salary:</label></td>
                    <td>
                        <select id="salary" name="salary" required>
                            <option value="">Select Salary Range</option>
                            <option value="40000">$40,000 - $50,000</option>
                            <option value="50000">$50,000 - $60,000</option>
                            <option value="60000">$60,000 - $75,000</option>
                            <option value="75000">$75,000 - $90,000</option>
                            <option value="90000">$90,000+</option>
                        </select>
                    </td>
                </tr>
            </table>

            <h3>Additional Information</h3>
            <table class="form-table">
                <tr>
                    <td><label for="references">Can Provide References:</label></td>
                    <td>
                        <select id="references" name="references" required>
                            <option value="yes">Yes</option>
                            <option value="no">No</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="emergencyContact">Emergency Contact Name:</label></td>
                    <td><input type="text" id="emergencyContact" name="emergencyContact" required></td>
                </tr>
                <tr>
                    <td><label for="comments">Additional Comments:</label></td>
                    <td><textarea id="comments" name="comments" rows="4" cols="50" placeholder="Any additional information you'd like to share..."></textarea></td>
                </tr>
                <tr>
                    <td><label for="newsletter">Subscribe to Newsletter:</label></td>
                    <td>
                        <input type="checkbox" id="newsletter" name="newsletter" value="yes">
                        <label for="newsletter" style="display: inline;">Yes, I want to receive updates</label>
                    </td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">Submit Application</button>
                <button type="reset" class="btn-reset">Reset Form</button>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Brittaney Perry-Morgan | CSD430 Server-Side Development</p>
    </footer>
</body>
</html>
