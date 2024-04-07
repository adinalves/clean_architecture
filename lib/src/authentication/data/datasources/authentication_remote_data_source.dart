import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tutor4you/core/erros/exceptions.dart';
import 'package:tutor4you/core/utils/constants.dart';
import 'package:tutor4you/core/utils/typedef.dart';
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

const kCreateUserEndPoint = '/api/users';
const kGetUserEndPoint = '/api/users';

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
    try {
      final response =
          await _client.post(Uri.https(kBaseUrl, kCreateUserEndPoint),
              body: jsonEncode(
                {
                  'createdAt': createdAt,
                  'name': name,
                  'avatar': avatar,
                },
              ),
              headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kGetUserEndPoint),
      );

      if (response.statusCode != 200) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
