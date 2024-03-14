import 'dart:convert';

import 'package:tutor4you/core/utils/typedef.dart';
import 'package:tutor4you/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.createdAt,
    required super.avatar,
    required super.id,
    required super.name,
  });
  UserModel.fromMap(DataMap map)
      : this(
          createdAt: map['createdAt'] as String,
          avatar: map['avatar'] as String,
          id: map['id'] as String,
          name: map['name'] as String,
        );

  const UserModel.empty()
      : this(
          id: "1",
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() => {
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
        'id': id,
      };

  String toJson() => jsonEncode(toMap());

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
