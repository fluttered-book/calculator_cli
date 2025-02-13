import 'dart:io';

import 'package:calculator_cli/commands.dart';
import 'package:calculator_cli/calculator_state.dart';

void main() {
  var state = CalculatorState.empty();

  print("[ Simple RPN calculator ]");
  print("Enter a number or operation (+, -, *, /, undo, clear, quit)");

  while (true) {
    final input = stdin.readLineSync();

    switch (input) {
      case String x when num.tryParse(x) != null:
        state = Enter(num.parse(x)).execute(state);
      case '+':
        state = Add().execute(state);
      case '-':
        state = Subtract().execute(state);
      case '*':
        state = Multiply().execute(state);
      case '/':
        state = Divide().execute(state);
      case 'undo':
        state = Undo().execute(state);
      case 'clear':
        state = Clear().execute(state);
      case String x when ['quit', 'q'].contains(x):
        exit(0);
      default:
        print('Unrecognized command!');
    }
    print(state.stack);
  }
}
