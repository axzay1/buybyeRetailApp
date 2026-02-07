import 'package:flutter_test/flutter_test.dart';
import 'package:buybye_retail_app/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), null);
        expect(Validators.validateEmail('user.name@domain.co.uk'), null);
      });

      test('should return error for invalid email', () {
        expect(Validators.validateEmail('invalid'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
        expect(Validators.validateEmail(''), isNotNull);
      });
    });

    group('validatePassword', () {
      test('should return null for valid password', () {
        expect(Validators.validatePassword('password123'), null);
        expect(Validators.validatePassword('123456'), null);
      });

      test('should return error for invalid password', () {
        expect(Validators.validatePassword('12345'), isNotNull);
        expect(Validators.validatePassword(''), isNotNull);
      });
    });

    group('validateConfirmPassword', () {
      test('should return null when passwords match', () {
        expect(
          Validators.validateConfirmPassword('password123', 'password123'),
          null,
        );
      });

      test('should return error when passwords do not match', () {
        expect(
          Validators.validateConfirmPassword('password123', 'different'),
          isNotNull,
        );
      });

      test('should return error when empty', () {
        expect(
          Validators.validateConfirmPassword('', 'password123'),
          isNotNull,
        );
      });
    });
  });
}
