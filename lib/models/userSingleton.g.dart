// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSingleton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSingleton _$UserSingletonFromJson(Map json) {
  return UserSingleton(
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    imageURL: json['imageURL'] as String,
    shoppingListProvider: json['shoppingListProvider'] == null
        ? null
        : ShoppingListProvider.fromJson(
            (json['shoppingListProvider'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$UserSingletonToJson(UserSingleton instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageURL': instance.imageURL,
      'shoppingListProvider': instance.shoppingListProvider,
    };
