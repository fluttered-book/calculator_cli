class CalculatorState {
  CalculatorState({
    required this.stack,
    required this.history,
  });

  final List<num> stack;
  final List<List<num>> history;

  static CalculatorState empty() => CalculatorState(stack: [], history: []);

  @override
  String toString() {
    return "{stack: $stack, history: $history}";
  }
}
