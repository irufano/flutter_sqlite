import 'package:flutter_sqlite/src/resources/providers/api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<dynamic> fetchAnimeUpcoming() async =>
      _apiProvider.fetchAnimeUpcoming();
}