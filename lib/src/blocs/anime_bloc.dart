import 'package:flutter_sqlite/src/database/db_provider.dart';
import 'package:flutter_sqlite/src/models/anime_response.dart';
import 'package:flutter_sqlite/src/resources/repositories/api_repository.dart';
import 'package:rxdart/rxdart.dart';

class AnimeBloc {
  DBProvider _dbProvider = new DBProvider();
  final _apiRepository = ApiRepository();

  final _listAnimeController = BehaviorSubject<List<Top>>();

  Stream<List<Top>> get animes => _listAnimeController.stream;

  Future<dynamic> fetchAnimeUpcoming() async {
    var response = await _apiRepository.fetchAnimeUpcoming();

    if (response != null && response != "error") {
      _listAnimeController.sink.add(response.top);
    } else {
      _listAnimeController.sink.addError("error");
    }
  }

  Future<dynamic> fetchAnimeUpcomingLocal() async {
    var anime = await _dbProvider.getAllAnimes();
    _listAnimeController.sink.add(anime);
  }

  Future<dynamic> addAnime(Top data) async {
    var result;
    var db = DBProvider();

    var anime = Top(
      malId: data.malId,
      rank: data.rank,
      title: data.title,
      url: data.url,
      imageUrl: data.imageUrl,
      type: data.type,
      episodes: data.episodes,
      startDate: data.startDate,
      endDate: data.endDate,
      members: data.members,
      score: data.score,
    );

    result = await db.addAnime(anime);

    print('Berhasil insert db local : ' + result.toString());
  }

  void dispose() {
    _listAnimeController.close();
  }
}
