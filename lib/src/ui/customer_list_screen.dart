import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/blocs/one_to_many_bloc.dart';
import 'package:flutter_sqlite/src/models/customer.dart';
import 'package:flutter_sqlite/src/ui/add_customer_screen.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    oneToManyBloc.fetchCustomerLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('List of Customer'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Customer>>(
          stream: oneToManyBloc.customers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('Kosong'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].name),
                        subtitle: Text('ID : ' +
                            snapshot.data[index].customerId.toString()),
                        trailing: IconButton(
                          color: Colors.pink,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              oneToManyBloc.deleteCustomer(
                                  snapshot.data[index].customerId);
                              oneToManyBloc.fetchCustomerLocal();
                            }),
                      );
                    });
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              return SizedBox();
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddCustomerScreen()));
          }),
    );
  }
}
