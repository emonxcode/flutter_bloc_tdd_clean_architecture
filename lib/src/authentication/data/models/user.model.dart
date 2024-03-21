import 'dart:convert';
import 'package:bloc_clean_architecture_tdd_solid/core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          id: '0',
          createdAt: '_empty.string',
          avatar: '_empty.string',
          name: '_empty.string',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap json)
      : this(
          id: json['id'] as String,
          createdAt: json['created_at'] as String,
          name: json['name'] as String,
          avatar: json['avatar'] as String,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'id': id,
        'created_at': createdAt,
        'name': name,
        'avatar': avatar,
      };

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
