import 'dart:io';

import 'package:calculator_cli/commands.dart';
import 'package:calculator_cli/internal_state.dart';

void main(List<String> args) {
  var state = InternalState.empty();

  print("[ Simple RPN calculator ]");
  print("Enter a number or operation (+, -, *, /, undo, clear, quit)");

  while (true) {
    final input = stdin.readLineSync();

    switch (input) {
      case String x when num.tryParse(x) != null:
        state = Enter(num.parse(x)).apply(state);
      case '+':
        state = Add().apply(state);
      case '-':
        state = Subtract().apply(state);
      case '*':
        state = Multiply().apply(state);
      case '/':
        state = Divide().apply(state);
      case 'undo':
        state = Undo().apply(state);
      case 'clear':
        state = Clear().apply(state);
      case String x when ['quit', 'q'].contains(x):
        exit(0);
      default:
        print('Unrecognized command!');
    }
    print(state.stack);
  }
}
