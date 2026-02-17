# Changelog

All notable changes to the BuyBye Mobile App will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- **BREAKING**: Updated Dart SDK minimum requirement from 3.0.0 to 3.6.0
- **BREAKING**: Added Flutter SDK minimum requirement of 3.27.0
- Updated flutter_riverpod from 2.4.9 to 3.2.0 (major version update)
- Updated riverpod_annotation from 2.3.3 to 4.0.0 (major version update, fixes compatibility with flutter_riverpod 3.2.x)
- Updated riverpod_generator from 2.3.9 to 4.0.0 (major version update, matches riverpod_annotation 4.0.0)
- Updated riverpod_lint from 2.3.7 to 3.1.0 (updated to latest compatible version)
- Updated build_runner from 2.4.8 to 2.7.1
- Updated google_sign_in from 6.2.1 to 7.2.0 (major version update)
- Updated go_router from 13.0.0 to 14.6.2 (major version update)
- Updated flutter_svg from 2.0.9 to 2.0.10
- Updated url_launcher from 6.2.4 to 6.2.5
- Updated path_provider from 2.1.2 to 2.1.3

### Fixed
- Resolved CocoaPods dependency conflicts between Firebase plugins and Google Sign-In
- Fixed GoogleUtilities/Environment version conflicts (v7.x vs v8.x incompatibility)
- Added explicit Podfile constraint to force GoogleUtilities/Environment ~> 8.0
- Fixed AppAuth version conflicts
- Fixed Riverpod package version conflict (riverpod_annotation 3.0.3 incompatible with flutter_riverpod 3.2.0)
- Fixed riverpod_generator version conflict (3.0.3 incompatible with riverpod_annotation 4.0.0)

### Previous Updates (Earlier in Branch)
- Updated firebase_core from 2.24.2 to 4.4.0 (major version update)
- Updated firebase_auth from 4.15.3 to 6.1.1 (major version update)
- Updated firebase_storage from 11.5.6 to 12.1.0 (major version update)
- Updated cloud_firestore from 4.13.6 to 6.1.2 (major version update)
- Updated firebase_messaging from 14.7.9 to 16.1.1 (major version update)
- Increased iOS minimum deployment target from 12.0 to 13.0

### Added
- Created FIREBASE_MIGRATION.md with migration guide and breaking changes documentation

## [1.0.0] - 2026-02-07

### Added

#### Core Features
- Complete Flutter app structure with feature-first architecture
- Material Design 3 theming with Light/Dark mode support
- Blue (#1976D2) and Red (#E53935) color scheme
- Bottom navigation with 5 main sections

#### Authentication
- Email/Password authentication via Firebase
- Google Sign-In integration
- User registration with profile creation
- Splash screen with app logo
- Auto-redirect based on auth state

#### Shopping Features
- Product browsing with grid layout
- Search bar for finding products
- Product details screen with image gallery
- Add to cart functionality
- Shopping cart screen
- Checkout screen (placeholder)

#### B-coin Wallet
- Wallet dashboard with B-coin balance display
- Transaction history view
- Real-time balance updates via Firestore streams
- Earn-only system (no external deposits)

#### Selling Feature
- One-click selling interface
- Product photo upload capability
- Product name and description fields
- Optional price suggestion
- Selling history screen

#### User Profile
- Profile screen with user information
- Theme toggle (Light/Dark mode)
- Navigation to orders, selling history, addresses
- Logout functionality
- Edit profile screen (placeholder)

#### Orders
- Orders list screen
- Order details screen (placeholder)
- Order tracking capability (placeholder)

#### Firebase Integration
- Firebase Authentication setup
- Cloud Firestore integration
- Cloud Storage integration
- Firebase configuration placeholder files
- Security rules examples

#### State Management
- Riverpod for state management
- Auth state provider
- Current user data provider
- Theme mode provider
- Navigation state management

#### UI Components
- Custom button widget
- Custom text field widget
- Loading indicator widget
- Consistent Material Design styling
- Responsive layouts

#### Utilities
- Email validator
- Password validator
- Form field validators
- Date/time formatters
- Currency formatters
- B-coin formatters

#### Models
- User model with Firestore integration
- Product model
- Order model with order items
- Address model

#### Services
- Firebase Auth Service
- Firestore Service with CRUD operations
- Storage Service for file uploads

#### Configuration
- App colors constants
- App strings constants
- App assets constants
- GoRouter navigation configuration
- Theme configuration (Light/Dark)

#### Documentation
- Comprehensive README with setup instructions
- Firebase setup guide (FIREBASE_SETUP.md)
- Architecture documentation (ARCHITECTURE.md)
- Contributing guidelines (CONTRIBUTING.md)
- Quick start guide (QUICKSTART.md)
- Code comments and examples

#### Testing
- Unit test examples (validators)
- Widget test examples (custom button)
- Integration test structure and README
- Test directory structure

#### Build Configuration
- Android build.gradle configuration
- Android settings.gradle
- Android gradle.properties
- Android manifest with permissions
- iOS Info.plist with permissions
- Firebase config examples for Android/iOS
- Linting rules (analysis_options.yaml)
- .gitignore for Flutter projects

### Technical Details

#### Dependencies
- flutter_riverpod: ^2.4.9 (State management)
- firebase_core: ^2.24.2 (Firebase SDK)
- firebase_auth: ^4.15.3 (Authentication)
- cloud_firestore: ^4.13.6 (Database)
- firebase_storage: ^11.5.6 (File storage)
- google_sign_in: ^6.2.1 (Google authentication)
- go_router: ^13.0.0 (Navigation)
- cached_network_image: ^3.3.1 (Image caching)
- intl: ^0.19.0 (Internationalization)
- image_picker: ^1.0.7 (Camera/gallery access)
- shared_preferences: ^2.2.2 (Local storage)
- And more...

#### Project Structure
- Feature-first architecture
- Clean architecture principles
- Separation of concerns
- Provider-based dependency injection

### Security
- Firebase security rules templates
- Firestore access control
- Storage access control
- User data protection
- Authentication state management

### Known Limitations
- Cart functionality is placeholder
- Order tracking is placeholder
- Full checkout flow not implemented
- Image picker integration pending
- Product data is mock/placeholder
- No real payment processing (B-coin only)
- Limited error handling in some areas
- No offline support yet
- No push notifications yet

### Future Enhancements
- Complete cart and checkout implementation
- Real-time order tracking
- Push notifications
- Offline data caching
- Advanced search and filters
- Product reviews and ratings
- Wishlist functionality
- Multiple addresses management
- Full profile editing
- Password reset flow
- Social sharing
- Analytics integration
- Performance monitoring
- Crash reporting

## [Unreleased]

### Planned Features
- Advanced product filtering
- Category-specific browsing
- Promotional campaigns display
- Advertisement banners
- Product recommendations
- Order history with details
- Refund/return process
- Customer support chat
- App rating prompt
- Onboarding tutorial
- Multi-language support

---

**Note**: Version 1.0.0 represents the initial complete structure of the application. Many features have placeholder implementations and will be fully developed in future releases.
