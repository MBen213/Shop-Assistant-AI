import '../entities/purchase.dart';
import '../repositories/purchase_repository.dart';

class GetPurchasesUseCase {
  final PurchaseRepository repository;

  GetPurchasesUseCase(this.repository);

  Future<List<Purchase>> call() {
    return repository.getPurchases();
  }
}