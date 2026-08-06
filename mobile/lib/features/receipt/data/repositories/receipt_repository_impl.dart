import '../../domain/entities/receipt.dart';
import '../../domain/repositories/receipt_repository.dart';

import '../datasource/receipt_local_datasource.dart';

class ReceiptRepositoryImpl
    implements ReceiptRepository {
  final ReceiptLocalDataSource localDataSource;

  ReceiptRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<Receipt?> getReceipt(
    String saleId,
  ) async {
    return await localDataSource.getReceipt(
      saleId,
    );
  }
}