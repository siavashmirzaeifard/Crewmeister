# Crewmeister Absence Manager

Crewmeister challenge app is a Flutter app that simulates an absence management system. It loads absence data from local JSON files and displays a list of absence events with employee details. The app supports filtering by type and date, pagination, and even includes a bonus feature to generate an iCal file for calendar imports.

## Features

- **Absence List:** View absence events including:
    - **Member Name:** The employee's name.
    - **Type:** The reason of absence (e.g., sickness, vacation).
    - **Period:** Duration of the absence (e.g., "2 days").
    - **Member Note:** Additional notes from the employee (if available).
    - **Status:** Indicates whether the absence is "Requested", "Confirmed", or "Rejected".
    - **Admitter Note:** Comments from the person managing the absence (if available).

- **Filtering:** Filter absences by type and by date.

- **Pagination:** Browse absences 10 items per page using Previous/Next controls.

- **UI States:**
    - **Loading:** A spinner is shown while data is loading.
    - **Error:** An error message is displayed if data fails to load.
    - **Empty:** A message is shown when no absences are found.

## Project Architecture

- **lib/core:** Utility classes (e.g., DataLoader, period calculator).
- **lib/data:** Data models, repositories, and API provider.
- **lib/logic:** BLoC implementations for state management.
- **lib/presentation:** UI screens and reusable widgets.

### Running the App

1. Clone the repository:
    ```bash
    git clone
    ```
2. Navigate to the project directory:
    ```bash
    cd <project_directory>
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

## Testing

The project includes both unit tests and widget tests.

To run tests:
```bash
flutter test
```
