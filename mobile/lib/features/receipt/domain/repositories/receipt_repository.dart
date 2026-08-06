import '../entities/receipt.dart';

abstract class ReceiptRepository {
  Future<Receipt?> getReceipt(
    String saleId,
  );
}