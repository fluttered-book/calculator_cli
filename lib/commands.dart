import 'calculator_state.dart';

/// Abstract base class for all calculator operations
abstract class Command {
  CalculatorState execute(CalculatorState state);
}

class Enter implements Command {
  const Enter(this.number);

  final num number;

  @override
  CalculatorState execute(CalculatorState state) {
    return CalculatorState(
      stack: [...state.stack, number],
      history: [...state.history, state.stack],
    );
  }
}

class Clear implements Command {
  @override
  CalculatorState execute(CalculatorState state) {
    return CalculatorState.empty();
  }
}

class Undo extends Command {
  @override
  CalculatorState execute(CalculatorState state) {
    if (state.history.isEmpty) return state;
    return CalculatorState(
      stack: state.history.last,
      history: [...state.history.take(state.history.length - 1)],
    );
  }
}

/// Operators (+, -, /, *) should use this as base class to avoid duplication
abstract class Operator implements Command {
  num operate(num operand1, num operand2);

  @override
  CalculatorState execute(CalculatorState state) {
    if (state.stack.length < 2) return state;
    final operand2 = state.stack.last;
    final operand1 = state.stack.elementAt(state.stack.length - 2);
    return CalculatorState(
      stack: [
        ...state.stack.take(state.stack.length - 2),
        operate(operand1, operand2)
      ],
      history: [...state.history, state.stack],
    );
  }
}

class Add extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 + operand2;
}

class Subtract extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 - operand2;
}

class Multiply extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 * operand2;
}

class Divide extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 / operand2;
}
