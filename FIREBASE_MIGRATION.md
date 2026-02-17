# Firebase Dependencies Update - Migration Guide

## Overview
This document describes the comprehensive dependency updates made to resolve CocoaPods dependency conflicts and align the app with the latest SDKs and packages.

## What Changed

### SDK Requirements
| Component | Old Version | New Version |
|-----------|-------------|-------------|
| Dart SDK | >=3.0.0 | >=3.6.0 |
| Flutter SDK | (not specified) | >=3.27.0 |
| iOS Minimum | 12.0 | 13.0 |

### Package Versions Updated

| Package | Old Version | New Version | Major Changes |
|---------|-------------|-------------|---------------|
| **State Management** |
| flutter_riverpod | 2.4.9 | 3.2.0 | Major version upgrade |
| riverpod_annotation | 2.3.3 | 3.0.3 | Major version upgrade |
| riverpod_generator | 2.3.9 | 3.0.3 | Major version upgrade |
| riverpod_lint | 2.3.7 | 3.0.3 | Major version upgrade |
| build_runner | 2.4.8 | 2.7.1 | Minor version upgrade |
| **Firebase** |
| firebase_core | 2.24.2 | 4.4.0 | Major version upgrade |
| firebase_auth | 4.15.3 | 6.1.1 | Major version upgrade |
| firebase_storage | 11.5.6 | 12.1.0 | Major version upgrade |
| cloud_firestore | 4.13.6 | 6.1.2 | Major version upgrade |
| firebase_messaging | 14.7.9 | 16.1.1 | Major version upgrade |
| **Authentication** |
| google_sign_in | 6.2.1 | 7.2.0 | Major version upgrade |
| **UI & Navigation** |
| go_router | 13.0.0 | 14.6.2 | Major version upgrade |
| flutter_svg | 2.0.9 | 2.0.10 | Patch update |
| **Utilities** |
| url_launcher | 6.2.4 | 6.2.5 | Patch update |
| path_provider | 2.1.2 | 2.1.3 | Patch update |

## Why This Update Was Necessary

The previous Firebase plugin versions had conflicting native iOS dependencies:

1. **GoogleUtilities/Environment Conflict**:
   - Old Firebase plugins required GoogleUtilities v7.x
   - google_sign_in_ios required GoogleUtilities v8.x
   - These versions were incompatible, causing CocoaPods resolution to fail

2. **AppAuth Version Conflict**:
   - Multiple plugins had overlapping but incompatible AppAuth version requirements

The new versions all use compatible native dependencies that work together.

### Resolution of GoogleUtilities Conflict

To resolve the GoogleUtilities/Environment version conflict between Firebase iOS SDK and google_sign_in_ios:
- Added explicit constraint in `ios/Podfile` to force GoogleUtilities/Environment ~> 8.0
- This ensures all Firebase and Google Sign-In dependencies use compatible versions
- The current Firebase packages (4.x+) and google_sign_in (7.x+) both support GoogleUtilities 8.x

## Breaking Changes to Watch For

### 1. Flutter and Dart SDK Requirements
- **Dart SDK now requires 3.6.0 or later**
- **Flutter SDK now requires 3.27.0 or later**
- Ensure your development environment is updated before running `flutter pub get`

### 2. iOS Minimum Version
- **Your app now requires iOS 13.0 or later**
- If you need to support iOS 12.x devices, you cannot use these updates

### 3. Riverpod State Management
- Riverpod has been upgraded from 2.x to 3.x/4.x which includes breaking changes
- **Important**: All Riverpod packages must use compatible versions:
  - `riverpod_annotation` updated to 4.0.0 for compatibility with `flutter_riverpod` 3.2.0
  - `riverpod_generator` updated to 4.0.0 to match `riverpod_annotation` 4.0.0
  - `riverpod_lint` updated to 3.1.0 for latest linting rules
- Check [Riverpod 3.0 migration guide](https://riverpod.dev/docs/migration/from_state_notifier) for details
- Key changes:
  - StateNotifierProvider is deprecated, use NotifierProvider instead
  - Family syntax changes
  - Code generation improvements

### 4. Google Sign-In
- Updated from 6.x to 7.x with API changes
- Review authentication flows after update

### 5. Go Router
- Updated from 13.x to 14.x
- Check navigation routes and deep linking functionality

### 6. API Changes
While we've updated the dependencies, there may be API changes in the major version updates. Key areas to test:

#### Firebase Auth
- Check if your authentication flows still work
- Test sign-in, sign-out, and token refresh
- Verify Firebase Auth state listeners

#### Cloud Firestore
- Test all database queries and writes
- Verify real-time listeners
- Check transaction handling

#### Firebase Storage
- Test file uploads and downloads
- Verify metadata handling
- Check storage reference paths

#### Firebase Messaging
- Test push notification reception
- Verify notification handlers (foreground/background/terminated)
- Check notification permissions flow

## Steps to Apply This Update

### 0. Update Your Development Environment
**IMPORTANT: You must update Flutter and Dart first!**

```bash
# Check your current Flutter version
flutter --version

# Update Flutter to 3.27.x or later
flutter upgrade

# Verify you have Dart 3.6.x or later
dart --version
```

If your Flutter version is below 3.27.0, you won't be able to use these package updates.

### 1. Clean Flutter Dependencies
```bash
flutter clean
flutter pub get
```

### 2. Update iOS Pods
```bash
cd ios
pod deintegrate
pod repo update
pod install
cd ..
```

### 3. Run Your App
```bash
flutter run
```

## Testing Checklist

- [ ] App builds successfully for iOS
- [ ] Firebase Authentication works
- [ ] Cloud Firestore queries and writes work
- [ ] Firebase Storage uploads/downloads work
- [ ] Push notifications are received
- [ ] Google Sign-In works (if used)
- [ ] All Firebase-dependent features function correctly

## Troubleshooting

### Issue: Pod install fails with "Unable to find a target named RunnerTests"
**Solution**: 
The Podfile has been updated to remove the non-existent `RunnerTests` target reference. This target was part of the default Flutter template but doesn't exist in the actual Xcode project.

If you still encounter this error after pulling the latest changes:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
```

### Issue: Pod install fails with GoogleUtilities/Environment conflict
**Solution**: 
The Podfile has been updated to explicitly require GoogleUtilities/Environment ~> 8.0 to ensure compatibility. If you still encounter issues:
```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install
```

### Issue: Pod install fails
**Solution**: 
```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install
```

### Issue: Build fails with "Minimum deployment target" error
**Solution**: Ensure your Xcode project settings match:
- In Xcode, open `Runner.xcodeproj`
- Select the Runner target
- Under "Deployment Info", set "iOS Deployment Target" to 13.0

### Issue: Firebase not initializing
**Solution**: Ensure you've run `flutter pub get` and the Firebase configuration files are present:
- iOS: `ios/Runner/GoogleService-Info.plist`
- Android: `android/app/google-services.json`

## References

- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [FlutterFire Release Notes](https://firebase.google.com/support/release-notes/flutter)
- [Firebase iOS SDK Release Notes](https://firebase.google.com/support/release-notes/ios)

## Support

If you encounter issues after this update:
1. Check the [FlutterFire GitHub Issues](https://github.com/firebase/flutterfire/issues)
2. Review the [Firebase Flutter Migration Guides](https://firebase.flutter.dev/docs/migration/)
3. Consult the package-specific changelogs on [pub.dev](https://pub.dev)

---

**Last Updated**: February 7, 2026  
**Migration Required**: Yes (test thoroughly before deploying)
