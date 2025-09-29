import 'package:flutter_test/flutter_test.dart';
import 'package:team_intelligence/core/utils/helpers/validator.dart';

void main() {
  test('validateEmail returns null for valid email', () {
    final result = Validator.validateEmail('test@example.com');
    expect(result, isNull);
  });

  test('validateEmail returns error for invalid email', () {
    final result = Validator.validateEmail('invalid');
    expect(result, isNotNull);
  });
}
