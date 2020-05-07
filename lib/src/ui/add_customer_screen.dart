import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/blocs/one_to_many_bloc.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Customer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: oneToManyBloc.customerNameChanged,
              decoration: InputDecoration(
                labelText: 'Customer Name',
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: double.infinity,
          child: RaisedButton(
              color: Colors.purple,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var result = await oneToManyBloc.addCustomer();
                if (result != 0) {
                  await oneToManyBloc.fetchCustomerLocal();
                  Navigator.pop(buildContext);
                } else {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Gagal Menambahkan Customer', textAlign: TextAlign.center,),
                        
                      ));
                }
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
