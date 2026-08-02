import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasource/supplier_local_datasource.dart';
import '../../data/repositories/supplier_repository_impl.dart';

import '../../domain/entities/supplier.dart';

import '../../domain/usecases/add_supplier_usecase.dart';
import '../../domain/usecases/delete_supplier_usecase.dart';
import '../../domain/usecases/get_suppliers_usecase.dart';
import '../../domain/usecases/update_supplier_usecase.dart';

class SuppliersProvider extends ChangeNotifier {
  SuppliersProvider() {
    _repository = SupplierRepositoryImpl(
      SupplierLocalDataSource(),
    );

    _getSuppliersUseCase =
        GetSuppliersUseCase(_repository);

    _addSupplierUseCase =
        AddSupplierUseCase(_repository);

    _updateSupplierUseCase =
        UpdateSupplierUseCase(_repository);

    _deleteSupplierUseCase =
        DeleteSupplierUseCase(_repository);
  }

  late final SupplierRepositoryImpl _repository;

  late final GetSuppliersUseCase _getSuppliersUseCase;

  late final AddSupplierUseCase _addSupplierUseCase;

  late final UpdateSupplierUseCase _updateSupplierUseCase;

  late final DeleteSupplierUseCase _deleteSupplierUseCase;

  final List<Supplier> _suppliers = [];

  bool _loading = false;

  String _search = "";

  bool get loading => _loading;

  List<Supplier> get suppliers {
    if (_search.isEmpty) {
      return _suppliers;
    }

    return _suppliers.where((supplier) {
      return supplier.name
              .toLowerCase()
              .contains(_search.toLowerCase()) ||
          supplier.phone.contains(_search);
    }).toList();
  }

  Future<void> loadSuppliers() async {
    _loading = true;
    notifyListeners();

    _suppliers
      ..clear()
      ..addAll(
        await _getSuppliersUseCase(),
      );

    _loading = false;
    notifyListeners();
  }

  void search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> addSupplier({
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    final supplier = Supplier(
      id: const Uuid().v4(),
      name: name,
      phone: phone,
      address: address,
      email: email,
    );

    await _addSupplierUseCase(supplier);

    await loadSuppliers();
  }

  Future<void> updateSupplier(
    Supplier supplier,
  ) async {
    await _updateSupplierUseCase(supplier);

    await loadSuppliers();
  }

  Future<void> deleteSupplier(
    String id,
  ) async {
    await _deleteSupplierUseCase(id);

    await loadSuppliers();
  }
}