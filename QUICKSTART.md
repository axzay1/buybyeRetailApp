# Quick Start Guide - BuyBye Mobile App

Get up and running with BuyBye in under 10 minutes!

## Prerequisites Checklist

- [ ] Flutter SDK installed (v3.0.0+)
- [ ] Android Studio or Xcode installed
- [ ] Firebase account created
- [ ] Git installed

## Step-by-Step Setup

### 1. Clone & Install (2 minutes)

```bash
# Clone the repository
git clone https://github.com/axzay1/buybyeRetailApp.git
cd buybyeRetailApp

# Install dependencies
flutter pub get
```

### 2. Firebase Setup (5 minutes)

#### Quick Firebase Setup

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add project"
   - Name it "buybye-app"
   - Click through the setup wizard

2. **Enable Services**
   - Enable **Authentication** (Email/Password & Google)
   - Enable **Cloud Firestore** (Start in test mode)
   - Enable **Cloud Storage** (Start in test mode)

3. **Add Android App**
   - Package name: `com.buybye.retailapp`
   - Download `google-services.json`
   - Place in `android/app/google-services.json`

4. **Add iOS App** (if building for iOS)
   - Bundle ID: `com.buybye.retailapp`
   - Download `GoogleService-Info.plist`
   - Place in `ios/Runner/GoogleService-Info.plist`

> 📘 **Detailed Guide**: See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for complete instructions

### 3. Run the App (1 minute)

```bash
# Start an emulator or connect a device
flutter devices

# Run the app
flutter run
```

That's it! 🎉

## First Steps in the App

### 1. Create an Account
- Open the app
- Tap "Register"
- Enter your details
- Create your account

### 2. Browse Products
- Explore the product catalog
- Use search and filters
- View product details

### 3. Sell an Item
- Tap the "Sell" tab
- Upload photos of your product
- Add title and description
- Submit for instant valuation

### 4. Check Your Wallet
- Tap the "Wallet" tab
- View your B-coin balance
- See transaction history

## Troubleshooting

### App won't run?
```bash
flutter clean
flutter pub get
flutter run
```

### Firebase errors?
- Check that config files are in the correct locations
- Verify package name/bundle ID matches
- Ensure Firebase services are enabled

### Google Sign-In not working?
- **Android**: Add SHA-1 fingerprint in Firebase Console
- **iOS**: Configure URL schemes in Info.plist

### Build errors?
```bash
# For Android
cd android && ./gradlew clean && cd ..

# For iOS
cd ios && pod install && cd ..
```

## Next Steps

- [ ] Add sample products in Firestore
- [ ] Customize theme colors
- [ ] Add your app logo
- [ ] Configure security rules
- [ ] Test all features

## Common Commands

```bash
# Run app
flutter run

# Run on specific device
flutter run -d <device-id>

# Run tests
flutter test

# Check code quality
flutter analyze

# Format code
flutter format .

# Build for release
flutter build apk --release        # Android
flutter build ios --release        # iOS
```

## Project Structure at a Glance

```
buybyeRetailApp/
├── lib/
│   ├── main.dart           # App entry point
│   ├── features/           # Feature modules
│   ├── core/              # Shared code
│   └── services/          # API services
├── test/                  # Tests
├── android/              # Android config
├── ios/                  # iOS config
└── assets/              # Images, fonts
```

## Resources

- 📖 [Full README](README.md)
- 🔥 [Firebase Setup Guide](FIREBASE_SETUP.md)
- 🏗️ [Architecture Guide](ARCHITECTURE.md)
- 🤝 [Contributing Guide](CONTRIBUTING.md)

## Getting Help

- Check the [Issues](https://github.com/axzay1/buybyeRetailApp/issues)
- Read the documentation
- Ask questions in discussions

## What's Next?

Now that you have the app running:

1. **Explore the code** - Check out the feature modules
2. **Read the architecture** - Understand how it's built
3. **Make changes** - Start customizing
4. **Add features** - Build something new!

Happy coding! 🚀
