# Integration Tests

This directory contains integration tests for the BuyBye app.

## Running Integration Tests

Integration tests test the complete user flows through the app.

### Prerequisites

- A device or emulator running
- Firebase configured (test environment recommended)

### Run Integration Tests

```bash
# Run all integration tests
flutter test integration_test/

# Run a specific test
flutter test integration_test/login_flow_test.dart
```

## Test Structure

Integration tests should cover:

1. **Authentication Flow**
   - User registration
   - Login with email/password
   - Login with Google
   - Logout

2. **Shopping Flow**
   - Browse products
   - Search products
   - View product details
   - Add to cart
   - Checkout

3. **Selling Flow**
   - Upload product
   - Submit sell request
   - View selling history

4. **Wallet Flow**
   - View balance
   - View transaction history

5. **Profile Flow**
   - Edit profile
   - Manage addresses
   - View orders

## Example Integration Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:buybye_retail_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow', () {
    testWidgets('User can login with email and password', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password123');

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify navigation to home screen
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
```

## Best Practices

1. Use meaningful test names
2. Clean up test data after each test
3. Use test-specific Firebase project
4. Mock external dependencies when possible
5. Test edge cases and error scenarios
