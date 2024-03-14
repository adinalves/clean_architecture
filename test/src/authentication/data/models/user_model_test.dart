import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tutor4you/core/utils/typedef.dart';
import 'package:tutor4you/src/authentication/data/models/user_model.dart';
import 'package:tutor4you/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of [User] Entity', () {
    // Arrange
    // Act

    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('shoud return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('shoud return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromJson(tJson);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('shoud return a Map with the right data', () {
      // Arrange

      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group('fromJson', () {
    test('shoud return a Json String with the right data', () {
      // Arrange
      final tJson = jsonEncode({
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "id": "1"
      });
      // Act
      final result = tModel.toJson();
      // Assert
      expect(result, tJson);
    });
  });

  group('CopyWith', () {
    test('should return a [UserModel] with different data', () {
      // Arrange

      // Act
      final result = tModel.copyWith(name: 'Joao');

      // Assert

      expect(result.name, equals('Joao'));
    });
  });
}
