# Perfume Store Flutter App

A complete, production-ready Flutter application for a perfume store, built with **100% Flutter/Dart code** - no custom native code required.

## 🎯 Pure Flutter Implementation

This project is designed to be completely platform-agnostic using only Flutter/Dart:
- ✅ **No custom Kotlin code** in Android
- ✅ **No custom Swift code** in iOS  
- ✅ **Pure Flutter dependencies** only
- ✅ **Cross-platform compatibility** out of the box

## Features

### Core Functionality
- **User Authentication**: Login and registration with form validation
- **Product Catalog**: Browse perfumes with search and category filtering
- **Shopping Cart**: Add, remove, and manage cart items with quantity controls
- **User Profile**: View and edit profile information
- **Responsive Design**: Optimized for mobile devices

### Technical Features
- **State Management**: Provider pattern for app-wide state management
- **HTTP Requests**: Mock API integration for data fetching
- **Local Storage**: SharedPreferences for user session persistence
- **Location Services**: Geolocator integration for location-based features
- **Camera Integration**: Camera access for profile picture updates
- **Network Monitoring**: Connectivity status tracking

## Dependencies

All dependencies are pure Flutter packages with no native code requirements:

```yaml
dependencies:
  provider: ^6.1.1          # State management
  shared_preferences: ^2.2.2 # Local storage
  geolocator: ^10.1.0       # Location services
  camera: ^0.10.5+5         # Camera functionality
  connectivity_plus: ^5.0.2 # Network connectivity
  http: ^1.1.0              # HTTP requests
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user.dart
│   ├── perfume.dart
│   └── cart_item.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   ├── perfume_provider.dart
│   ├── location_provider.dart
│   └── connectivity_provider.dart
├── services/                 # API services
│   ├── auth_service.dart
│   └── perfume_service.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   ├── home/
│   ├── perfume/
│   ├── cart/
│   └── profile/
├── widgets/                  # Reusable widgets
└── utils/
    └── theme.dart           # App theme configuration
```

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### 2. Installation
```bash
# Clone the repository
git clone <repository-url>
cd perfume_store

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### 3. Platform Configuration

The app automatically handles all platform-specific configurations through Flutter plugins. No manual native code setup required!

#### Permissions (Automatically handled by Flutter plugins)
- **Internet**: For HTTP requests
- **Location**: For location services
- **Camera**: For profile pictures
- **Network State**: For connectivity monitoring

## Demo Credentials

### Login Credentials
- **Email**: `user@perfumestore.com`
- **Password**: `password123`

### Alternative Demo Users
- **Email**: `alice@demo.com` or `bob@demo.com`
- **Password**: `demo123`

## Key Features Demonstration

### 1. Authentication System
- Form validation with error handling
- Persistent login sessions using SharedPreferences
- Demo user accounts for testing

### 2. Product Management
- Mock perfume data with realistic information
- Search functionality across name, brand, and description
- Category filtering (Men, Women, Unisex, etc.)
- Product ratings and reviews display

### 3. Shopping Cart
- Add/remove items with visual feedback
- Quantity management with increment/decrement controls
- Real-time total calculation
- Persistent cart state during app session

### 4. Location Services
- GPS location access with permission handling
- Distance calculation to store locations
- Location status display in profile

### 5. Camera Integration
- Camera availability detection
- Profile picture update functionality
- Permission handling for camera access

### 6. Network Monitoring
- Real-time connectivity status
- Connection type detection (WiFi, Mobile, etc.)
- Offline state handling

## Architecture Patterns

### State Management
- **Provider Pattern**: Used for app-wide state management
- **Separation of Concerns**: Business logic separated from UI
- **Reactive Updates**: UI automatically updates when state changes

### Data Layer
- **Repository Pattern**: Services handle data fetching and caching
- **Model Classes**: Structured data with JSON serialization
- **Mock Data**: Realistic sample data for demonstration

### UI/UX Design
- **Material Design**: Following Flutter's material design principles
- **Custom Theme**: Consistent color scheme and typography
- **Responsive Layout**: Adapts to different screen sizes
- **Loading States**: User feedback during async operations

## Testing

The app includes comprehensive error handling and user feedback:
- Form validation with clear error messages
- Network error handling with retry options
- Loading states for async operations
- Success/failure notifications via SnackBars

## Production Considerations

For production deployment, consider:
1. **Real API Integration**: Replace mock services with actual backend APIs
2. **Authentication Security**: Implement proper JWT token handling
3. **Image Optimization**: Add image caching and compression
4. **Performance**: Implement lazy loading for large product lists
5. **Analytics**: Add user behavior tracking
6. **Push Notifications**: For order updates and promotions
7. **Payment Integration**: Add payment gateway integration
8. **Testing**: Comprehensive unit and integration tests

## Why Pure Flutter?

This implementation demonstrates that modern Flutter apps can be built entirely without custom native code:

- **Faster Development**: No need to write platform-specific code
- **Easier Maintenance**: Single codebase for all platforms
- **Better Testing**: Consistent behavior across platforms
- **Reduced Complexity**: No native build configurations
- **Future-Proof**: Leverages Flutter's growing ecosystem

## License

This project is created for educational purposes demonstrating pure Flutter development.

## Contact

For questions or support regarding this project, please contact the development team.