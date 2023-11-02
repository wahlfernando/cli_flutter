import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/courses_model.dart';

class ProductRepository {
  Future<CoursesModel> findByName(String name) async {
    final resposnse =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (resposnse.statusCode != 200) {
      throw Exception();
    }
    final responseData = jsonDecode(resposnse.body);

    if (responseData.isEmpty) {
      throw Exception('Produto não enontrado');
    }

    return CoursesModel.fromMap(responseData.first);
  }
}
