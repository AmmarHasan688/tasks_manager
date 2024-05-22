

## Todo Manager App

A Flutter-based todo management app that allows users to create, manage, and view their tasks. This app prioritizes clean architecture and offline functionality.

## Description

This app helps users stay organized by providing a platform to create, view, and manage their tasks. It offers a user-friendly interface and leverages Flutter for a smooth and performant experience on Android devices.

## Getting Started

### Prerequisites: 

-   Android Studio (with Flutter plugin installed)
-   Flutter SDK

### Installation

1.  Clone this repository:
    
  
    
    ```
    git clone https://github.com/AmmarHasan688/tasks_manager.git
    ```
    
2.  Open the project in Android Studio.
    

### Running the app
1. Open the terminal and run
    ```
    flutter pub get
    ```
3.  Ensure your Android device is connected or an emulator is running.
4.  Click the "Run" button in Android Studio.

### Tech Stack

-   **Flutter:** Cross-platform mobile app development framework
-   **Provider:** State management solution for Flutter
-   **DIO:** Efficient HTTP client library for Flutter
-   **Clean Architecture:** Design pattern for separating concerns

### Features

-   Create, view, and manage tasks
-   Offline functionality: Cached todos persist even without internet connection
-   Clean architecture for better maintainability and testability (Domain, Presentation, Data layers)

### Challenges Faced

The provided API lacked an endpoint for creating new users. This might necessitate implementing user management logic within the app itself (if allowed by API usage guidelines) or potentially using a different API with the desired functionality.

### Additional Notes

-   Feel free to explore the project codebase to understand the implementation details.
-   The project demonstrates the application of clean architecture principles in a Flutter context.


