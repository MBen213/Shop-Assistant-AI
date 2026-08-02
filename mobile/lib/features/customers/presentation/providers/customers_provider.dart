import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasource/customer_local_datasource.dart';
import '../../data/repositories/customer_repository_impl.dart';

import '../../domain/entities/customer.dart';

import '../../domain/usecases/add_customer_usecase.dart';
import '../../domain/usecases/delete_customer_usecase.dart';
import '../../domain/usecases/get_customers_usecase.dart';
import '../../domain/usecases/update_customer_usecase.dart';

class CustomersProvider extends ChangeNotifier {
  CustomersProvider() {
    _repository = CustomerRepositoryImpl(
      CustomerLocalDataSource(),
    );

    _getCustomersUseCase =
        GetCustomersUseCase(_repository);

    _addCustomerUseCase =
        AddCustomerUseCase(_repository);

    _updateCustomerUseCase =
        UpdateCustomerUseCase(_repository);

    _deleteCustomerUseCase =
        DeleteCustomerUseCase(_repository);
  }

  late final CustomerRepositoryImpl _repository;

  late final GetCustomersUseCase _getCustomersUseCase;

  late final AddCustomerUseCase _addCustomerUseCase;

  late final UpdateCustomerUseCase _updateCustomerUseCase;

  late final DeleteCustomerUseCase _deleteCustomerUseCase;

  final List<Customer> _customers = [];

  final List<Customer> _filteredCustomers = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Customer> get customers =>
      List.unmodifiable(_customers);

  List<Customer> get filteredCustomers =>
      List.unmodifiable(_filteredCustomers);

  Future<void> loadCustomers() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getCustomersUseCase();

    _customers
      ..clear()
      ..addAll(result);

    _filteredCustomers
      ..clear()
      ..addAll(result);

    _isLoading = false;
    notifyListeners();
  }

  void search(String value) {
    if (value.trim().isEmpty) {
      _filteredCustomers
        ..clear()
        ..addAll(_customers);
    } else {
      final keyword = value.toLowerCase();

      _filteredCustomers
        ..clear()
        ..addAll(
          _customers.where(
            (customer) =>
                customer.name
                    .toLowerCase()
                    .contains(keyword) ||
                customer.phone.contains(keyword),
          ),
        );
    }

    notifyListeners();
  }

  Future<void> addCustomer({
    required String name,
    required String phone,
    String? address,
    String? notes,
  }) async {
    final customer = Customer(
      id: const Uuid().v4(),
      name: name,
      phone: phone,
      address: address,
      notes: notes,
      debt: 0,
    );

    await _addCustomerUseCase(customer);

    await loadCustomers();
  }

  Future<void> updateCustomer(
    Customer customer,
  ) async {
    await _updateCustomerUseCase(customer);

    await loadCustomers();
  }

  Future<void> deleteCustomer(
    String id,
  ) async {
    await _deleteCustomerUseCase(id);

    await loadCustomers();
  }
}