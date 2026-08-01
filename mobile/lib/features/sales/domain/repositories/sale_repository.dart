import '../entities/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getSales();

  Future<void> addSale(Sale sale);

  Future<void> deleteSale(String id);
}