import 'package:flutter/material.dart';

class RestockDialog extends StatefulWidget {
  const RestockDialog({
    super.key,
  });

  @override
  State<RestockDialog> createState() =>
      _RestockDialogState();
}

class _RestockDialogState
    extends State<RestockDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Restock Product"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Quantity",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final qty =
                int.tryParse(controller.text) ?? 0;

            Navigator.pop(context, qty);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}