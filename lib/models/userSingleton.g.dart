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
    shoppingListProvider: json['shoppingListProvider'],
  );
}

Map<String, dynamic> _$UserSingletonToJson(UserSingleton instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isVerified': instance.isVerified,
      'shoppingListProvider': instance.shoppingListProvider,
    };
