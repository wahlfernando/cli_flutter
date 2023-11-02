import 'package:dio/dio.dart';
import '../models/courses_model.dart';

class ProductDioRepository {
  Future<CoursesModel> findByName(String name) async {
    try {
      final resposnse =
          await Dio().get('http://localhost:8080/products', queryParameters: {"name": name});

      if (resposnse.data.isEmpty) {
        throw Exception('Produto não enontrado');
      }

      return CoursesModel.fromMap(resposnse.data.first);
    } on DioException {
      throw Exception();
    }
  }
}
