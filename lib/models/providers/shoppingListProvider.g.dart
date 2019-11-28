// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingListProvider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListProvider _$ShoppingListProviderFromJson(Map<String, dynamic> json) {
  return ShoppingListProvider(
    localShoppingListItems: (json['localShoppingListItems'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingListItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    shoppingFriends: (json['shoppingFriends'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingFriend.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ShoppingListProviderToJson(
        ShoppingListProvider instance) =>
    <String, dynamic>{
      'localShoppingListItems': instance.localShoppingListItems,
      'shoppingFriends': instance.shoppingFriends,
    };
