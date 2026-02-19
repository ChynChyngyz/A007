// features/auth/domain/repositories/i_auth_repository.dart

import 'package:front/features/auth/domain/entities/user.dart';

abstract class IAuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(String email, String password);
}