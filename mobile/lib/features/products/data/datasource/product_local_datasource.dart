import '../models/product_model.dart';
import '../../../../core/database/dao/products_dao.dart';

class ProductLocalDataSource {
  ProductLocalDataSource(this._productsDao);

  final ProductsDao _productsDao;

  Future<List<ProductModel>> getProducts() async {
    final result = await _productsDao.getAll();

    return result
        .map((e) => ProductModel.fromMap(e))
        .toList();
  }

  Future<void> addProduct(
    ProductModel product,
  ) async {
    await _productsDao.insert(
      product.toMap(),
    );
  }

  Future<void> updateProduct(
    ProductModel product,
  ) async {
    await _productsDao.update(
      product.toMap(),
    );
  }

  Future<void> deleteProduct(
    String id,
  ) async {
    await _productsDao.delete(id);
  }

  Future<ProductModel?> getById(
    String id,
  ) async {
    final result = await _productsDao.getById(id);

    if (result == null) {
      return null;
    }

    return ProductModel.fromMap(result);
  }

  Future<ProductModel?> getByBarcode(
    String barcode,
  ) async {
    final result =
        await _productsDao.getByBarcode(barcode);

    if (result == null) {
      return null;
    }

    return ProductModel.fromMap(result);
  }

  Future<List<ProductModel>> search(
    String keyword,
  ) async {
    final result =
        await _productsDao.search(keyword);

    return result
        .map((e) => ProductModel.fromMap(e))
        .toList();
  }
}