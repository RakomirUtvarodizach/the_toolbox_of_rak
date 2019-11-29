// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSingleton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSingleton _$UserSingletonFromJson(Map<String, dynamic> json) {
  return UserSingleton(
    uid: json['uid'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    isVerified: json['isVerified'] as bool,
    imageURL: json['imageURL'] as String,
    shoppingListProvider: json['shoppingListProvider'] == null
        ? null
        : ShoppingListProvider.fromJson(
            json['shoppingListProvider'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserSingletonToJson(UserSingleton instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isVerified': instance.isVerified,
      'imageURL': instance.imageURL,
      'shoppingListProvider': instance.shoppingListProvider,
    };
