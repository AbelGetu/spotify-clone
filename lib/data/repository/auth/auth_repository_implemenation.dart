import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImplemenation extends AuthRepository {
  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }

  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    return await sl<AuthFirebaseService>().signin(signinUserRequest);
  }
}
