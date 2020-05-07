import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/ui/anime_list_screen.dart';
import 'package:flutter_sqlite/src/ui/customer_list_screen.dart';

class OneToManyScreen extends StatefulWidget {
  @override
  _OneToManyScreenState createState() => _OneToManyScreenState();
}

class _OneToManyScreenState extends State<OneToManyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Example One To Many',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            height: 60,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text('Customer', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CustomerListScreen()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            height: 60,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text('Order', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AnimeListScreen()));
              },
            ),
          )
        ],
      ),
    );
  }
}
