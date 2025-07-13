import 'package:flutter/material.dart';

class CounterColumn extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterColumn({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(label),
        const SizedBox(height: 16),
        Text(
          '$value',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 72),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onIncrement,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(96, 96),
            padding: const EdgeInsets.all(24),
          ),
          child: const Icon(Icons.add, size: 48),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onDecrement,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(96, 96),
            padding: const EdgeInsets.all(24),
          ),
          child: const Icon(Icons.remove, size: 48),
        ),
      ],
    );
  }
}
