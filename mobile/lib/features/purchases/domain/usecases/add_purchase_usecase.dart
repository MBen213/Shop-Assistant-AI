import '../entities/purchase.dart';
import '../repositories/purchase_repository.dart';

class AddPurchaseUseCase {
  final PurchaseRepository repository;

  AddPurchaseUseCase(this.repository);

  Future<void> call(
    Purchase purchase,
  ) {
    return repository.addPurchase(purchase);
  }
}