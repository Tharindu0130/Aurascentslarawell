# Perfume Store Mobile App

A Flutter mobile application for browsing and purchasing perfumes online, connecting to a Laravel backend.

## About

This is a mobile e-commerce app built with Flutter for the frontend and Laravel for the backend API. Users can browse perfumes, add them to cart, manage wishlist, and place orders.

## Features

- User login and registration
- Browse perfume products from backend database
- Search and filter products
- Shopping cart functionality
- Wishlist management
- Order placement and history
- Profile management with image upload
- Real-time connectivity monitoring
- Location services integration
- Camera access for profile pictures

## Tech Stack

**Frontend:**
- Flutter / Dart
- Provider for state management
- HTTP for API calls
- SharedPreferences for local storage

**Backend:**
- Laravel (connected via REST API)
- MySQL database

## Setup

### Prerequisites

- Flutter SDK installed
- Android Studio or VS Code
- Android/iOS emulator or real device

### Installation

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Backend Configuration

Update the API base URL in `lib/services/api_service.dart`:

```dart
static const String baseUrl = 'http://YOUR_BACKEND_URL/api';
```

## Project Structure

```
lib/
├── main.dart
├── models/          # Data models (User, Perfume, CartItem, etc.)
├── providers/       # State management providers
├── services/        # API and business logic
├── screens/         # UI screens
└── widgets/         # Reusable components
```

## Running the App

1. Make sure your backend server is running
2. Update the base URL in api_service.dart
3. Run `flutter run`
4. Login or register to start using the app

## Notes

- The app requires internet connection to fetch products from the backend
- Camera and location permissions are needed for some features
- Products are loaded from the backend database, not local JSON

---

Developed as part of MAD (Mobile Application Development) coursework.
