import 'package:flutter/material.dart';

class EntryButton extends StatelessWidget {
  const EntryButton({super.key, required this.text, required this.function});
  final String text;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        onPressed: function,
        child: Text(text),
      ),
    );
  }
}
