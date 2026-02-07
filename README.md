# BuyBye Mobile App

<div align="center">
  <img src="assets/logo/buybye_logo.png" alt="BuyBye Logo" width="120" height="120" />
  <h3>Sell. Earn. Shop.</h3>
  <p>E-commerce platform where users earn B-coins by selling products and spend B-coins to buy products.</p>
</div>

## 📱 Overview

BuyBye is a complete Flutter mobile application featuring a secure B-coin wallet system where users can ONLY earn B-coins through sales (no external deposits allowed). The app provides a seamless experience for buying and selling products within a closed-loop economy.

### Key Features

- 🛍️ **Shopping**: Browse products, search with filters, category navigation, product details
- 💰 **One-Click Selling**: Ultra-simple selling journey - upload, submit, earn B-coins instantly
- 👛 **B-coin Wallet**: Secure wallet with transaction history and real-time balance updates
- 📦 **Order Tracking**: Live order tracking with status updates and order history
- 👤 **User Management**: Profile management, address book, settings
- 🌓 **Theme Support**: Beautiful Light & Dark mode with Blue & Red color scheme
- 🔐 **Authentication**: Email/Password authentication via Firebase

## 🛠️ Technology Stack

- **Framework**: Flutter (iOS + Android)
- **State Management**: Riverpod
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Navigation**: GoRouter
- **UI**: Material Design 3
- **Theme**: Blue (#1976D2) & Red (#E53935) with Light/Dark mode

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)
- Firebase account
- Git

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/axzay1/buybyeRetailApp.git
cd buybyeRetailApp
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Enable the following services:
   - **Authentication** (Email/Password only - Google Sign-In has been removed due to iOS dependency conflicts)
   - **Cloud Firestore**
   - **Cloud Storage**

#### Android Configuration

1. In Firebase Console, add an Android app
2. Package name: `com.buybye.retailapp`
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`

Example file is provided at `android/app/google-services.json.example`

#### iOS Configuration

1. In Firebase Console, add an iOS app
2. Bundle ID: `com.buybye.retailapp`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/GoogleService-Info.plist`

Example file is provided at `ios/Runner/GoogleService-Info.plist.example`

### 4. Firestore Database Setup

Create the following collections in your Firestore database:

#### Collections Structure

```
users/
  {userId}/
    - email: string
    - displayName: string
    - photoURL: string (optional)
    - bCoinBalance: number
    - addresses: array
    - createdAt: timestamp

products/
  {productId}/
    - name: string
    - description: string
    - price: number (B-coins)
    - images: array
    - category: string
    - stock: number
    - rating: number
    - reviewCount: number
    - isFeatured: boolean
    - createdAt: timestamp

orders/
  {orderId}/
    - userId: string
    - items: array
    - totalAmount: number
    - status: string (pending, processing, shipped, delivered)
    - shippingAddress: map
    - trackingInfo: string (optional)
    - createdAt: timestamp
    - updatedAt: timestamp

transactions/
  {transactionId}/
    - userId: string
    - type: string (earn, spend)
    - amount: number
    - description: string
    - relatedOrderId: string (optional)
    - relatedSaleId: string (optional)
    - timestamp: timestamp

sell_requests/
  {sellId}/
    - userId: string
    - productName: string
    - description: string
    - images: array
    - requestedPrice: number (optional)
    - companyValuation: number (optional)
    - status: string (pending, approved, rejected)
    - bCoinsEarned: number (optional)
    - createdAt: timestamp
    - processedAt: timestamp (optional)

campaigns/
  {campaignId}/
    - title: string
    - description: string
    - bannerImage: string
    - discountPercentage: number
    - productIds: array
    - startDate: timestamp
    - endDate: timestamp
```

#### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Products collection (read-only for users)
    match /products/{productId} {
      allow read: if true;
      allow write: if false; // Only admin can write
    }
    
    // Orders collection
    match /orders/{orderId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update: if false; // Only backend can update
    }
    
    // Transactions collection
    match /transactions/{transactionId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow write: if false; // Only backend can write
    }
    
    // Sell requests collection
    match /sell_requests/{sellId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update: if false; // Only backend can update
    }
    
    // Campaigns collection (read-only)
    match /campaigns/{campaignId} {
      allow read: if true;
      allow write: if false; // Only admin can write
    }
  }
}
```

#### Storage Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /products/{allPaths=**} {
      allow read: if true;
      allow write: if false; // Only admin
    }
    
    match /sell_requests/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 5. Run the App

```bash
# For Android
flutter run

# For iOS
flutter run

# For specific device
flutter run -d <device_id>

# To see available devices
flutter devices
```

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Main app widget
├── config/
│   ├── theme/               # Theme configuration
│   │   └── app_theme.dart
│   ├── routes/              # Navigation/routing
│   │   └── app_router.dart
│   └── firebase/            # Firebase config
├── core/
│   ├── constants/           # App constants
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_assets.dart
│   ├── utils/               # Utility functions
│   │   ├── validators.dart
│   │   └── formatters.dart
│   └── widgets/             # Reusable widgets
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── loading_indicator.dart
├── features/
│   ├── auth/                # Authentication
│   ├── home/                # Home/Main screen
│   ├── products/            # Product browsing
│   ├── cart/                # Shopping cart
│   ├── orders/              # Order management
│   ├── wallet/              # B-coin wallet
│   ├── selling/             # Selling products
│   └── profile/             # User profile
└── services/
    ├── firebase_auth_service.dart
    ├── firestore_service.dart
    └── storage_service.dart
```

## 🎨 Design System

### Colors

- **Primary Blue**: #1976D2, #0D47A1, #42A5F5
- **Secondary Red**: #E53935, #C62828, #EF5350
- **B-coin Gold**: #FFD700, #FFC107
- **Light Mode**: White background (#F5F5F5)
- **Dark Mode**: Dark grey background (#121212)

### Typography

- Uses default Flutter Material Design typography
- Font family: Roboto (system default)

## 🔑 Key Features Explained

### B-coin Wallet System

- **Earn-only economy**: Users can only earn B-coins by selling products
- No external deposits or top-ups allowed
- Real-time balance updates using Firestore streams
- Complete transaction history with filtering

### One-Click Selling

1. User uploads product photos
2. Adds title and optional description
3. Submits to company (BuyBye)
4. Company assigns valuation automatically
5. B-coins credited to wallet instantly
6. No marketplace listing or waiting for buyers

### Shopping Experience

- Grid/List view toggle
- Search with filters (price, rating, category)
- Product details with image gallery
- Add to cart and checkout with B-coins
- Order tracking with status updates

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure

```
test/
├── unit/
│   ├── services/
│   ├── providers/
│   └── utils/
├── widget/
│   └── features/
└── integration/
    └── user_flows/
```

## 🔧 Development

### Code Generation

If using code generation (for Riverpod, Freezed, etc.):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Linting

```bash
flutter analyze
```

### Format Code

```bash
flutter format .
```

## 📱 Build for Production

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
flutter build ipa --release
```

## 🐛 Troubleshooting

### Firebase not initialized

- Ensure you have added `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Check package name/bundle ID matches Firebase configuration

### Google Sign-In not working

**Note**: Google Sign-In has been removed from this app due to iOS CocoaPods dependency conflicts. See `COCOAPODS_FIX.md` for details. Email/Password authentication is still fully functional.

### Build errors

```bash
flutter clean
flutter pub get
flutter pub upgrade
```

## 📄 License

This project is proprietary software. All rights reserved.

## 👨‍💻 Author

BuyBye Team

## 📞 Support

For support, email support@buybye.com or create an issue in the repository.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Riverpod for state management
- All open-source contributors

---

**Note**: This app is currently in development. Some features may not be fully implemented yet. Check the project board for current status and upcoming features.