import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_item.g.dart';

@JsonSerializable()
class ShoppingListItem {
  String title, description, type;
  int priority;

  @JsonKey(ignore: true)
  bool checked;

  @JsonKey(ignore: true)
  int editState;

/*
  List<String> _types = ["Food", "Chemicals", "Cosmetics", "Clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
 */

  ShoppingListItem(
      {this.title = "Dummy Title",
      this.description = "Some dummy lorem ipsum description here.",
      this.type = "Clothes",
      this.priority = 1,
      this.checked: false,
      this.editState: 0});

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemToJson(this);
}
