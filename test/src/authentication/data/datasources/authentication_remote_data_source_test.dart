import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tutor4you/core/erros/exceptions.dart';
import 'package:tutor4you/core/utils/constants.dart';
import 'package:tutor4you/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tutor4you/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;
  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrc(client);
    registerFallbackValue(Uri());
  });
  group('createUser', () {
    test('should complety sucessfully when status code is 200 or 201',
        () async {
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response('User created  sucessfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndPoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
        () => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          const ApiException(message: 'Invalid email address', statusCode: 400),
        ),
      );

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndPoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUser', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<User>] when the status is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          jsonEncode([tUsers.first.toMap()]),
          200,
        ),
      );

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(
            kBaseUrl,
            kGetUserEndPoint,
          ))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      const tMessage = 'Server down' 'MayDay' 'MayDay';
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          tMessage,
          500,
        ),
      );

      final methodCall = remoteDataSource.getUsers;

      expect(
        () => methodCall(),
        throwsA(
          const ApiException(message: tMessage, statusCode: 500),
        ),
      );

      verify(() => client.get(Uri.https(
            kBaseUrl,
            kGetUserEndPoint,
          ))).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
