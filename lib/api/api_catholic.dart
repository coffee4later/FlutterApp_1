import 'package:flutter_application_1/models/SeriesDAO.dart';
import 'package:async/async.dart';
import 'package:flutter_application_1/utils/strings_app.dart';
import 'package:dio/dio.dart';

class ApiCatholic {

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<SeriesDao>> getSeries(int id) async {
    final response = await dio.get(
      AppStrings().apiUrlBase + "/json/categories/$id.json",
    );

    final res = response.data['series'] as List;
    return res.map((e) => SeriesDao.fromJson(e)).toList();  

  }

  Future<List<List<SeriesDao>>> getAllCategories() async {
    final FutureGroup<List<SeriesDao>> futureGroup = FutureGroup();
    futureGroup.add(getSeries(1));
    futureGroup.add(getSeries(2));
    futureGroup.add(getSeries(3));
    futureGroup.add(getSeries(4));
    futureGroup.add(getSeries(5));

    futureGroup.close();

    final List<List<SeriesDao>> result = await futureGroup.future;
    return result;
  }
}
