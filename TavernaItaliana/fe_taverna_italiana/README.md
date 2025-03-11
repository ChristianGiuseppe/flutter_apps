# 📁 Project Structure

This Flutter project follows a clean architecture approach to ensure maintainability, scalability. Below you will find a clear explanation of each folder and its purpose.

## 📌 Structure Overview

```text
lib/
├── core/
│   ├── cache/
│   ├── https/
│   └── styles/
├── configuration/
├── data/
│   ├── data_source/
│   │   ├── local/
│   │   └── remote/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── repositories/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

## 📁 Folder Details

### 🔧 Core

- **cache:** Contains logic for local storage and caching mechanisms (e.g., SharedPreferences).
- **https:** Includes HTTP client configurations, network service wrappers, interceptors, and related utilities.
- **styles:** Defines global app colors, typography, themes, and reusable style constants.

### ⚙️ Configuration

- Stores app-wide configurations, environment variables, and settings like API endpoints, flavors, and build-time settings.

### 📦 Data

- **data_source:** Responsible for retrieving data from various sources:
  - **local:** Implements local data persistence (e.g., SharedPreferences, SQLite).
  - **remote:** Handles remote data fetching (e.g., APIs).
- **models:** Defines data models used for JSON parsing and data serialization/deserialization.
- **repositories:** Contains concrete implementations of domain repositories. Implements data fetching logic, caching, and communicates between data sources and domain.

### 📚 Domain

- **entities:** Defines plain Dart objects (entities) representing core business data without dependencies on external frameworks or libraries.
- **repositories:** Declares abstract interfaces (contracts) for fetching and storing data, ensuring separation between data and domain layers.

### 🎨 Presentation

- **pages:** Contains full screens or pages composed of widgets, which represent different views in your app.
- **providers:** Includes Riverpod providers, notifiers, and state management logic to handle UI states.
- **widgets:** Contains reusable and modular UI components and widgets used throughout the presentation layer.

---

Following this structure allows a clear separation of concerns, promotes reusability, and enhances testability across your Flutter application.
