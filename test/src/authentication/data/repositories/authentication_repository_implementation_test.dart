import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutor4you/core/erros/exceptions.dart';
import 'package:tutor4you/core/erros/failure.dart';
import 'package:tutor4you/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tutor4you/src/authentication/data/models/user_model.dart';
import 'package:tutor4you/src/authentication/data/repositories/authentication_repository_implementation.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImp;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImp = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    const createdAt = 'whatever.createAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test(
        'should call the [RemoteDataSource.createUsesr] and complete sucessfully when call to the remote source is sucessful',
        () async {
      // Arrange
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repoImp.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      // Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'shoud return a [ServerFailure] when the call to the remote source is unsucessfull ',
        () async {
      // Arrange
      when(() => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'))).thenThrow(
        const ApiException(message: 'Unknown Error Occured', statusCode: 500),
      );
      // Act
      final result = await repoImp.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      // Assert
      expect(
        result,
        equals(
          const Left(
            ApiFailure(
              message: 'Unknown Error Occured',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    const tUser = UserModel.empty();
    const tList = [tUser];
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>] when call to the remote source is sucessful',
        () async {
      // Arrange
      when(() => remoteDataSource.getUsers())
          .thenAnswer((_) async => Future.value(tList));

      // Act

      final result = await repoImp.getUsers();
      // Assert
      expect(result, equals(Right(tList)));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source is unsucessful',
        () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenThrow(
        const ApiException(message: 'Unknown Error Occured', statusCode: 500),
      );

      // Act

      final result = await repoImp.getUsers();

      // Assert
      expect(
        result,
        equals(
          const Left(
            ApiFailure(
              message: 'Unknown Error Occured',
              statusCode: 500,
            ),
          ),
        ),
      );

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
