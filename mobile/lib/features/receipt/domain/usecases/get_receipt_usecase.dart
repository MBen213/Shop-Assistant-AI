import '../entities/receipt.dart';
import '../repositories/receipt_repository.dart';

class GetReceiptUseCase {
  final ReceiptRepository repository;

  GetReceiptUseCase(
    this.repository,
  );

  Future<Receipt?> call(
    String saleId,
  ) {
    return repository.getReceipt(
      saleId,
    );
  }
}