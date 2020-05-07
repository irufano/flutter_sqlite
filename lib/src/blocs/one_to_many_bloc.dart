import 'package:flutter_sqlite/src/database/db_provider.dart';
import 'package:flutter_sqlite/src/models/customer.dart';
import 'package:rxdart/rxdart.dart';

class OneToManyBloc {
  DBProvider _dbProvider = new DBProvider();

  final _listCustomerController = BehaviorSubject<List<Customer>>();

  final _customerNameController = BehaviorSubject<String>();

  Stream<List<Customer>> get customers => _listCustomerController.stream;

  Function(String) get customerNameChanged => _customerNameController.sink.add;

  Future<dynamic> fetchCustomerLocal() async {
    var customer = await _dbProvider.getAllCustomer();
    _listCustomerController.sink.add(customer);
  }

  Future<dynamic> addCustomer() async {
    var result;
    var db = DBProvider();

    var customer = Customer(
      name: _customerNameController.value,
    );

    result = await db.addCustomer(customer);

    

    return result;
  }

  Future<dynamic> deleteCustomer(int id) async {
    var db = DBProvider();
    var result = await db.deleteCustomer(id);

    return result;
  }

  void dispose() {
    _listCustomerController.close();
    _customerNameController.close();
  }
}

final OneToManyBloc oneToManyBloc = OneToManyBloc();
