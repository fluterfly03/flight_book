# Flight Booking Application

A modern Flutter-based flight booking application that allows users to search, browse, and book flights with an intuitive user interface and seamless API integration.

## Table of Contents

- [Steps to Run the Project](#steps-to-run-the-project)
- [Dependencies Used](#dependencies-used)
- [Approach and Thought Process](#approach-and-thought-process)
- [Time Taken](#time-taken)

---

## Steps to Run the Project

### Prerequisites

Ensure you have the following installed on your system:
- **Flutter SDK** (version 3.12.0 or higher)
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **Xcode** (for emulator/device testing)
- **Git** (for version control)

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd flight_book
   ```

2. **Get Flutter Dependencies**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Configure Environment**
   - The application uses the API base URL: `https://flight.wigian.in`
   - API initialization is handled in `lib/main.dart` with automatic setup

4. **Run the Application**
   
   **For Android Emulator/Device:**
   ```bash
   flutter run
   ```

   **For iOS Simulator/Device:**
   ```bash
   flutter run -d macos
   ```

   **For Web (if enabled):**
   ```bash
   flutter run -d web
   ```

5. **Build for Release**
   
   **Android APK:**
   ```bash
   flutter build apk --release
   ```

   **Android App Bundle:**
   ```bash
   flutter build appbundle --release
   ```

   **iOS:**
   ```bash
   flutter build ios --release
   ```

---

## Dependencies Used

### Core Flutter Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Flutter framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### State Management & Navigation

| Package | Version | Purpose |
|---------|---------|---------|
| `get` | ^4.7.2 | Route management, state management, and dependency injection using GetX pattern |

### UI & Responsive Design

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_screenutil` | ^5.9.3 | Responsive UI scaling for different screen sizes |
| `google_fonts` | ^6.2.1 | Custom Google Fonts for typography |
| `dotted_border` | ^2.1.0 | Decorative dotted borders for UI elements |

### Networking & HTTP

| Package | Version | Purpose |
|---------|---------|---------|
| `http` | ^1.0.0 | HTTP client for basic API requests |
| `dio` | ^5.0.4 | Advanced HTTP client with interceptors, better error handling, and request/response transformation |

### Device & Platform Features

| Package | Version | Purpose |
|---------|---------|---------|
| `connectivity_plus` | ^4.0.2 | Check internet connectivity status |
| `shared_preferences` | ^2.1.1 | Local persistent storage for user preferences and data caching |
| `intl` | ^0.20.2 | Internationalization and localization support |

### Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Flutter testing framework |
| `flutter_lints` | ^6.0.0 | Lint rules for code quality |

---

## Approach and Thought Process

### Architecture Overview

The application follows a **clean architecture pattern** with clear separation of concerns:

```
lib/
├── main.dart                          # App entry point with API initialization
├── modules/
│   └── flight/
│       ├── bindings/                 # Dependency injection setup
│       ├── controllers/              # Business logic (FlightController)
│       ├── models/                   # Data models
│       │   ├── flight_model.dart     # Flight data structure
│       │   ├── flight_details_model.dart  # Detailed flight info with passengers
│       │   ├── aircraft_type_model.dart   # Aircraft information
│       │   ├── airline_model.dart    # Airline data
│       │   └── airport_model.dart    # Airport data
│       ├── services/                 # API communication
│       │   └── api_client.dart       # Centralized API client with Dio
│       └── views/
│           ├── screens/              # Full-screen pages
│           │   ├── plan_trip_screen.dart       # Trip planning interface
│           │   ├── flight_listing_screen.dart  # Flight search results
│           │   └── flight_details_screen.dart  # Selected flight details
│           └── widgets/              # Reusable UI components
├── routes/
│   └── app_pages.dart               # Route definitions
└── assets/
    └── images/                       # App assets
```

### Key Implementation Details

#### 1. **State Management with GetX**
   - Used GetX for reactive state management
   - Controllers manage flight data, selections, and API calls
   - Observable variables automatically update UI when data changes
   - Dependency injection through AppBinding for clean initialization

#### 2. **API Integration**
   - **Centralized API Client**: `ApiClient` class uses Dio for all network requests
   - **Initialization**: API client is initialized in `main()` before app launch
   - **Base Configuration**: Base URL and timeout configured globally
   - **Features**:
     - Request/response logging
     - Automatic error handling
     - Request timeouts (60 seconds)
     - Interceptor support for future enhancements (auth headers, token refresh)

#### 3. **Responsive Design**
   - **ScreenUtil**: Scales UI elements based on device screen size
   - Design size set to 375x812 (standard mobile dimensions)
   - All dimensions are responsive and adapt to different devices

#### 4. **Data Models**
   - Strongly-typed models for type safety
   - Models include JSON serialization/deserialization
   - Nested models for complex data structures (Flight → FlightDetails → Passengers)

#### 5. **Flight Details Screen Features**
   - Displays comprehensive flight information
   - Shows airline logo with fallback to initials
   - Displays passenger information with profile pictures
   - Terminal, gate, and class information
   - Barcode rendering for flight pass
   - Responsive layout with smooth scrolling

#### 6. **User Experience Considerations**
   - Loading states while fetching data
   - Null safety checks to prevent crashes
   - Error handling for network failures
   - Custom UI components for consistent design
   - Smooth animations and transitions

### APIs Implemented

The application integrates with the following APIs:

#### 1. **Flight Details API**
   - **Endpoint**: `POST /flight_api.php/flight`
   - **Request**: Flight ID
   - **Response**: Complete flight details with passenger list and booking information
   - **Implementation**: Triggered on flight selection from listing screen

#### 2. **Aircraft Types API** (Ready for Implementation)
   - **Endpoint**: `GET /flight_api.php/aircraft-types`
   - **Features**: Pagination support, search functionality, infinite scroll
   - **Parameters**: Search term, limit, page number
   - **Response**: List of aircraft types with pagination metadata

### Code Quality & Best Practices

- **Type Safety**: Full null safety and type checking throughout
- **Error Handling**: Comprehensive error handling for API failures
- **Code Organization**: Modular structure for maintainability
- **Naming Conventions**: Clear, descriptive names for classes and functions
- **Documentation**: Comments for complex logic
- **Performance**: Efficient rebuilds using Obx() for reactive updates

---

## Time Taken

### Development Breakdown

| Phase | Time Estimate |
|-------|---|
| Project Setup & Architecture | 30 minutes |
| Dependency Configuration | 20 minutes |
| API Client Implementation | 45 minutes |
| Data Models Creation | 40 minutes |
| Flight Controller Development | 50 minutes |
| UI Screens Implementation | 90 minutes |
| Flight Details Screen Design | 60 minutes |
| Testing & Debugging | 45 minutes |
| Documentation & README | 30 minutes |
| **Total** | **~5.5 hours** |

### Estimated Time for Additional Features

- **Aircraft Types Dropdown with Infinite Scroll**: ~45 minutes
- **Flight Search Functionality**: ~50 minutes
- **User Authentication**: ~60 minutes
- **Payment Integration**: ~90 minutes
- **Booking Confirmation Screen**: ~40 minutes

---

## Features

✅ Flight search and filtering
✅ Detailed flight information display
✅ Passenger information viewing
✅ Flight booking reference tracking
✅ Responsive UI for all devices
✅ Real-time API integration
✅ Clean architecture pattern
✅ State management with GetX
✅ Smooth navigation between screens
✅ Network error handling

## Future Enhancements

- [ ] User authentication and login
- [ ] Payment gateway integration
- [ ] Booking history
- [ ] In-app notifications
- [ ] Flight comparison feature
- [ ] Advanced search filters
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Offline functionality with caching
- [ ] Push notifications for flight updates

## Troubleshooting

### Common Issues

**Issue**: Flutter packages not found
```bash
Solution: Run `flutter clean` and `flutter pub get`
```

**Issue**: Android build fails
```bash
Solution: Update Android Studio and gradle versions in android/build.gradle.kts
```

**Issue**: API connection timeout
```bash
Solution: Check internet connection and verify API base URL in main.dart
```

## Support

For issues or feature requests, please contact the development team or open an issue in the repository.

---

**Version**: 1.0.0  
**Last Updated**: June 22, 2026  
**Flutter SDK**: ^3.12.0
