import 'package:calculator_cli/commands.dart';
import 'package:calculator_cli/internal_state.dart';
import 'package:test/test.dart';

void main() {
  group("Enter", () {
    test("a new stack with given value at the end and old stack in history",
        () {
      final origState = InternalState.empty();
      final newState = Enter(1).apply(origState);

      expect(newState, isNot(origState));
      expect(newState.stack, equals([1]));
      expect(newState.history, hasLength(1));
    });
  });

  group("Clear", () {
    test("an empty state", () {
      final origState = InternalState(stack: [1], history: []);
      final newState = Clear().apply(origState);

      expect(newState, isNot(origState));
      expect(newState.stack, isEmpty);
      expect(newState.history, isEmpty);
    });
  });

  group("Undo", () {
    test("previous state restored from history", () {
      final origState = InternalState(stack: [
        1,
        2
      ], history: [
        [1]
      ]);
      final newState = Undo().apply(origState);

      expect(newState, isNot(origState));
      expect(newState.stack, equals([1]));
      expect(newState.history, isEmpty);
    });
  });

  group("Add", () {
    test('adds the last two values', () {
      final origState = InternalState(stack: [1, 2], history: []);
      final newState = Add().apply(origState);

      expect(newState, isNot(origState));
      expect(newState.stack, equals([3]));
      expect(newState.history, hasLength(1));
    });

    test("does nothing when stack length is less than 2", () {
      final origState = InternalState(stack: [1], history: []);
      final newState = Add().apply(origState);
      expect(newState, equals(origState));
    });
  });

  group("Subtract", () {
    test('Subtract the last two values', () {
      final origState = InternalState(stack: [1, 2], history: []);
      final newState = Subtract().apply(origState);

      expect(newState.stack, equals([-1]));
    });
  });

  group("Multiply", () {
    test('Multiply the last two values', () {
      final origState = InternalState(stack: [2, 3], history: []);
      final newState = Multiply().apply(origState);

      expect(newState.stack, equals([6]));
    });
  });

  group("Divide", () {
    test('Divide the last two values', () {
      final origState = InternalState(stack: [21, 7], history: []);
      final newState = Divide().apply(origState);

      expect(newState.stack, equals([3]));
    });
  });
}
