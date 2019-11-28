// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingFriend _$ShoppingFriendFromJson(Map<String, dynamic> json) {
  return ShoppingFriend(
    friendName: json['friendName'] as String,
    numberOfChanges: json['numberOfChanges'] as int,
  );
}

Map<String, dynamic> _$ShoppingFriendToJson(ShoppingFriend instance) =>
    <String, dynamic>{
      'friendName': instance.friendName,
      'numberOfChanges': instance.numberOfChanges,
    };
