import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty/model/heroes.dart';
import 'package:rick_morty/utils/debugging_util.dart';

class WebService {
  static final WebService _singleton = WebService._internal();

  factory WebService() {
    return _singleton;
  }

  WebService._internal();

  Dio _dio = GetIt.instance.get<Dio>();

  void updateDio(Dio dio) {
    _dio = dio;
  }

  Future<List<Hero>> getHeroes() async {
    try {
      final response =
          await _dio.get('https://rickandmortyapi.com/api/character');
      dPrint(response, 'getHero: ');

      return heroFromJson(response.data['results']);
    } on DioError catch (e) {
      dPrint(e.message, 'getHeroError: ');
      return Future.error(e);
    }
  }
// Future<void> getCatImage() async {
//   try {
//     final response = await _dio.get('https://cataas.com/cat');
//     dPrint(response);
//     return response.data;
//   } on DioError catch (e) {
//     dPrint(e);
//     return Future.error(e);
//   }
// }

}
