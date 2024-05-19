import 'package:flutter_test/flutter_test.dart';

String? validateTaskName(String name) {
  if (name.isEmpty) return 'Task name cannot be empty';
  if (name.length < 3) return 'Task name must be at least 3 characters long';
  return null;
}

void main() {
  group('Input Validation', () {
    test('Empty task name', () {
      final result = validateTaskName('');
      expect(result, 'Task name cannot be empty');
    });

    test('Task name too short', () {
      final result = validateTaskName('ab');
      expect(result, 'Task name must be at least 3 characters long');
    });

    test('Valid task name', () {
      final result = validateTaskName('Task Name');
      expect(result, null);
    });
  });
}
