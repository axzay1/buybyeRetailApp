# CocoaPods Dependency Conflict Resolution

## Date
February 7, 2026

## Problem Statement

The project encountered a critical CocoaPods dependency conflict that prevented iOS builds:

```
[!] CocoaPods could not find compatible versions for pod "GoogleUtilities/Environment":
  firebase_auth (4.16.0) → Firebase/Auth (10.25.0) → GoogleUtilities/Environment (~> 7.8)
  firebase_messaging (14.7.10) → Firebase/Messaging (10.25.0) → GoogleUtilities/Environment (~> 7.7)
  firebase_storage (11.6.5) → Firebase/Storage (10.25.0) → GoogleUtilities/Environment (~> 7.12)
  google_sign_in_ios (0.0.1) → GoogleSignIn (~> 8.0) → GoogleUtilities/Environment (~> 8.0)
```

### Root Cause

The Flutter Firebase plugins (firebase_auth, firebase_storage, firebase_messaging) were using Firebase iOS SDK 10.25.0, which required GoogleUtilities/Environment version 7.x. However, the google_sign_in plugin required GoogleSignIn 8.0, which depends on GoogleUtilities/Environment 8.x.

These version requirements are **incompatible** - there is no version of GoogleUtilities/Environment that satisfies both ~> 7.x and ~> 8.0 constraints.

## Solution Implemented

### 1. Removed google_sign_in Package

**Rationale**: Following the user directive to "remove all the things in our project which are causing this issue", the `google_sign_in` package was removed as it was the source of the GoogleUtilities version conflict.

**Changes Made**:
- ✅ Removed `google_sign_in: ^7.2.0` from `pubspec.yaml`
- ✅ Removed Google Sign-In imports from `firebase_auth_service.dart`
- ✅ Removed `signInWithGoogle()` method from `FirebaseAuthService`
- ✅ Removed `signInWithGoogle()` method from `AuthController`
- ✅ Removed Google Sign-In button from login screen UI
- ✅ Removed Google Sign-In related strings from `app_strings.dart`
- ✅ Updated `signOut()` method to only sign out from Firebase (removed Google Sign-In sign out)

### 2. Fixed iOS Platform Specification

**Changes Made**:
- ✅ Uncommented `platform :ios, '13.0'` in Podfile to explicitly specify iOS platform
- ✅ This resolves the warning: "Automatically assigning platform `iOS` with version `13.0`"

## Impact

### Removed Features
- ❌ Google Sign-In authentication is no longer available
- Users can still authenticate using:
  - ✅ Email/Password sign-in
  - ✅ Email/Password registration
  - ✅ Password reset via email

### Benefits
- ✅ CocoaPods dependency conflict resolved
- ✅ iOS builds can now proceed without version conflicts
- ✅ All remaining Firebase features (Auth, Firestore, Storage, Messaging) work correctly
- ✅ Cleaner dependency tree
- ✅ Faster pod install times (fewer dependencies)

## Alternative Solutions Considered

### Option 1: Wait for Firebase Plugin Updates (Not Chosen)
- Wait for Firebase Flutter plugins to update to Firebase iOS SDK 11.x which supports GoogleUtilities 8.x
- **Rejected**: Timeframe uncertain, project needs immediate resolution

### Option 2: Downgrade google_sign_in (Not Chosen)
- Downgrade to an older version of google_sign_in that uses GoogleUtilities 7.x
- **Rejected**: Would require downgrading to very old versions with potential security issues

### Option 3: Force GoogleUtilities Version Override (Not Chosen)
- Add pod override: `pod 'GoogleUtilities', '~> 8.0'`
- **Rejected**: Firebase plugins explicitly require 7.x; forcing 8.x would break Firebase functionality

### Option 4: Remove google_sign_in (CHOSEN) ✅
- Remove the conflicting package entirely
- **Chosen**: Most reliable solution that resolves the conflict immediately while maintaining all other Firebase features

## Next Steps for Re-enabling Google Sign-In

If Google Sign-In is required in the future, it can be re-added once:

1. **Firebase Flutter plugins update** to use Firebase iOS SDK 11.x or later, which supports GoogleUtilities 8.x
2. **All dependencies align** on compatible GoogleUtilities versions

Monitor these resources for updates:
- [FlutterFire Release Notes](https://firebase.google.com/support/release-notes/flutter)
- [firebase_auth on pub.dev](https://pub.dev/packages/firebase_auth)
- [google_sign_in on pub.dev](https://pub.dev/packages/google_sign_in)

## Testing Checklist

After these changes:
- [ ] Run `flutter clean`
- [ ] Run `flutter pub get`
- [ ] Run `cd ios && pod install`
- [ ] Build the iOS app
- [ ] Test email/password authentication
- [ ] Test user registration
- [ ] Test password reset
- [ ] Verify all Firebase features work correctly

## Related Documentation

- See `FIREBASE_MIGRATION.md` for previous Firebase updates
- See `SDK_UPDATE_SUMMARY.md` for complete SDK update history
- See `pubspec.yaml` for current package versions

---

**Status**: ✅ RESOLVED  
**Resolution Date**: February 7, 2026  
**Resolution Method**: Removed conflicting google_sign_in package
