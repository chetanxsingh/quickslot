import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000",
      headers: {"X-User-Id": "1"},
    ),
  );
}
