import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/ui/anime_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          'Menu',
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
              child: Text('Upcoming Anime', style: TextStyle(color: Colors.white),),
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
