# BuyBye App Architecture

This document describes the architecture and design patterns used in the BuyBye mobile application.

## Architecture Overview

The BuyBye app follows a **Feature-First Clean Architecture** pattern with **Riverpod** for state management.

```
┌─────────────────────────────────────────┐
│         Presentation Layer               │
│  (UI, Widgets, Screens, Controllers)    │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Domain Layer                     │
│     (Models, Business Logic)            │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Data Layer                       │
│  (Services, Repositories, Data Sources) │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         External Services                │
│    (Firebase, Storage, Network)         │
└─────────────────────────────────────────┘
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # Root app widget
│
├── config/                      # App-wide configuration
│   ├── theme/                   # Theme configuration
│   ├── routes/                  # Navigation/routing
│   └── firebase/                # Firebase config
│
├── core/                        # Core utilities and widgets
│   ├── constants/               # App constants
│   ├── utils/                   # Utility functions
│   └── widgets/                 # Reusable widgets
│
├── features/                    # Feature modules
│   ├── auth/                    # Authentication feature
│   │   ├── data/               # Data sources, repositories
│   │   ├── domain/             # Models, entities
│   │   ├── presentation/       # UI screens and widgets
│   │   └── providers/          # Riverpod providers
│   │
│   ├── products/               # Products feature
│   ├── cart/                   # Shopping cart feature
│   ├── orders/                 # Orders feature
│   ├── wallet/                 # Wallet feature
│   ├── selling/                # Selling feature
│   └── profile/                # Profile feature
│
└── services/                   # Global services
    ├── firebase_auth_service.dart
    ├── firestore_service.dart
    └── storage_service.dart
```

## Design Patterns

### 1. Feature-First Architecture

Each feature is self-contained with its own:
- **Data layer**: API calls, database operations
- **Domain layer**: Business logic and models
- **Presentation layer**: UI and state management

Benefits:
- Easy to navigate and understand
- Features can be developed independently
- Better code organization and modularity
- Easier to test

### 2. Riverpod State Management

**Provider Types Used:**

#### Provider
For simple, immutable values:
```dart
final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});
```

#### StateProvider
For simple mutable state:
```dart
final currentIndexProvider = StateProvider<int>((ref) => 0);
```

#### StateNotifierProvider
For complex state with business logic:
```dart
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);
```

#### FutureProvider
For asynchronous operations:
```dart
final userProvider = FutureProvider<UserModel>((ref) async {
  final userId = ref.watch(authStateProvider).value?.uid;
  return await fetchUser(userId);
});
```

#### StreamProvider
For real-time data:
```dart
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
```

### 3. Repository Pattern

Services act as repositories abstracting data sources:

```dart
class FirestoreService {
  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String docId,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .get();
  }
}
```

### 4. Dependency Injection

Using Riverpod for dependency injection:

```dart
// Define dependencies
final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// Inject dependencies
class AuthController {
  final Ref ref;
  
  AuthController(this.ref);
  
  FirebaseAuthService get _authService => ref.read(authServiceProvider);
}
```

## Core Concepts

### Models

Immutable data classes with factory constructors:

```dart
class Product {
  final String id;
  final String name;
  final double price;
  
  Product({
    required this.id,
    required this.name,
    required this.price,
  });
  
  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'],
      price: data['price'].toDouble(),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
```

### Services

Centralized business logic and external API interactions:

- **FirebaseAuthService**: Authentication operations
- **FirestoreService**: Database operations
- **StorageService**: File storage operations

### Screens

StatelessWidget or ConsumerWidget for UI:

```dart
class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    
    return Scaffold(
      // UI implementation
    );
  }
}
```

## Data Flow

### Reading Data

```
User Action → Widget → Provider → Service → Firebase
                ↓
          Update UI ← Provider watches changes
```

### Writing Data

```
User Input → Controller → Service → Firebase
                             ↓
                    Update Provider State
                             ↓
                         Update UI
```

## State Management Flow

### Authentication Flow

```
1. User taps login button
2. LoginScreen calls AuthController.signIn()
3. AuthController uses FirebaseAuthService
4. FirebaseAuthService authenticates with Firebase
5. authStateProvider emits new user state
6. Router redirects to home screen
7. UI updates automatically
```

### Data Fetching Flow

```
1. Screen watches a provider
2. Provider fetches data from Firestore
3. Provider emits loading state
4. UI shows loading indicator
5. Data arrives from Firestore
6. Provider emits data state
7. UI displays data
```

## Navigation

Using **GoRouter** for declarative routing:

```dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      // Redirect logic
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      // More routes
    ],
  );
});
```

## Theme Management

Dark/Light theme with persistent storage:

```dart
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light) {
    _loadThemeMode();
  }
  
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await _saveThemeMode(newMode);
    state = newMode;
  }
}
```

## Error Handling

### Service Level
```dart
try {
  await firestoreService.setDocument(...);
} catch (e) {
  debugPrint('Error: $e');
  rethrow;
}
```

### UI Level
```dart
final userAsync = ref.watch(userProvider);

return userAsync.when(
  data: (user) => UserWidget(user),
  loading: () => LoadingIndicator(),
  error: (error, stack) => ErrorWidget(error),
);
```

## Firebase Integration

### Authentication
- Email/Password
- Google Sign-In
- User session management

### Firestore
- Real-time data sync
- Structured collections
- Security rules enforcement

### Storage
- Image uploads
- File management
- Access control

## Performance Optimizations

1. **Const Constructors**: Reduce rebuilds
2. **Cached Network Images**: Reduce bandwidth
3. **Lazy Loading**: Load data on demand
4. **Provider Scoping**: Limit rebuild scope
5. **Debouncing**: Reduce API calls

## Security Considerations

1. **Firestore Rules**: Row-level security
2. **Authentication**: Secure token handling
3. **Data Validation**: Client and server-side
4. **Storage Rules**: File access control
5. **API Keys**: Never expose in code

## Testing Strategy

### Unit Tests
- Test individual functions
- Test business logic
- Mock dependencies

### Widget Tests
- Test UI components
- Test user interactions
- Test state changes

### Integration Tests
- Test complete flows
- Test Firebase integration
- Test navigation

## Best Practices

1. **Keep widgets small** - Extract complex widgets
2. **Use const constructors** - Improve performance
3. **Avoid logic in build()** - Use controllers/notifiers
4. **Handle loading/error states** - Better UX
5. **Use proper naming** - Improve readability
6. **Document complex code** - Help maintainers
7. **Write tests** - Ensure quality
8. **Follow linting rules** - Consistent code style

## Future Enhancements

1. **Offline Support**: Cache data locally
2. **Push Notifications**: Real-time updates
3. **Analytics**: Track user behavior
4. **Crashlytics**: Monitor app health
5. **Performance Monitoring**: Optimize app speed
6. **A/B Testing**: Test features
7. **Cloud Functions**: Backend logic

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

This architecture provides a solid foundation for building a scalable, maintainable, and performant mobile application.
