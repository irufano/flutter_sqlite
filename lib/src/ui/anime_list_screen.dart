import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/blocs/anime_bloc.dart';
import 'package:flutter_sqlite/src/models/anime_response.dart';

class AnimeListScreen extends StatefulWidget {
  @override
  _AnimeListScreenState createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  final AnimeBloc _animeBloc = AnimeBloc();

  @override
  void initState() {
    _checkConectivity();
    super.initState();
  }

  _checkConectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _animeBloc.fetchAnimeUpcomingLocal();
    } else {
      _animeBloc.fetchAnimeUpcoming();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Upcoming Anime'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Top>>(
          stream: _animeBloc.animes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              for (var anime in snapshot.data) {
                _animeBloc.addAnime(anime);
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              snapshot.data[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 8.0),
                                      child: Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          snapshot.data[index].startDate != null
                                              ? snapshot.data[index].startDate
                                              : '-'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          snapshot.data[index].type != null
                                              ? snapshot.data[index].type
                                              : '-'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          snapshot.data[index].rank != null
                                              ? 'Rank : ' +
                                                  snapshot.data[index].rank
                                                      .toString()
                                              : 'Rank : -'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
