import '../entities/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getSales();

  Future<void> completeSale(Sale sale);

  Future<void> deleteSale(String id);
}