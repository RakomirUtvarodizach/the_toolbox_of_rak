import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_item.g.dart';

@JsonSerializable()
class ShoppingListItem {
  String title, description, type;
  int priority;
  bool checked;

/*
  List<String> _types = ["food", "chemicals", "cosmetics", "clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
 */

  ShoppingListItem(
      {this.title = "Dummy Title",
      this.description = "Some dummy lorem ipsum description here.",
      this.type = "Clothes",
      this.priority = 1,
      this.checked: false});

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemToJson(this);
}
