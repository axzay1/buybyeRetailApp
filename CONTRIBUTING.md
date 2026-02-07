# Contributing to BuyBye Mobile App

Thank you for your interest in contributing to BuyBye! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the issue
- **Expected behavior** vs **actual behavior**
- **Screenshots** if applicable
- **Environment details** (Flutter version, device, OS)

### Suggesting Features

Feature suggestions are welcome! Please provide:

- **Clear use case** for the feature
- **Detailed description** of the proposed functionality
- **Mockups or examples** if applicable
- **Why this feature would be useful** to users

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the coding standards** outlined below
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Write clear commit messages**
6. **Submit a pull request** with a clear description

## Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/axzay1/buybyeRetailApp.git
   cd buybyeRetailApp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase** (see FIREBASE_SETUP.md)

4. **Run the app**
   ```bash
   flutter run
   ```

## Coding Standards

### Dart Style Guide

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check code quality
- Format code with `flutter format .`

### Code Organization

- Keep files small and focused (< 300 lines when possible)
- One class per file (with exceptions for related small classes)
- Group related files in feature folders
- Use meaningful names for files, classes, and variables

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE` or `camelCase` for const
- **Private members**: prefix with `_`

### Widget Guidelines

- Prefer `const` constructors when possible
- Extract complex widgets into separate files
- Keep widget build methods simple
- Use composition over inheritance

### State Management (Riverpod)

- Use appropriate provider types:
  - `Provider` for simple values
  - `StateProvider` for simple state
  - `StateNotifierProvider` for complex state
  - `FutureProvider` for async operations
  - `StreamProvider` for real-time data

### Example Code Structure

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final counterProvider = StateProvider<int>((ref) => 0);

// Widget
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text('Count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Testing

### Writing Tests

- Write tests for new features
- Maintain or improve code coverage
- Test edge cases and error scenarios

### Test Types

1. **Unit Tests** (`test/unit/`)
   - Test individual functions and classes
   - Mock dependencies

2. **Widget Tests** (`test/widget/`)
   - Test UI components
   - Verify widget behavior

3. **Integration Tests** (`test/integration/`)
   - Test complete user flows
   - Verify app functionality

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/unit/validators_test.dart

# With coverage
flutter test --coverage
```

## Documentation

- Document public APIs and complex functions
- Use dartdoc comments (`///`) for public members
- Keep README and other docs up to date
- Include code examples where helpful

### Dartdoc Example

```dart
/// Validates an email address.
///
/// Returns `null` if the email is valid, otherwise returns an error message.
///
/// Example:
/// ```dart
/// final error = Validators.validateEmail('test@example.com');
/// print(error); // null
/// ```
String? validateEmail(String? value) {
  // Implementation
}
```

## Git Workflow

### Branch Naming

- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `refactor/description` - Code refactoring
- `test/description` - Test additions/fixes

### Commit Messages

Follow conventional commits format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:
```
feat(auth): add Google Sign-In support

fix(wallet): correct B-coin balance calculation

docs(readme): update Firebase setup instructions
```

## Review Process

1. **Automated checks** must pass (linting, tests)
2. **Code review** by at least one maintainer
3. **Address feedback** promptly
4. **Squash commits** if requested before merging

## Firebase Guidelines

### Firestore

- Use proper security rules
- Index queries appropriately
- Minimize reads/writes
- Use transactions for related operations
- Handle offline scenarios

### Storage

- Compress images before upload
- Use appropriate file paths
- Clean up unused files
- Implement proper security rules

### Authentication

- Never expose credentials
- Use secure token handling
- Implement proper error handling
- Test authentication flows thoroughly

## Performance Guidelines

- Optimize images (use cached_network_image)
- Lazy load data when possible
- Use const constructors
- Avoid rebuilding widgets unnecessarily
- Profile app performance regularly

## Accessibility

- Provide semantic labels for screen readers
- Ensure adequate color contrast
- Support text scaling
- Test with TalkBack/VoiceOver

## Questions?

- Check existing [Issues](https://github.com/axzay1/buybyeRetailApp/issues)
- Create a new issue for discussion
- Contact maintainers

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

Thank you for contributing to BuyBye! 🎉
