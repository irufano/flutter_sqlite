import 'package:dio/dio.dart';
import 'package:flutter_sqlite/src/helper/api_url.dart';
import 'package:flutter_sqlite/src/models/anime_response.dart';

class ApiProvider {
  Dio client = Dio();

  Future<dynamic> fetchAnimeUpcoming() async {
    Response<String> response;

    try {
      response = await client.get(
        ApiUrl.ANIME_URL,
        options: Options(
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data != "") {
          var dataResponse = animeResponseFromJson(response.data);
          print('success get data!');
          return dataResponse;
        } else {
          print('data is null !');
          return null;
        }
      } else {
        print(
            'failed, response statuscode : ' + response.statusCode.toString());
        return "error";
      }
    } catch (e) {
      print('error with exception : $e');
      return "error";
    }
  }
}
