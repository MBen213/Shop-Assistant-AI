import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../products/data/datasource/product_remote_datasource.dart';
import '../../../products/data/repositories/product_repository_impl.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/usecases/get_products_usecase.dart';

import '../../data/datasource/sale_local_datasource.dart';
import '../../data/repositories/sale_repository_impl.dart';

import '../../domain/entities/sale.dart';
import '../../domain/entities/sale_item.dart';

import '../../domain/usecases/add_sale_usecase.dart';
import '../../domain/usecases/get_sales_usecase.dart';


class SalesProvider extends ChangeNotifier {

  SalesProvider() {

    _productRepository = ProductRepositoryImpl(
      ProductRemoteDataSource(),
    );

    _getProductsUseCase = GetProductsUseCase(
      _productRepository,
    );


    _saleRepository = SaleRepositoryImpl(
      SaleLocalDataSource(),
    );


    _addSaleUseCase = AddSaleUseCase(
      _saleRepository,
    );


    _getSalesUseCase = GetSalesUseCase(
      _saleRepository,
    );
  }


  late final ProductRepositoryImpl _productRepository;

  late final GetProductsUseCase _getProductsUseCase;


  late final SaleRepositoryImpl _saleRepository;

  late final AddSaleUseCase _addSaleUseCase;

  late final GetSalesUseCase _getSalesUseCase;



  final List<Product> _products = [];

  final List<Product> _filteredProducts = [];


  final List<SaleItem> _cart = [];

  final List<Sale> _sales = [];



  bool _isLoading = false;

  bool _isHistoryLoading = false;


  String _searchQuery = '';



  bool get isLoading => _isLoading;


  bool get isHistoryLoading =>
      _isHistoryLoading;



  List<Product> get products =>
      List.unmodifiable(_filteredProducts);



  List<SaleItem> get cart =>
      List.unmodifiable(_cart);



  List<Sale> get sales =>
      List.unmodifiable(_sales);



  String get searchQuery =>
      _searchQuery;



  int get cartItemsCount =>
      _cart.length;



  double get total =>
      _cart.fold(
        0,
        (sum, item) =>
            sum + item.subtotal,
      );



  //==============================
  // PRODUCTS
  //==============================


  Future<void> loadProductsFromDatabase() async {

    _isLoading = true;

    notifyListeners();


    _products
      ..clear()
      ..addAll(
        await _getProductsUseCase(),
      );


    _products.sort(
      (a,b)=>
          a.name.compareTo(b.name),
    );


    _applySearch();


    _isLoading = false;

    notifyListeners();
  }



  void searchProducts(String value){

    _searchQuery =
        value.trim();


    _applySearch();


    notifyListeners();
  }



  void clearSearch(){

    _searchQuery='';

    _applySearch();

    notifyListeners();
  }



  void _applySearch(){

    _filteredProducts.clear();


    if(_searchQuery.isEmpty){

      _filteredProducts.addAll(
        _products,
      );

      return;
    }



    _filteredProducts.addAll(

      _products.where(

        (product)=>

          product.name
              .toLowerCase()
              .contains(
                _searchQuery.toLowerCase(),
              )

          ||

          product.barcode
              .toLowerCase()
              .contains(
                _searchQuery.toLowerCase(),
              ),

      ),

    );

  }




  //==============================
  // SALES HISTORY
  //==============================


  Future<void> loadSales() async {


    _isHistoryLoading = true;

    notifyListeners();



    _sales

      ..clear()

      ..addAll(
        await _getSalesUseCase(),
      );



    _sales.sort(

      (a,b)=>
          b.createdAt.compareTo(
            a.createdAt,
          ),

    );



    _isHistoryLoading = false;


    notifyListeners();

  }



  Future<void> refreshHistory() async {

    await loadSales();

  }



  Future<void> deleteSale(
      String saleId
  ) async {


    await _saleRepository.deleteSale(
      saleId,
    );


    _sales.removeWhere(
      (sale)=>
          sale.id == saleId,
    );


    notifyListeners();

  }





  //==============================
  // CART
  //==============================



  void addToCart(Product product){


    final index =
        _cart.indexWhere(
          (e)=>
              e.productId ==
              product.id,
        );



    if(index == -1){


      if(product.quantity <=0){
        return;
        }



      _cart.add(

        SaleItem(

          productId: product.id,

          productName: product.name,

          price: product.sellingPrice,

          quantity: 1,

        ),

      );

    }

    else{


      if(
        _cart[index].quantity >=
        product.quantity
      ){

        return;

      }



      _cart[index] =
          _cart[index].copyWith(

            quantity:
              _cart[index].quantity + 1,

          );

    }



    notifyListeners();

  }





  void increaseQuantity(
      SaleItem item
  ){

    final index =
        _cart.indexWhere(
          (e)=>
              e.productId ==
              item.productId,
        );



    if(index == -1){
      return;
      }



    final product =
        _products.firstWhere(
          (p)=>
              p.id ==
              item.productId,
        );



    if(
      _cart[index].quantity >=
      product.quantity
    ){

      return;

    }



    _cart[index] =
        _cart[index].copyWith(

          quantity:
            _cart[index].quantity + 1,

        );



    notifyListeners();

  }





  void decreaseQuantity(
      SaleItem item
  ){


    final index =
        _cart.indexWhere(
          (e)=>
              e.productId ==
              item.productId,
        );



    if(index == -1){
      return;
      }


    if(
      _cart[index].quantity == 1
    ){

      _cart.removeAt(index);

    }

    else{


      _cart[index] =
          _cart[index].copyWith(

            quantity:
              _cart[index].quantity - 1,

          );

    }



    notifyListeners();

  }





  void removeItem(
      SaleItem item
  ){

    _cart.removeWhere(

      (e)=>
          e.productId ==
          item.productId,

    );


    notifyListeners();

  }




  void clearCart(){

    _cart.clear();

    notifyListeners();

  }






  //==============================
  // COMPLETE SALE
  //==============================



  Future<Sale?> completeSale() async {


    if(_cart.isEmpty){
      return null;
      }

    final sale =
        Sale(

          id:
              const Uuid().v4(),

          items:
              List.from(_cart),

          total:
              total,

          createdAt:
              DateTime.now(),

        );



    await _addSaleUseCase(
      sale,
    );



    clearCart();



    await loadProductsFromDatabase();


    await loadSales();



    return sale;

  }


}