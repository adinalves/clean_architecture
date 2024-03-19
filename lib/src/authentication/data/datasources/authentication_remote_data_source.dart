import 'package:tutor4you/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSrc implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrc(this._client);
  final http.Client _client;
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // 1. Check to make sure that it returns the right data when the response
    // code is 200 or proper response code
    // 2. Check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right message when status code is the bad one
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
