// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListItem _$ShoppingListItemFromJson(Map<String, dynamic> json) {
  return ShoppingListItem(
    title: json['title'] as String,
    description: json['description'] as String,
    type: json['type'] as String,
    priority: json['priority'] as int,
    checked: json['checked'] as bool,
  );
}

Map<String, dynamic> _$ShoppingListItemToJson(ShoppingListItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'priority': instance.priority,
      'checked': instance.checked,
    };
