# Module 09: DELETE Operation

## Student

Brittaney Perry-Morgan

## Course

CSD430 Server-Side Development

## Assignment

CRUD Project Part 4: DELETE Operation

## Description

This module implements the DELETE operation for the movie database CRUD application. Users can permanently remove movie records from the database through a confirmation workflow.

## Files

| File | Description |
| ------ | ------------- |
| `MovieBean.java` | JavaBean with CRUD methods including `deleteMovie()` and `movieExists()` |
| `index.jsp` | Module landing page with links to all CRUD operations |
| `movie_delete.jsp` | Movie selection dropdown for deletion |
| `movie_confirm_delete.jsp` | Confirmation page showing movie details |
| `movie_process_delete.jsp` | Processing page that executes the deletion |

## Features Implemented

1. **Dropdown Selection** - Users select a movie ID from a populated dropdown menu
2. **Confirmation Page** - Displays full movie details before deletion
3. **Warning Message** - Clear warning that deletion is permanent
4. **JavaScript Confirmation** - Double confirmation with browser dialog
5. **Database Integrity Check** - `movieExists()` method verifies record exists
6. **Success/Error Feedback** - User receives feedback on operation result

## DELETE Methods Added to MovieBean.java

### `deleteMovie(int movieId)`

Deletes a movie record from the database.

- **Parameter:** movieId - The ID of the movie to delete
- **Returns:** true if deletion was successful, false otherwise

### `movieExists(int movieId)`

Checks if a movie exists in the database before attempting deletion.

- **Parameter:** movieId - The movie ID to check
- **Returns:** true if movie exists, false otherwise

## CRUD Summary

| Module | Operation | Status |
| -------- | ----------- | -------- |
| 5&6 | Database Setup + READ | ✅ Complete |
| 7 | CREATE | ✅ Complete |
| 8 | UPDATE | ✅ Complete |
| 9 | DELETE | ✅ Complete |

## Database Table

Table: `brittany_movies_data`

| Column | Type |
| -------- | ------ |
| movie_id | INT (Auto Increment) |
| title | VARCHAR |
| genre | VARCHAR |
| release_year | INT |
| rating | VARCHAR |
| director | VARCHAR |

## Testing Instructions

1. Navigate to `movie_delete.jsp`
2. Select a movie ID from the dropdown
3. Click "Select Movie to Delete"
4. Review the movie details on the confirmation page
5. Click "Yes, Delete Movie" (JavaScript confirmation will appear)
6. Confirm the deletion in the browser dialog
7. Verify success message appears
8. Check that the movie no longer appears in the READ operation

## Notes

- Deletion is permanent and cannot be undone
- The confirmation workflow prevents accidental deletions
- Error handling includes database connection failures and missing records
