// features/auth/data/repositories/auth_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:front/features/auth/domain/entities/user.dart';
import 'package:front/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:front/features/auth/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthRepositoryImpl implements IAuthRepository {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  AuthRepositoryImpl(this._dio);

  @override
  Future<User> login(String email, String password) async {
    final response = await _dio.post(
      "login/",
      data: {
        "email": email,
        "password": password,
      },
    );

    final access = response.data["access"];
    final refresh = response.data["refresh"];

    await _storage.write(key: "access", value: access);
    await _storage.write(key: "refresh", value: refresh);

    _dio.options.headers["Authorization"] = "Bearer $access";

    final userRes = await _dio.get("current_user/");

    return UserModel.fromJson(userRes.data);
  }

  @override
  Future<void> register(String email, String password) async {
    await _dio.post(
      "register/",
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}
