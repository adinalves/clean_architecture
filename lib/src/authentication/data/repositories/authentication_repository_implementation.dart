import 'package:dartz/dartz.dart';
import 'package:tutor4you/core/erros/exceptions.dart';
import 'package:tutor4you/core/erros/failure.dart';
import 'package:tutor4you/core/utils/typedef.dart';
import 'package:tutor4you/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tutor4you/src/authentication/domain/entities/user.dart';
import 'package:tutor4you/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;
  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // Test-Driven Development (TDD)
    // call the remote data source
    // make sure that it return the proper data if there is no exception
    // check if the method return the proper data
    // check if when the remoteDataSource throws an exception, we return a
    // failure and if it doesn't throw an exception, we return the actual
    // expected data
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final users = await _remoteDataSource.getUsers();
      return Right(users);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
