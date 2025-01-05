class InternalState {
  InternalState({
    required this.stack,
    required this.history,
  });

  final List<num> stack;
  final List<List<num>> history;

  static InternalState empty() => InternalState(stack: [], history: []);

  @override
  String toString() {
    return "{stack: $stack, history: $history}";
  }
}
