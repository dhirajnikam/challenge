# Challenge148

Challenge148 is a Flutter application that allows users to manage device profiles with customizable settings such as name, color, text size, latitude, and longitude.

## Features

- Create new device profiles with custom settings
- Select a color for the device profile
- Adjust the text size for the device profile
- Validate latitude and longitude inputs
- Store device profiles persistently using SQLite database

## Getting Started

To get started with Challenge148, follow these steps:

1. Ensure that you have Flutter installed on your machine. For installation instructions, refer to the [Flutter documentation](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine using Git:

   ```
   git clone https://github.com/your-username/challenge148.git
   ```

3. Change into the project directory:

   ```
   cd challenge148
   ```

4. Run the following command to fetch the project dependencies:

   ```
   flutter pub get
   ```

5. Connect a device or start an emulator.

6. Run the application:

   ```
   flutter run
   ```

   The application should now be running on your device or emulator.

## Usage

Upon launching Challenge148, you will see a list of device profiles. Initially, the list will be empty. To create a new device profile, tap on the "Add" button.

### Creating a Device Profile

1. Enter a name for the device profile in the "Name" field.

2. Tap on the color container to select a color for the device profile. You can choose from the available colors to select a custom color.

3. Use the slider to adjust the text size for the device profile.

4. Enter the latitude and longitude values for the device profile. The latitude must be in the range of -90 to 90, and the longitude must be in the range of -180 to 180.

5. If the latitude or longitude input is invalid, an error message will be displayed below the respective input field.

6. Once you have entered all the required information, tap on the "Save" button. The device profile will be saved, and you will be taken back to the list of device profiles.

### Managing Device Profiles

- To view the details of a device profile, tap on the profile in the list. This will navigate you to the device settings screen, where you can see the theme color and font size for the selected device profile.

## Dependencies

The following dependencies are used in Challenge148:

- `flutter/material.dart`: The Material Design framework for Flutter.
- `get/get.dart`: A state management library for Flutter.
- `path/path.dart`: A library for manipulating file and directory paths.
- `path_provider/path_provider.dart`: A Flutter plugin for accessing commonly used locations on the file system.
- `sqlite3/sqlite3.dart`: A SQLite database driver for Dart.

For detailed information on the dependencies and their versions, refer to the `pubspec.yaml` file.
