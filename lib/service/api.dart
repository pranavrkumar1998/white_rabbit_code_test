import 'dart:convert';
import 'package:dio/dio.dart';

class API {
  static const String BaseUrl = "https://www.mocky.io/v2/";

  static Future<List<dynamic>> getEmployeeDetails() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(BaseUrl + '5d565297300000680030a986');
      print("getEmployeeDetails response => ${response.data}");
      Iterable l = response.data;
      return response.data;
    } catch (e) {
      print("getEmployeeDetails catch => $e");
      return null;
    }
  }
}
