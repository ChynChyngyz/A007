import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000/auth/",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
}
