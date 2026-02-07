import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../services/firestore_service.dart';
import '../domain/models/user_model.dart';

// Auth Service Provider
final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// Firestore Service Provider
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Current User Data Provider
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  
  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value(null);
      }
      return firestoreService
          .documentStream(collection: 'users', docId: user.uid)
          .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

// Auth Controller
final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

class AuthController {
  final Ref ref;

  AuthController(this.ref);

  FirebaseAuthService get _authService => ref.read(authServiceProvider);
  FirestoreService get _firestoreService => ref.read(firestoreServiceProvider);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );

      // Create user document in Firestore
      if (credential.user != null) {
        final userModel = UserModel(
          id: credential.user!.uid,
          email: email,
          displayName: displayName,
          photoURL: null,
          bCoinBalance: 0,
          addresses: [],
          createdAt: DateTime.now(),
        );

        await _firestoreService.setDocument(
          collection: 'users',
          docId: credential.user!.uid,
          data: userModel.toMap(),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final credential = await _authService.signInWithGoogle();

      // Create or update user document
      if (credential.user != null) {
        final userDoc = await _firestoreService.getDocument(
          collection: 'users',
          docId: credential.user!.uid,
        );

        if (!userDoc.exists) {
          final userModel = UserModel(
            id: credential.user!.uid,
            email: credential.user!.email ?? '',
            displayName: credential.user!.displayName ?? '',
            photoURL: credential.user!.photoURL,
            bCoinBalance: 0,
            addresses: [],
            createdAt: DateTime.now(),
          );

          await _firestoreService.setDocument(
            collection: 'users',
            docId: credential.user!.uid,
            data: userModel.toMap(),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}
