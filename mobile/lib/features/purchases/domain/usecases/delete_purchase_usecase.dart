import '../repositories/purchase_repository.dart';

class DeletePurchaseUseCase {
  final PurchaseRepository repository;

  DeletePurchaseUseCase(this.repository);

  Future<void> call(
    String id,
  ) {
    return repository.deletePurchase(id);
  }
}