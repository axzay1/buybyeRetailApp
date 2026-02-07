# Firebase Setup Guide for BuyBye App

This guide will walk you through setting up Firebase for the BuyBye mobile application.

## Table of Contents

1. [Create Firebase Project](#create-firebase-project)
2. [Enable Authentication](#enable-authentication)
3. [Setup Firestore Database](#setup-firestore-database)
4. [Setup Cloud Storage](#setup-cloud-storage)
5. [Configure Android App](#configure-android-app)
6. [Configure iOS App](#configure-ios-app)
7. [Initialize Sample Data](#initialize-sample-data)

---

## 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter project name: `buybye-retail-app` (or your preferred name)
4. Enable Google Analytics (recommended)
5. Choose or create an Analytics account
6. Click **"Create project"**

## 2. Enable Authentication

### Enable Email/Password Authentication

1. In Firebase Console, navigate to **Authentication** > **Sign-in method**
2. Click on **Email/Password**
3. Toggle **Enable** switch
4. Click **Save**

### Enable Google Sign-In

1. In the same **Sign-in method** tab, click on **Google**
2. Toggle **Enable** switch
3. Enter your **Project support email**
4. Click **Save**

### Configure OAuth Consent Screen (for Google Sign-In)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Navigate to **APIs & Services** > **OAuth consent screen**
4. Fill in required fields:
   - App name: BuyBye
   - User support email: your email
   - Developer contact information: your email
5. Click **Save and Continue**

## 3. Setup Firestore Database

### Create Database

1. In Firebase Console, navigate to **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (we'll add security rules later)
4. Select a location (choose closest to your users)
5. Click **Enable**

### Apply Security Rules

1. Go to **Firestore Database** > **Rules** tab
2. Replace the default rules with the following:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper functions
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // Users collection
    match /users/{userId} {
      allow read: if isSignedIn();
      allow write: if isOwner(userId);
    }
    
    // Products collection (read-only for users)
    match /products/{productId} {
      allow read: if true; // Public read access
      allow write: if false; // Only admin can write via backend
    }
    
    // Orders collection
    match /orders/{orderId} {
      allow read: if isSignedIn() && resource.data.userId == request.auth.uid;
      allow create: if isSignedIn() && request.resource.data.userId == request.auth.uid;
      allow update, delete: if false; // Only backend can modify
    }
    
    // Transactions collection
    match /transactions/{transactionId} {
      allow read: if isSignedIn() && resource.data.userId == request.auth.uid;
      allow write: if false; // Only backend can write
    }
    
    // Sell requests collection
    match /sell_requests/{sellId} {
      allow read: if isSignedIn() && resource.data.userId == request.auth.uid;
      allow create: if isSignedIn() && request.resource.data.userId == request.auth.uid;
      allow update, delete: if false; // Only backend can modify
    }
    
    // Campaigns collection (read-only)
    match /campaigns/{campaignId} {
      allow read: if true; // Public read access
      allow write: if false; // Only admin can write
    }
  }
}
```

3. Click **Publish**

### Create Sample Collections

Create these collections manually or via your admin panel:

1. **users** - Will be auto-created on user registration
2. **products** - Add some sample products
3. **orders** - Will be created when users place orders
4. **transactions** - Will be created on transactions
5. **sell_requests** - Will be created when users sell items
6. **campaigns** - Add promotional campaigns (optional)

## 4. Setup Cloud Storage

### Create Storage Bucket

1. In Firebase Console, navigate to **Storage**
2. Click **Get started**
3. Choose **Start in test mode**
4. Click **Next**
5. Choose storage location (same as Firestore)
6. Click **Done**

### Apply Storage Rules

1. Go to **Storage** > **Rules** tab
2. Replace the default rules with:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User profile images
    match /users/{userId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Product images (admin only write)
    match /products/{allPaths=**} {
      allow read: if true;
      allow write: if false; // Only admin via backend
    }
    
    // Sell request images
    match /sell_requests/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Campaign/Banner images
    match /campaigns/{allPaths=**} {
      allow read: if true;
      allow write: if false; // Only admin
    }
  }
}
```

3. Click **Publish**

## 5. Configure Android App

### Add Android App to Firebase

1. In Firebase Console, click on **Project Overview** (gear icon) > **Project settings**
2. Scroll down to **Your apps** section
3. Click on **Android** icon
4. Fill in the form:
   - **Android package name**: `com.buybye.retailapp`
   - **App nickname**: BuyBye Android (optional)
   - **Debug signing certificate SHA-1**: Get this by running:
     ```bash
     keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
     ```
     Default password is: `android`
5. Click **Register app**
6. Download `google-services.json`
7. Place the file in: `android/app/google-services.json`

### Get SHA-1 for Release Keystore

For production builds, you'll need to add your release keystore SHA-1:

```bash
keytool -list -v -keystore your-release-key.jks -alias your-key-alias
```

Add this SHA-1 in Firebase Console: **Project Settings** > **Your apps** > Android app > **Add fingerprint**

### Verify android/app/build.gradle

Ensure you have the Google services plugin (usually auto-configured):

```gradle
apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services' // Add this line

dependencies {
    // ... other dependencies
    implementation platform('com.google.firebase:firebase-bom:32.0.0')
}
```

## 6. Configure iOS App

### Add iOS App to Firebase

1. In Firebase Console, go to **Project Settings**
2. Scroll down to **Your apps** section
3. Click on **iOS** icon
4. Fill in the form:
   - **iOS bundle ID**: `com.buybye.retailapp`
   - **App nickname**: BuyBye iOS (optional)
   - **App Store ID**: Leave empty for now
5. Click **Register app**
6. Download `GoogleService-Info.plist`
7. Open Xcode and add the file to: `ios/Runner/GoogleService-Info.plist`
   - Right-click on `Runner` folder > **Add Files to "Runner"**
   - Select the downloaded file
   - Ensure **"Copy items if needed"** is checked
   - Select **"Runner"** target

### Configure URL Schemes (for Google Sign-In)

1. Open `ios/Runner/Info.plist`
2. Add the following (replace REVERSED_CLIENT_ID with value from GoogleService-Info.plist):

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>YOUR_REVERSED_CLIENT_ID</string>
    </array>
  </dict>
</array>
```

To find your REVERSED_CLIENT_ID:
- Open `GoogleService-Info.plist`
- Look for `REVERSED_CLIENT_ID` value
- Copy it to the URL scheme above

## 7. Initialize Sample Data

### Add Sample Products

You can add sample products via Firebase Console or create an admin script:

```javascript
// Sample product document structure
{
  "name": "Sample Product",
  "description": "This is a sample product description",
  "price": 500, // In B-Coins
  "images": [
    "https://via.placeholder.com/400"
  ],
  "category": "Electronics",
  "stock": 10,
  "rating": 4.5,
  "reviewCount": 25,
  "isFeatured": true,
  "createdAt": Firebase.firestore.FieldValue.serverTimestamp()
}
```

### Test Authentication

1. Run your Flutter app
2. Try registering a new account
3. Check Firebase Console > **Authentication** > **Users** tab
4. Your user should appear in the list

### Verify User Document Creation

1. Register a user via the app
2. Go to Firebase Console > **Firestore Database**
3. Check the **users** collection
4. A document with the user's UID should exist

## Troubleshooting

### Android: Google Sign-In not working

- Verify SHA-1 fingerprint is added in Firebase Console
- Check that package name matches exactly: `com.buybye.retailapp`
- Ensure `google-services.json` is in the correct location

### iOS: Google Sign-In not working

- Verify bundle ID matches exactly: `com.buybye.retailapp`
- Check that `GoogleService-Info.plist` is properly added to Xcode
- Ensure URL schemes are configured correctly
- Check that Google Sign-In is enabled in Firebase Console

### Firestore permission denied

- Check that your security rules are published
- Verify the user is authenticated (check `request.auth`)
- Ensure the user's UID matches the document owner

### Firebase not initialized

- Make sure config files are in the correct locations
- Run `flutter clean` and `flutter pub get`
- Rebuild the app

## Next Steps

1. **Enable Firebase Analytics** (if not already enabled)
2. **Setup Cloud Functions** (optional) for:
   - Product valuation automation
   - Transaction processing
   - Push notifications
3. **Configure Firebase Cloud Messaging** for notifications
4. **Setup Firebase Performance Monitoring**
5. **Enable Crashlytics** for crash reporting

## Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Security Rules Guide](https://firebase.google.com/docs/rules)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)

---

**Important**: Never commit your `google-services.json` or `GoogleService-Info.plist` files to version control. They should be listed in `.gitignore`.

For production deployments, consider:
- Setting up proper security rules
- Implementing rate limiting
- Adding backup strategies
- Monitoring usage and costs
- Setting up proper app distribution (Play Store, App Store)
