import 'package:flutter/material.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final double total;
  final Future<void> Function() onConfirm;

  const CheckoutBottomSheet({
    super.key,
    required this.total,
    required this.onConfirm,
  });

  @override
  State<CheckoutBottomSheet> createState() =>
      _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState
    extends State<CheckoutBottomSheet> {
  final TextEditingController _receivedController =
      TextEditingController();

  bool _cashPayment = true;
  bool _isSaving = false;

  double get received =>
      double.tryParse(_receivedController.text) ?? 0;

  double get change {
    final value = received - widget.total;
    return value < 0 ? 0 : value;
  }

  bool get canConfirm {
    if (_isSaving) return false;

    if (_cashPayment) {
      return received >= widget.total;
    }

    return true;
  }

  @override
  void dispose() {
    _receivedController.dispose();
    super.dispose();
  }

  Future<void> _confirmSale() async {
    setState(() {
      _isSaving = true;
    });

    try {
      await widget.onConfirm();

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to complete sale\n$e",
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Widget _summaryTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _summaryTile(
              icon: Icons.payments,
              title: "Total Amount",
              value:
                  "${widget.total.toStringAsFixed(2)} DA",
              color: Colors.green,
            ),

            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  icon: Icon(Icons.payments),
                  label: Text("Cash"),
                ),
                ButtonSegment(
                  value: false,
                  icon: Icon(Icons.credit_card),
                  label: Text("Card"),
                ),
              ],
              selected: {_cashPayment},
              onSelectionChanged: (value) {
                setState(() {
                  _cashPayment = value.first;
                });
              },
            ),

            if (_cashPayment) ...[
              const SizedBox(height: 24),

              TextField(
                controller: _receivedController,
                autofocus: true,
                textInputAction:
                    TextInputAction.done,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: "Received Amount",
                  prefixIcon:
                      const Icon(Icons.attach_money),
                  suffixText: "DA",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),

              const SizedBox(height: 18),

              _summaryTile(
                icon: Icons.reply,
                title: "Change",
                value:
                    "${change.toStringAsFixed(2)} DA",
                color: change == 0
                    ? Colors.red
                    : Colors.green,
              ),

              if (received < widget.total &&
                  received != 0)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: Text(
                    "Received amount is less than total.",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
            ],

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed:
                    canConfirm ? _confirmSale : null,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.check_circle,
                      ),
                label: Text(
                  _isSaving
                      ? "Saving..."
                      : "Confirm Sale",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _isSaving
                    ? null
                    : () =>
                        Navigator.pop(context),
                child: const Text(
                  "Cancel",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}