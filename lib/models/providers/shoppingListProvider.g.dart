// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingListProvider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListProvider _$ShoppingListProviderFromJson(Map json) {
  return ShoppingListProvider(
    localShoppingListItems: (json['localShoppingListItems'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingListItem.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    shoppingFriends: (json['shoppingFriends'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingFriend.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    recentItems:
        (json['recentItems'] as List)?.map((e) => e as String)?.toList(),
    doesExist: json['doesExist'] as bool,
  );
}

Map<String, dynamic> _$ShoppingListProviderToJson(
        ShoppingListProvider instance) =>
    <String, dynamic>{
      'doesExist': instance.doesExist,
      'localShoppingListItems': instance.localShoppingListItems,
      'shoppingFriends': instance.shoppingFriends,
      'recentItems': instance.recentItems,
    };
