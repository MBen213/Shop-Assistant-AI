import 'package:flutter/material.dart';

class CompleteSaleButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const CompleteSaleButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: const Icon(Icons.point_of_sale),
        label: const Text(
          'Complete Sale',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}